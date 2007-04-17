Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE709DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 00:55:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3HEtcB2004762
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:55:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3HEtcp3551582
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:55:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3HEtLCD019047
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:55:22 -0400
Subject: [PATCH 2/2] hvc_console typo fixes
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
References: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 17 Apr 2007 09:54:51 -0500
Message-Id: <1176821691.28514.152.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: willschm@linux.vnet.ibm.com
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix a handful of comment typos for hvc_console.


Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index fc9bc77..0f9ed7b 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -102,12 +102,12 @@ static DEFINE_SPINLOCK(hvc_structs_lock)
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
  * upon order of exposure via hvc_probe(), when we can not match it to
- * a console canidate registered with hvc_instantiate().
+ * a console candidate registered with hvc_instantiate().
  */
 static int last_hvc = -1;
 
 /*
- * Do not call this function with either the hvc_strucst_lock or the hvc_struct
+ * Do not call this function with either the hvc_structs_lock or the hvc_struct
  * lock held.  If successful, this function increments the kobject reference
  * count against the target hvc_struct so it should be released when finished.
  */
@@ -160,7 +160,7 @@ void hvc_console_print(struct console *c
 	if (index >= MAX_NR_HVC_CONSOLES)
 		return;
 
-	/* This console adapter was removed so it is not useable. */
+	/* This console adapter was removed so it is not usable. */
 	if (vtermnos[index] < 0)
 		return;
 
@@ -218,7 +218,7 @@ struct console hvc_con_driver = {
 };
 
 /*
- * Early console initialization.  Preceeds driver initialization.
+ * Early console initialization.  Precedes driver initialization.
  *
  * (1) we are first, and the user specified another driver
  * -- index will remain -1
@@ -255,7 +255,7 @@ int hvc_instantiate(uint32_t vtermno, in
 	if (vtermnos[index] != -1)
 		return -1;
 
-	/* make sure no no tty has been registerd in this index */
+	/* make sure no no tty has been registered in this index */
 	hp = hvc_get_by_index(index);
 	if (hp) {
 		kobject_put(&hp->kobj);
@@ -265,7 +265,7 @@ int hvc_instantiate(uint32_t vtermno, in
 	vtermnos[index] = vtermno;
 	cons_ops[index] = ops;
 
-	/* reserve all indices upto and including this index */
+	/* reserve all indices up to and including this index */
 	if (last_hvc < index)
 		last_hvc = index;
 
@@ -526,7 +526,7 @@ static int hvc_write(struct tty_struct *
 
 /*
  * This is actually a contract between the driver and the tty layer outlining
- * how much write room the driver can guarentee will be sent OR BUFFERED.  This
+ * how much write room the driver can guarantee will be sent OR BUFFERED.  This
  * driver MUST honor the return value.
  */
 static int hvc_write_room(struct tty_struct *tty)
@@ -813,7 +813,7 @@ int __devexit hvc_remove(struct hvc_stru
 
 	/*
 	 * We 'put' the instance that was grabbed when the kobject instance
-	 * was intialized using kobject_init().  Let the last holder of this
+	 * was initialized using kobject_init().  Let the last holder of this
 	 * kobject cause it to be removed, which will probably be the tty_hangup
 	 * below.
 	 */
@@ -869,7 +869,7 @@ int __init hvc_init(void)
 }
 module_init(hvc_init);
 
-/* This isn't particularily necessary due to this being a console driver
+/* This isn't particularly necessary due to this being a console driver
  * but it is nice to be thorough.
  */
 static void __exit hvc_exit(void)
