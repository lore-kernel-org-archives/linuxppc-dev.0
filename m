From: "dong in kang" <dkang@east.isi.edu>
To: "'Mark A. Greer'" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel parameters (Sandpoint X3 with Altimus MPC755)
Date: Tue, 10 Jun 2003 14:22:32 -0400
Message-ID: <000e01c32f7d$42336db0$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3ECAB014.80902@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 Thank you for your reply to my questions.

 I'm still working on running Linux on Sandpoint. But it still doesn't work.
;( It seems to have problem within sandpoint_setup_winbond_83553(hose).
Right after "Enalbe RTC and Keyboard" using early_write_config_byte() call,
the memory area in 0xFFF00100 is not properly read. It is read all 0xFFs.
Other SDRAM area is read properly, though.
And the kernel can still run up to time_init() routine but never runs
farther than that.

 I'm using MVL version "linux-2.4.17_mvl21".
I changed the sandpoint_find_end_of_memory() to return 128M as is shown
below. The kernel parameter is changed to tell the memory size. I don't use
DINK, but I setup the memory controller at the BDI configuration file such
that 128M bytes is mapped onto bank 0. After the configuraion file is run, I
can read/write all memory area. (I didn't set any PCI related stuff.) Should
I add more kernel parameters or setup some data structures before I call the
zImage.sandpoint.initrd?

 static ulong __init
sandpoint_find_end_of_memory(void)
{
        ulong   size = 0;

#if 0   /* Leave out until DINK sets mem ctlr correctly */
        size = mpc10x_get_mem_size(MPC10X_MEM_MAP_B);
#else
//      size = 32*1024*1024;
        size = 128*1024*1024;   // by DKANG
#endif

        return size;
}

 Thanks,

 Dong-In


-----Original Message-----
From: Mark A. Greer [mailto:mgreer@mvista.com]
Sent: Tuesday, May 20, 2003 6:46 PM
To: dong in kang
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel parameters (Sandpoint X3 with Altimus MPC755)


dong in kang wrote:

> It turns out that BDI has a few different versions.
>BDI for Codewarrior, BDI for GDB, etc.
>I just heard from Codewarrior that BDI for Codewarrior doesn't support
>MMU, which means address translation is not supported. I have to buy
>BDI for GDB.
>
Ah, okay.

> About your question, I downloaded the zImage.initrd at 0x800000. I
>didn't turn on the default command line. Now I turn on the default
>command line as  CONFIG_CMDLINE="mem=128M ramdisk_size=20480
>console=ttyS0,9600 console=tty0 root=/dev/ram init=/bin/sh"
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
