Date: Fri, 15 Nov 2002 16:24:36 +0500 (GMT+0500)
From: Atm account <linux2@cdotd.ernet.in>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem in booting PPC with kernel 2.5.44
In-Reply-To: <20021114151136.GB14431@opus.bloom.county>
Message-ID: <Pine.OSF.4.10.10211151612210.11070-100000@moon.cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Nov 2002, Tom Rini wrote:
> > address 0 and jumps to the 0th location (3 nops followed by code). It is
> > from here that early_init is called.
> Just wondering, what modifications did you have to make to
> arch/ppc/boot/simple?
    well that change was the addition of a routine to initialize the on
board IBM 82660 bridge, and the S5933 PCI controller.

> >     Now the problem is ... the kernel has been linked at 3GB and a call in
> > kernel/head.S which says ---
> How did you change things to have it link at 3GB?
	What else is it linked at?? Is it not what KERNELBASE is assigned
to?? AFAIK kernel links at 0xc0000000 and the bootloader at
8Mb (PPC based boards).
   Btw the problem turned out to be a _printk_ which was causing
an MCP to occur...we use a serial device for printing

thanx a lot

nishant


>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
