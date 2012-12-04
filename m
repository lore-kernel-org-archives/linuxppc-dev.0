Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67B1E2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 14:05:52 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id x4so3101935obh.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2012 19:05:49 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: [RFC PATCH] powerpc/kexec: Add kexec "hold" support for Book3e
 processors
Date: Mon, 3 Dec 2012 21:05:47 -0600
Message-Id: <B03278DC-EB22-4335-BACD-4C585856ED15@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <kumar.gala@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Motivation:
IBM Blue Gene/Q comes with some very strange firmware that I'm trying to =
get out of using in the kernel.  So instead I spin all the threads in =
the boot wrapper (using the firmware) and have them enter the kexec =
stub, pre-translated at the virtual "linear" address, never touching =
firmware again.
This works strategy works wonderfully, but I need the following patch in =
the kexec stub.
I believe it should not effect Book3S and Book3E does not appear to be =
here yet so I'd love to get any criticisms up front.=20

This patch adds two items:
1) Book3e requires that GPR4 survive the "hold" process, so we make
   sure that happens.
2) Book3e has no real mode, and the hold code exploits this.  Since
   these processors ares always translated, we arrange for the kexeced
   threads to enter the hold code using the normal kernel linear =
mapping.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>
---
 arch/powerpc/kernel/head_64.S |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S =
b/arch/powerpc/kernel/head_64.S
index 58bddee..1b00e95 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -122,6 +122,8 @@ __secondary_hold:
 #endif
 	/* Grab our physical cpu number */
 	mr	r24,r3
+	/* stash r4 for book3e */
+	mr	r25,r4
=20
 	/* Tell the master cpu we're here */
 	/* Relocation is off & we are located at an address less */
@@ -129,16 +131,31 @@ __secondary_hold:
 	std	r24,__secondary_hold_acknowledge-_stext(0)
 	sync
=20
+	li	r26,0
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r26,r26)
+#endif
 	/* All secondary cpus wait here until told to start. */
-100:	ld	r4,__secondary_hold_spinloop-_stext(0)
+100:	ld	r4,__secondary_hold_spinloop-_stext(r26)
 	cmpdi	0,r4,0
 	beq	100b
=20
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r4,r4)
+#endif
 	ld	r4,0(r4)		/* deref function descriptor */
 	mtctr	r4
 	mr	r3,r24
+	/*
+	 * it may be the case that other platforms have r4 right to
+	 * begin with, this gives us some safety in case it is not
+	 */
+#ifdef CONFIG_PPC_BOOK3E
+	mr	r4,r25
+#else
 	li	r4,0
+#endif
 	/* Make sure that patched code is visible */
 	isync
 	bctr
--=20
1.7.1

freakazoid:bgq=20=
