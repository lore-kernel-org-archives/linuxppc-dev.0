Message-ID: <39B5764D.C30702A8@mvista.com>
Date: Tue, 05 Sep 2000 15:40:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More Sandpoint woes
References: <20000905213639.B22842@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex, if you're interested, I have a better kernel for you to use.  Its in
ftp://www.mvista.com/pub/Area51/sandpoint-8240/sandpoint.linux.tar.gz

This has IDE support and fixes a bug in the eepro100.c driver for the
sandpoint.

<more comments below>

Mark
--

Alex Shnitman wrote:

> Hi,
>
> I've got the Sandpoint/PPMC7400 to boot the kernel, mount the root
> filesystem via NFS, and try to execute init. By the way, does anyone
> have any idea why if I disable initrd support in the kernel config, it
> doesn't succeed booting via BOOTP -- it times out, but the sniffer
> doesn't even show that it sends any packets to the cable; while if I
> enable initrd support, it just fails to mount the ramdisk, but then
> proceeds to do a network boot all right? I tried it countless times,
> and there's absolutely nothing else causing this -- it's that kernel
> option. Some timing issue perhaps? This really puzzles me, even though
> it's not a show-stopper.

I've never had problems with initrd turned off in the kernel--that's my
normal mode.

>
> In any case, when it tries to execute init it oopses. I've attached
> the full bootlog to this mail, but in any case, here's the ksymoops of
> the first oops:
>
> >>EIP; 00000300 Before first symbol   <=====
> Trace; ffffffea <END_OF_CODE+3bf364df/????>
> Trace; c004b8c4 <load_elf_interp+28c/2d4>
> Trace; c004c148 <load_elf_binary+6e8/950>
> Trace; c003c9e4 <search_binary_handler+5c/160>
> Trace; c003cc54 <do_execve+16c/1fc>
> Trace; c0007218 <sys_execve+70/f0>
> Trace; c0004e34 <ret_from_syscall_1+0/a0>
> Trace; c0003f14 <init+18/1a8>
> Trace; c0009670 <kernel_thread+2c/38>
>
> Here's the ksymoops of the second:
>
> >>EIP; 00000300 Before first symbol   <=====
> Trace; c0007328 <print_backtrace+90/c8>
> Trace; c0005268 <_exception+34/68>
> Trace; c00054b8 <ProgramCheckException+4c/5c>
> Trace; c0005090 <ret_from_except+0/c>
> Trace; ffffffea <END_OF_CODE+3bf299e7/????>
> Trace; c004b8c4 <load_elf_interp+28c/2d4>
> Trace; c004c148 <load_elf_binary+6e8/950>
> Trace; c003c9e4 <search_binary_handler+5c/160>
> Trace; c003cc54 <do_execve+16c/1fc>
> Trace; c0007218 <sys_execve+70/f0>
> Trace; c0004e34 <ret_from_syscall_1+0/a0>
> Trace; c0003f14 <init+18/1a8>
> Trace; c0009670 <kernel_thread+2c/38>
>
> And then the rest continue in the same vein -- an oops inside an oops
> inside an oops.
>
> Any idea what causes this?

No but I've seen other weird timing problems on this platform running the
2.4.0-test2 kernel.  This may very well be another one of those since you're
using a different processor than I am.

I know, not much help...  :(

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
