Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5700DDFB7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 05:11:02 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NJAnmb011844
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 15:10:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NJAlnV119300
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 15:10:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NJAlE5012493
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 15:10:47 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6NJAlbM012438
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 15:10:47 -0400
Received: from [9.65.41.135] (sig-9-65-41-135.mts.ibm.com [9.65.41.135])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m6NJAkoX029704
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:10:46 -0500
Message-ID: <48878236.9020605@austin.ibm.com>
Date: Wed, 23 Jul 2008 14:10:46 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove kmalloc call in handling writes to lparcfg
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are only 4 valid name=value pairs for writes to
/proc/ppc64/lparcfg.  Current code allocates a buffer to copy
this information in from the user.  Since the longest name=value
pair will easily fit into a buffer of 64 characters, simply
put the buffer on the stack instead of allocating the buffer.

NOTE: This patch applies on top of the CMO patches.

Signed-off-by: Nathan Fotenot <nfont@austin.ibm.com>
---
Index: linux-2.6.git/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/lparcfg.c	2008-07-22 13:17:40.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/lparcfg.c	2008-07-23 13:40:50.000000000 -0500
@@ -573,29 +573,27 @@
 static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 			     size_t count, loff_t * off)
 {
-	char *kbuf;
+	int kbuf_sz = 64;
+	char kbuf[kbuf_sz];
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr = &new_entitled;
 	u8 new_weight, *new_weight_ptr = &new_weight;
-	ssize_t retval = -ENOMEM;
+	ssize_t retval;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR) ||
 			firmware_has_feature(FW_FEATURE_ISERIES))
 		return -EINVAL;
 
-	kbuf = kmalloc(count, GFP_KERNEL);
-	if (!kbuf)
-		goto out;
+	if (count > kbuf_sz)
+		return -EINVAL;
 
-	retval = -EFAULT;
 	if (copy_from_user(kbuf, buf, count))
-		goto out;
+		return -EFAULT;
 
-	retval = -EINVAL;
 	kbuf[count - 1] = '\0';
 	tmp = strchr(kbuf, '=');
 	if (!tmp)
-		goto out;
+		return -EINVAL;
 
 	*tmp++ = '\0';
 
@@ -603,32 +601,32 @@
 		char *endp;
 		*new_entitled_ptr = (u64) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
-			goto out;
+			return -EINVAL;
 
 		retval = update_ppp(new_entitled_ptr, NULL);
 	} else if (!strcmp(kbuf, "capacity_weight")) {
 		char *endp;
 		*new_weight_ptr = (u8) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
-			goto out;
+			return -EINVAL;
 
 		retval = update_ppp(NULL, new_weight_ptr);
 	} else if (!strcmp(kbuf, "entitled_memory")) {
 		char *endp;
 		*new_entitled_ptr = (u64) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
-			goto out;
+			return -EINVAL;
 
 		retval = update_mpp(new_entitled_ptr, NULL);
 	} else if (!strcmp(kbuf, "entitled_memory_weight")) {
 		char *endp;
 		*new_weight_ptr = (u8) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
-			goto out;
+			return -EINVAL;
 
 		retval = update_mpp(NULL, new_weight_ptr);
 	} else
-		goto out;
+		return -EINVAL;
 
 	if (retval == H_SUCCESS || retval == H_CONSTRAINED) {
 		retval = count;
@@ -644,8 +642,6 @@
 		retval = -EIO;
 	}
 
-out:
-	kfree(kbuf);
 	return retval;
 }
