Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 0534267E0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 13:39:35 +1000 (EST)
Message-ID: <32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
In-Reply-To: <20050729153323.3f2c62ad.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
Date: Fri, 29 Jul 2005 23:39:32 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler not invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kim,
 Thanks for helping out.
 Yes i verified , i am writing to upper bits of FR.

 Now my ISR does get invoked and InterruptStatus(0x1010) has 4 in upper
bits.  That means TEA (Transfer Error Acknowledge). Next thing i did is i
dumped the lower bits of master-error-address-register MEAR(0x1038) and
it has 0x011af4d0. As per definition of this register my data phase was
terminated .  Was it due to bad address being written into FR.

 I am using virt_to_phys()  to convert the DPD's address and then writing
this into FR.

 Also u may be thinking what did i change that ISR gets invoked now.
Earlier i was using __vpa instead of virt_to_phys().  __vpa came from the
original SEC driver(for mpc8555 and kernel 2.4) which i downloaded from
freescale.  After i replaced __vpa with kernel's virt_to_phys() gets
invoked.

#define __vpa(va) ((pte_val(*(unsigned long
*)pte_offset_kernel(pmd_offset(pgd_offset_k(va), (va)), (va))) &
PAGE_MASK) + (va & ~PAGE_MASK))

But i still think that may be virt_to_phys() is not doing what FR expects.

Thanks for your patience  with detailed mail.
Please help
-vikas aggarwal

> On Fri, 29 Jul 2005 11:40:27 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>> Hi All,
>>   Will  appreciate if someone can guide me how to debug this inside SEC
>> (security co-processor) core.
>>
>>  The linux driver is writing descriptor into the FETCH-Register(0x2048)
>> for Random Number generation execution unit(RNG-EU). The request came
>> through a test program from user space. The RNG generation request never
>> seems to complete as my ISR is not invoked.
>>  I checked the CCPSR(Crypto Channel Pointer Status register = 0x2010)
>> and
>> it has value=0:7(0-31 : 32-63 bits). 7 means "channel_error". But its
>> always there even before I write the RNG descriptor to Fetch-register.
>
> a value of 7 in bits 56-63 (PAIR_PTR) can suggest processing has not
> begun.
>
> can you verify you are writing the upper bits of the FR (i.e. 0x204c)?
>
> Kim
>
