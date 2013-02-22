Return-Path: <phileas-fogg@mail.ru>
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1A8392C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2013 06:49:28 +1100 (EST)
Message-ID: <5127D9CE.2090500@mail.ru>
Date: Fri, 22 Feb 2013 21:49:18 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop> <5126955B.9070808@mail.ru>
 <1361490374.4676.58.camel@pasglop>
In-Reply-To: <1361490374.4676.58.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2013-02-21 at 22:44 +0100, Phileas Fogg wrote:
>> Stripped OpenWRT image:
>> ------------------------
>>
>> c00000000001a474:       48 00 00 05     bl      0xc00000000001a478
>> c00000000001a478:       7c a8 02 a6     mflr    r5
>> c00000000001a47c:       38 a5 00 1c     addi    r5,r5,28
>> c00000000001a480:       7c 21 0b 78     mr      r1,r1
>> c00000000001a484:       80 85 00 00     lwz     r4,0(r5)
>> c00000000001a488:       2c 04 00 00     cmpwi   r4,0
>> c00000000001a48c:       40 82 00 62     bnea-   0x60
>> c00000000001a490:       4b ff ff f0     b       0xc00000000001a480
>> c00000000001a494:       00 00 00 00     .long 0x0
>> c00000000001a498:       a0 6d 00 48     lhz     r3,72(r13)
>> c00000000001a49c:       48 00 00 11     bl      0xc00000000001a4ac
>
>
> Smell like a bad stack pointer to me...
>
> One thing I noticed is that kexec doesn't seem to hard disable
> interrupts, which is ... fishy at best. It should do that
> before it switches stacks around. Dunno if that's the cause
> of the problem but it might be worth adding a hard_irq_disable()
> after all the local_irq_disable(), making sure we are hard
> disabled before going into asm.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Hi,

i wanted to let you know that i tested your advice. And let me say, it's was a 
damn good advice :) I can boot FreeBSD loader on Linux 3.8 now, no SHA256 
checksum failures. And no panics with FreeBSD LiveCD anymore too.

I just inserted hard_irq_disable() after each local_irq_disable() in 
arch/powerpc/kernel/machine_kexec_64.c

Thanks

regards
