From: "Stefano Coluccini" <s.coluccini@caen.it>
To: =?iso-8859-1?Q?Bj=F6rn_Wingman?= <bjowi@ida.liu.se>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mcpn765
Date: Thu, 15 Mar 2001 18:26:43 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMGEBMDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <yx2r8zzghpd.fsf@aste15.ida.liu.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check the make file arch/ppc/boot/pp3/Makefile, in the rule for making
zImage.initrd there is a typo: you must add the -pbp option to the mkprep
invocation.

This is true if you are trying to boot an initrd image, the error isn't
present in the zImage rule.

Stefano.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Björn
> Wingman
> Sent: Thursday, March 15, 2001 4:45 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: mcpn765
>
>
>
> Hello,
>
> I have an MCPN765 card from Motorola with a 7400 processor, and I'm
> trying to boot linux on it. I use the latest hardhat cross-compilation
> tools, all with the prefix ppc_7xx, which seemed to be the correct choice.
>
> I have set up bootp and so on on my host machine, and transferring the
> kernel image seems to work fine, but all kernels I have tried
> refuse to boot.
>
> >From ppcbug I get:
>
> Residual-Data Located at: $1FF8D93C
>
> ...and then nothing happens.
>
>
> There is a kernel image on
>
> http://www.linuxcare.com.au/download/ppclinux/mcpn765/zImage
>
> that gets a bit further:
>
> Residual-Data Located at: $1FF8D93C
> loaded at:     00005400 0001C210
> relocated to:  00800000 00816E10
> board data at: 1FF8D93C 1FF94348
> relocated to:  00810304 00816D10
> zimage at:     00010400 000A78CB
> relocated to:  00817000 008AE4CB
> avail ram:     00400000 00800000
>
> Linux/PPC load: console=ttyS0,9600 root=/dev/sda2 mem=992m
> Uncompressing Linux...done.
> Now booting the kernel
> vector 300: at pc = 9000db1c, msr = 1032, sp = 9012bf88 [9012bed8]
> dar = fe000cf8, dsisr =42000000
> current = 9012a058, pid = 0, comm = swapper
> mon>
>
> And I end up in some sort of boot-monitor-debugger that I don't know
> anything about.
>
>
> But if I compile the sources provided at linuxcare myself, I get the same
> behaviour as before.
>
> Any ideas? Do I need a different crosscompiler?
>
>
>        /Björn Wingman
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
