Message-ID: <3C82B86B.ED7E89C1@opensource.se>
Date: Mon, 04 Mar 2002 00:57:31 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Accessing BCSR's
References: <sc834d4c.007@gw_tms_syd2.pty.tms.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

If you have memory-mapped io (The (F)ADS8xx BCSR registers is a
good example) which is mapped to a certain physical address, it
is very simple to access it if the MMU is turned off.

The Linux kernel runs with the MMU on, and it needs a
virtual-to-physical
address mapping to be able to access memory-mapped io.

So, my 2.2-kernel has a file called arch/ppc/mm/init.c.

Inside that file there's a function called "ioremap()" - that is what
you are looking for.

Make sure that your Linux kernel has a virtual page for your io-area,
and access the virtual address that is returned by "ioremap()".

If you use "ioremap()" before a certain moment when the Linux kernel
starts up, you will get a 1:1 mapping between virtual and physical
addresses.
(This is true for 2.2 anyhow)

Look how the internal io block is ioremap():ped for a good example how
it is done.

Cheers /

magnus

Jeremy Rosen wrote:
>
> Hello everybody,
>
> I have 860T FADS board, and I am trying to access the (board specific)
> registers BCSRs.
>
> I have no problem accessing them in PPCBOOT, since they are accessed
> through CS1, at address FF01xxxx, but I can't access them in linux for
> the moment.
> My first attempt was by using the /dev/mem device, but it doesn't seem
> to work, the result read are not correct.
> so I have to question
> 1) why doesn't it work, I probably don't understand how /dev/mem works
> : does it map only memory and not the address space ? do I have to
> register the address range or the BCSR in the kernel ?
> 2) what is the proper way of doing this ? writing a driver ? or using
> /dev/mem properly ?
>
> thx for your help...
>
> Jeremy
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
