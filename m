Message-ID: <3A63BAFB.80E3980C@mvista.com>
Date: Mon, 15 Jan 2001 19:07:39 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> How come we don't use iopa() and friends for all kernel mapping
> information?  It is only defined for CONFIG_APUS, but is the right
> thing to use on 8xx and 4xx, and probably all processors.  The
> virt_to_bus/bus_to_virt contain the quickie arithmetic hack with
> KERNELBASE, but that isn't the right thing to do for any kmalloc()
> or valloc() space or if you don't have BAT mapping.
>
> I am considering making these functions more generic, removing the
> #ifdefs, and implementing "simulated" BAT mapping for processors
> like the 8xx and 4xx that don't have BATs (not for 2.4, of course :-).
>
> Why shouldn't I do this?
>
>         -- Dan

For the 405 I had to use iopa() for virt_to_bus() because there are
cases where I create a virtual address for IO buffers that is
uncached, and that virtual address is not (physical address + KERNELBASE).
I also have the beginnings of simulated BAT mapping for the 405
(not quite there, but part way).

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
