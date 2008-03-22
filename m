Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64940DDF3D
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 06:05:50 +1100 (EST)
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com
	([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1Jd92H-0000kC-U0
	for linuxppc-dev@ozlabs.org; Sat, 22 Mar 2008 15:05:46 -0400
Date: Sat, 22 Mar 2008 15:05:43 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Move a.out.h to header-y since it doesn't check
	__KERNEL__.
Message-ID: <alpine.LFD.1.00.0803221504100.25407@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since a.out.h doesn't check the value of __KERNEL__, there's no point
in unifdef'ing it.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/include/asm-powerpc/Kbuild b/include/asm-powerpc/Kbuild
index 5f640e5..7381916 100644
--- a/include/asm-powerpc/Kbuild
+++ b/include/asm-powerpc/Kbuild
@@ -1,5 +1,6 @@
 include include/asm-generic/Kbuild.asm

+header-y += a.out.h
 header-y += auxvec.h
 header-y += ioctls.h
 header-y += mman.h
@@ -23,7 +24,6 @@ header-y += sigcontext.h
 header-y += statfs.h
 header-y += ps3fb.h

-unifdef-y += a.out.h
 unifdef-y += asm-compat.h
 unifdef-y += bootx.h
 unifdef-y += byteorder.h

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
