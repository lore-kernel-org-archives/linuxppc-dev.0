Message-Id: <5.1.0.14.2.20030122062343.02762040@falcon.si.com>
Date: Wed, 22 Jan 2003 06:28:41 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Problem Exporting Symbol
In-Reply-To: <000028D3.C22236@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I haven't checked the actual sources, but I bet 'va_to_pte' is _not_ a
symbol... it is probably either an "inline" function so the compiler
inserts the function's code everywhere it is "called" (saves the overhead
of the call and return with associated stack pushing and popping).  When
you try to export it, it isn't found.

Solutions:
1) Write your own non-inline "my_va_to_pte" in the kernel and export it.
2) Figure out how to avoid "va_to_pte" in your driver?
3) Don't make your SPI driver a loadable module?
3) Other?
4) Don't inline "va_to_pte" (BAD SOLUTION).

gvb


At 07:25 PM 1/21/2003 -0500, shivkumarb@hotmail.com wrote:

>Hi All,
>
>       I am trying to write SPI driver for 8260, based on the SPI driver for
>the MPC860 that I got from this list. I am trying to export the symbol
>'va_to_pte', for the driver module, in the kernel.
>
>       I included this in arch/ppc/kernel/ppc_ksyms.c, by using the
>EXPORT_SYMTAB(va_to_pte) function. But when I tried to rebuild the kernel
>(make zImage), it keeps coming back with the following error:
>
>arch/ppc/kernel/kernel.o(__ksymtab+0x0370): undefined reference to
>'va_to_pte'
>
>      I have exported other symbols, by following similar procedure. Is there
>something that I am missing.
>
>       I am running Linux kernel 2.4.2. Any inputs will be very helpful.
>
>   Thanks and Regards,
>     Shiv
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
