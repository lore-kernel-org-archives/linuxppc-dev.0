Return-Path: <jfannin@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 6E83ADDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 05:14:08 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1328800nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 12:14:07 -0700 (PDT)
Date: Tue, 16 Oct 2007 15:14:03 -0400
From: Joseph Fannin <jfannin@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: vga16fb doesn't build on powerpc (vgacon_remap_base)
Message-ID: <20071016191403.GA5962@nineveh.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vga16fb is an available config option on powerpc, but it won't link
with my .config:

    ERROR: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!


I'm guessing this is because include/asm-powerpc/vga.h declares
vgacon_remap_base: 

    extern unsigned long vgacon_remap_base;


...but arch/powerpc/kernel/setup_32.c wraps the definition in an #ifdef:

    #ifdef CONFIG_VGA_CONSOLE
    unsigned long vgacon_remap_base;
    EXPORT_SYMBOL(vgacon_remap_base);
    #endif


So CONFIG_VGA_CONSOLE=n and CONFIG_FB_VGA16=[y|m] won't work.

I've also noticed that the only places in the tree that ever assign
anything to config_remap_base are under arch/ppc.  And
include/asm-powerpc/vga.h also does this:

    #ifdef __powerpc64__
    #define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
    #else
    #define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
    #endif


So VGACON probably doesn't work either on 32bit.  I'm guessing arch/powerpc
doesn't support PREP.

How best could this be fixed up? Or should I just let the thing
be?  This is obviously not a new thing, and I don't have any hardware
that supports this stuff either.

--
Joseph Fannin
jfannin@gmail.com
