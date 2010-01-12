Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1857B7C6A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 23:03:12 +1100 (EST)
In-Reply-To: <20100112140136.c8ccc357.sfr@canb.auug.org.au>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location	of
	autoconf.h
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 12:59:09 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Roel Kluin <roel.kluin@gmail.com>, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Hi Anton,
>
> On Tue, 12 Jan 2010 13:21:51 +1100 Anton Blanchard <anton@samba.org> wrote:
> >
> > commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize inffast when
> > copying direct from output) referenced include/linux/autoconf.h which
> > is now called include/generated/autoconf.h.
>
> Even with this fix, you cannot build with a separate object directory.
> See my other posting "linux-next: origin tree build failure" ...
> --

How does this work for you?

>From 044f40d169bf5fe189d5cb058f56b7cd72675ca4 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 11:20:36 +0100
Subject: [PATCH] powerpc: Fix build breakage due to incorrect location of autoconf.h

commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize inffast when
copying direct from output) referenced include/linux/autoconf.h which
is now called include/generated/autoconf.h.
Also, -I include paths needs to be prefixed with $(srctree)

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/boot/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 826a30a..79ebd6f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -34,8 +34,8 @@ BOOTCFLAGS	+= -fno-stack-protector
 endif

 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
-BOOTCFLAGS	+= -include include/linux/autoconf.h -Iarch/powerpc/include
-BOOTCFLAGS	+= -Iinclude
+BOOTCFLAGS	+= -include include/generated/autoconf.h
+BOOTCFLAGS	+= -I$(srctree)/arch/powerpc/include -I$(srctree)/include

 DTS_FLAGS	?= -p 1024

--
1.6.4.4
