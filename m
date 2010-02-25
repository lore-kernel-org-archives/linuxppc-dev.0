Return-Path: <jeffm@suse.com>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id CABF4B7C67
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 05:49:49 +1100 (EST)
Message-ID: <4B86C64A.2050508@suse.com>
Date: Thu, 25 Feb 2010 13:49:46 -0500
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix handling of strnlen with zero len
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>, Christian_Sellars@symantec.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

 Commit 0119536c, which added the assembly version of strncmp to
 powerpc, mentions that it adds two instructions to the version from
 boot/string.S to allow it to handle len=0. Unfortunately, it doesn't
 always return 0 when that is the case. The length is passed in r5, but
 the return value is passed back in r3. In certain cases, this will
 happen to work. Otherwise it will pass back the address of the first
 string as the return value.

 This patch lifts the len <= 0 handling code from memcpy to handle that case.

Reported by: Christian_Sellars@symantec.com
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
- ---
 arch/powerpc/lib/string.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

- --- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -71,7 +71,7 @@ _GLOBAL(strcmp)
 
 _GLOBAL(strncmp)
 	PPC_LCMPI r5,0
- -	beqlr
+	ble-	2f
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
@@ -82,6 +82,8 @@ _GLOBAL(strncmp)
 	beqlr	1
 	bdnzt	eq,1b
 	blr
+2:	li	r3,0
+	blr
 
 _GLOBAL(strlen)
 	addi	r4,r3,-1
- -- 
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkuGxkoACgkQLPWxlyuTD7LzfQCeKAaKtyEfbabuGzZyAEEnb8Mq
KEsAn1tKZtVSQ2A68TjwU/JN2LC3Mop7
=/CaR
-----END PGP SIGNATURE-----
