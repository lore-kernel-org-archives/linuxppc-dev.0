Message-Id: <5.1.0.14.2.20030122125449.0278e080@falcon.si.com>
Date: Wed, 22 Jan 2003 12:57:30 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Problem Exporting Symbol
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK, the source module was pointed out to me (arch/ppc/mm/fault.c).  The
problem is that Shiv is targeting the 8260, but va_to_pte() is only defined
for 8xx or CONFIG_GT64260_ETH.  Shiv doesn't say if he has
CONFIG_GT64260_ETH defined, I'm guessing not.

The code in question:

#if defined(CONFIG_8xx) || defined(CONFIG_GT64260_ETH)

/* The pgtable.h claims some functions generically exist, but I
  * can't find them......
  */
pte_t *va_to_pte(unsigned long address)


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
