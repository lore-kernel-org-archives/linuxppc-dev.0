Subject: Re: m8260_cpm_dpfree( )
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Sanjay Kumar <skumar@giga-stream.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <FKEJLMJFECLAHOKCGJFPKEFGCBAA.skumar@giga-stream.de>
References: <FKEJLMJFECLAHOKCGJFPKEFGCBAA.skumar@giga-stream.de>
Content-Type: text/plain
Message-Id: <1059403782.2835.193.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 28 Jul 2003 15:49:42 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sanjay,


> 1. where can I get m8260_cpm_dpfree() function implementation ?

You could try porting the dpfree function in
arch/ppc/8xx_io/commproc.c.  However, this function should only really
be necessary if you wish to rmmod the driver.

> 2. For using the m8260_cpm_dpalloc(uint size, uint align) function I have
> included
>    #include <asm/cpm_8260.h> and having CC_OPTION
>  -D__KERNEL__ -DMODULE  -DCONFIG_8260
>     in my Makefile. But when I tried to load this driver on
> motorola-mtx-ppc_7xx target
>     it gives unresolved symbol for m8260_cpm_dpalloc(). I have kernel
> Monatavista 2.4.17
>     Anything I am missing in this case ?

Try adding

#ifdef	CONFIG_8260
EXPORT_SYMBOL(m8260_cpm_dpalloc);
#endif

to arch/ppc/kernel/ppc_ksyms.c

> 3. I am including file #include <asm/mpc8260.h> for using define
> request_8xxirq.But I am not
>    able to include this define.
> 4. I am including file  <asm/irq.h> for using define SIU_INT_FCC1. But I
> am not able
>    to include this define.
>   Do I am missing something ? I have same CC_OPTION as mentioned above.
> Does anything matter
>   with kernel version?
>


Not sure about these problems, but it sounds like you are trying to
build the module standalone, instead of as part of the kernel's "make
modules".  I would recommend the latter as it makes it easier to pick up
the correct gcc flags.

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
