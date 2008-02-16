Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59DD7DDE98
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 04:31:42 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id m1GHVZoY022819
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 23:01:35 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1GHVZLK548936
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 23:01:35 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m1GHVZVx016092
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 17:31:35 GMT
Date: Sat, 16 Feb 2008 23:01:32 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH]2.6.25-rc2-mm1 - Build Failure at security/keys/compat.c on
	powerpc
Message-ID: <20080216173132.GA13326@linux.vnet.ibm.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The 2.6.25-rc2-mm1 kernel build fails on the powerpc(s) 

  CC      security/keys/compat.o
security/keys/compat.c: In function ‘compat_sys_keyctl’:
security/keys/compat.c:83: error: implicit declaration of function ‘keyctl_get_security’
make[2]: *** [security/keys/compat.o] Error 1
make[1]: *** [security/keys] Error 2
make: *** [security] Error 2

The keys-add-keyctl-function-to-get-a-security-label.patch is causing
this build failure.

I have tested the patch for the build failure only

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
--- linux-2.6.25-rc2/security/keys/internal.h	2008-02-17 05:03:30.000000000 +0530
+++ linux-2.6.25-rc2/security/keys/~internal.h	2008-02-17 05:46:16.000000000 +0530
@@ -155,6 +155,8 @@ extern long keyctl_negate_key(key_serial
 extern long keyctl_set_reqkey_keyring(int);
 extern long keyctl_set_timeout(key_serial_t, unsigned);
 extern long keyctl_assume_authority(key_serial_t);
+extern long keyctl_get_security(key_serial_t keyid, char __user *buffer,
+				size_t buflen);
 
 
 /*
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
