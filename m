Return-Path: <adaplas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 797ACDDEC0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:32:03 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4800303pyi
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 14:32:02 -0700 (PDT)
Subject: Re: [Linux-fbdev-devel] vga16fb doesn't build on powerpc
	(vgacon_remap_base)
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20071016191403.GA5962@nineveh.local>
References: <20071016191403.GA5962@nineveh.local>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 05:31:54 +0800
Message-Id: <1192570314.15588.11.camel@daplas>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-16 at 15:14 -0400, Joseph Fannin wrote:
> vga16fb is an available config option on powerpc, but it won't link
> with my .config:
> 
>     ERROR: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
> 
> 
> I'm guessing this is because include/asm-powerpc/vga.h declares
> vgacon_remap_base: 
> 
>     extern unsigned long vgacon_remap_base;
> 
> 
> ...but arch/powerpc/kernel/setup_32.c wraps the definition in an #ifdef:
> 
>     #ifdef CONFIG_VGA_CONSOLE

Perhaps #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_FB_VGA16) ?

or

bool VGA_HARDWARE

#if CONFIG_VGA_HARDWARE
    unsigned long vgacon_remap_base;
    EXPORT_SYMBOL(vgacon_remap_base);
#endif

and for the Kconfig entry of vgacon and vga16fb

select VGA_HARDWARE if PPC32
(or depends on (VGA_HARDWARE && PPC32))

Tony
