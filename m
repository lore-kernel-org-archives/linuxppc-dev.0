Message-ID: <FA06AA2C99BCD511951200005A99441001E3ED4C@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'dan@embeddededge.com'" <dan@embeddededge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 28 Aug 2002 10:08:03 -0700
Subject: RE: 8260/8xx Embedded Boot patch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I'll just check it in right from my tree if it is what you need.  The
>part inside the '#if 0' to hardcode the values still needs to
>be fixed if
>someone actually uses that.  In fact, I'll just fix it and push out the
>change since it will work on all boards depending upon what you want.

I looked at the patch and I have a couple comments:

1. The loop that overwrites the b_enetaddr[] should check that it does not
contain any information before assigning the default. This could have been
passed in by the bios.

2. If you assume that any platform that uses CONFIG_EMBEDDEDBOOT may want to
pass in a bd_info structure, then the platform specific patch in head.S is
wrong. Based on the current architecture I believe this is a safe
assumption. You may totally ignore this parameter in embed_config.c where
the platform dependent code is located.

diff -aru devel_old/arch/ppc/boot/simple/head.S
linuxppc_2_4_devel/arch/ppc/boot/simple/head.S
--- devel_old/arch/ppc/boot/simple/head.S	Wed Aug 28 00:59:37 2002
+++ linuxppc_2_4_devel/arch/ppc/boot/simple/head.S	Wed Aug 28 01:00:12
2002
@@ -59,7 +59,7 @@
 	isync
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6)
+#if defined(CONFIG_EMBEDDEDBOOT)
 	mr	r29,r3	/* On the MBX860, r3 is the board info pointer.
...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
