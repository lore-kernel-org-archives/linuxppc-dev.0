Message-ID: <3ECAB014.80902@mvista.com>
Date: Tue, 20 May 2003 15:45:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dong in kang <dkang@east.isi.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel parameters (Sandpoint X3 with Altimus MPC755)
References: <001a01c31f05$c656f130$45a97241@Minjoo>
In-Reply-To: <001a01c31f05$c656f130$45a97241@Minjoo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dong in kang wrote:

> It turns out that BDI has a few different versions.
>BDI for Codewarrior, BDI for GDB, etc.
>I just heard from Codewarrior that BDI for Codewarrior doesn't support MMU,
>which means address translation is not supported.
>I have to buy BDI for GDB.
>
Ah, okay.

> About your question, I downloaded the zImage.initrd at 0x800000.
>I didn't turn on the default command line. Now I turn on the default command
>line as
> CONFIG_CMDLINE="mem=128M ramdisk_size=20480 console=ttyS0,9600 console=tty0
>root=/dev/ram init=/bin/sh"
>The Sandpoint X3 has 128M ram and my ramdisk size is 20M.
>It should be right, isn't it?
>
Nope.  Unless you have a new version of DINK that is fixed, it doesn't
set up the memory controller correctly for the RAM above 32MB.  There
should be comments indicating this in
arch/ppc/platforms/sandpoint_setup.c:sandpoint_find_end_of_memory() or
some such (since I don't know what version of MVL you're running).

Try it again with only this on your cmdline: "mem=32M" and see if that
helps.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
