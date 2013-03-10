Return-Path: <phileas-fogg@mail.ru>
Received: from smtp26.mail.ru (smtp26.mail.ru [94.100.176.179])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 660332C031C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 21:20:57 +1100 (EST)
Message-ID: <513C5E4D.2030505@mail.ru>
Date: Sun, 10 Mar 2013 11:19:57 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
 <1362687724.6977.1.camel@pasglop> <513BD33B.7020305@mail.ru>
 <1362876308.6977.42.camel@pasglop>
In-Reply-To: <1362876308.6977.42.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Schwab <schwab@linux-m68k.org>, Denis Kirjanov <kirjanov@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2013 01:45 AM, Benjamin Herrenschmidt wrote:
> On Sun, 2013-03-10 at 01:26 +0100, Phileas Fogg wrote:
>
>> i managed to find the bad commit after a couple of days bisecting.
>
> Thanks !
>
>> ----------------------------
>> 44ae3ab3358e962039c36ad4ae461ae9fb29596c is the first bad commit
>> commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c
>> Author: Matt Evans <matt@ozlabs.org>
>> Date:   Wed Apr 6 19:48:50 2011 +0000
>>
>>       powerpc: Free up some CPU feature bits by moving out MMU-related
>> features
>>
>>       Some of the 64bit PPC CPU features are MMU-related, so this patch moves
>>       them to MMU_FTR_ bits.  All cpu_has_feature()-style tests are moved to
>>       mmu_has_feature(), and seven feature bits are freed as a result.
>>
>>       Signed-off-by: Matt Evans <matt@ozlabs.org>
>>       Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> --------------------------------
>
> Have you verified that if you checkout git at the above commit point, it
> fails and if you then just revert that commit on top, it works again ?
>
> The above should have been mostly a NOP change but I'll have a closer
> look in case a typo of some kind actually broke something.
>
>> Actually, there are 2 problems i found.
>> The first problem occurs when i enable IDE CDROM driver on my machine.
>> The following commit causes hangs on my machine at boot:
>
> Ok. You may want to switch to the new libata instead of the old IDE
> driver too
>
> (CONFIG_IDE off, CONFIG_ATA on, CONFIG_PATA_MACIO on and from there it
> will use the SCSI CDROM driver).
>
>> ----------------------
>> commit 5b03a1b140e13a28ff6be1526892a9dc538ddef6
>> Author: Tejun Heo <tj@kernel.org>
>> Date:   Wed Mar 9 19:54:27 2011 +0100
>>
>>       ide: Convert to bdops->check_events()
>>
>>       Convert ->media_changed() to the new ->check_events() method.  The
>>       conversion is mostly mechanical.  The only notable change is that
>>       cdrom now doesn't generate any event if @slot_nr isn't CDSL_CURRENT.
>>       It used to return -EINVAL which would be treated as media changed.  As
>>       media changer isn't supported anyway, this doesn't make any
>>       difference.
>>
>>       This makes ide emit the standard disk events and allows kernel event
>>       polling.  Currently, only MEDIA_CHANGE event is implemented.  Adding
>>       support for EJECT_REQUEST shouldn't be difficult; however, given that
>>       ide driver is already deprecated, it probably is best to leave it
>>       alone.
>>
>>       Signed-off-by: Tejun Heo <tj@kernel.org>
>> ----------------------------
>>
>>
>>
>>
>> If i disable IDE CDROM driver then the Linux kernel boots again
>> and then it hits the commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c
>> and hangs again :)
>>
>> The commit eca590f402332ab873d13f2d8d00fa0b91cfff36 which is before
>> the commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c works fine,
>> i tested it myself to be on the safe side.
>
> Ok thanks. I'll dig a bit if I get a chance next week.
>
> Cheers,
> Ben.
>>
>>
>> Regards
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>


I'm trying to debug the problem and printed CPU and MMU features
before and after this bad commit. And found i think i found the problem.
At least i got very strange results.

The following code i did add to arch/powerpc/kernel/setup_64.c:setup_system
------------------------------------------------------------
printk("cpu_features %lx\n", cur_cpu_spec->cpu_features);
printk("mmu_features %lx\n", cur_cpu_spec->mmu_features);
------------------------------------------------------------


CPU features before 44ae3ab3358e962039c36ad4ae461ae9fb29596c commit:

cpu_features 0x24000c718100448


CPU and MMU features after 44ae3ab3358e962039c36ad4ae461ae9fb29596c commit:

cpu_features 0x18100448
mmu_features 0x00000001

MMU features in 2nd case have only bit MMU_FTR_HPTE_TABLE set.
Where are the bits MMU_FTR_SLB, MMU_FTR_16M_PAGE and MMU_FTR_TLBIEL 
which introduced in commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c ?
They should be set if i see it right in arch/powerpc/include/asm/mmu.h.

#define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_SLB | MMU_FTR_TLBIEL | \
				 MMU_FTR_16M_PAGE)
/* MMU feature bit sets for various CPUs */
#define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
#define MMU_FTRS_PPC970		MMU_FTRS_POWER4


Hope it helps to fix the problem.

regards
