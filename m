Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A52C2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 08:25:27 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel
 hooks
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15CF83@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 12 Jul 2012 00:25:19 +0200
Message-Id: <EED22D54-8B0F-4EAE-BA70-C5C086DBB7C1@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <1341440735.16808.42.camel@pasglop>
 <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net>,
 <7305F50A-8E77-4E88-8EB8-4046A7E94DF9@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15CF83@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.07.2012, at 10:39, Caraman Mihai Claudiu-B02008 wrote:

>> ________________________________________
>> From: Alexander Graf [agraf@suse.de]
>> Sent: Saturday, July 07, 2012 2:11 AM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: Benjamin Herrenschmidt; <kvm-ppc@vger.kernel.org>; KVM list; =
linuxppc-dev; qemu-ppc@nongnu.org List
>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add =
DO_KVM kernel hooks
>>=20
>> On 07.07.2012, at 00:33, Caraman Mihai Claudiu-B02008 wrote:
>>=20
>>>> -----Original Message-----
>>>> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>>>> Sent: Thursday, July 05, 2012 1:26 AM
>>>> To: Alexander Graf
>>>> Cc: Caraman Mihai Claudiu-B02008; <kvm-ppc@vger.kernel.org>; KVM =
list;
>>>> linuxppc-dev; qemu-ppc@nongnu.org List
>>>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add =
DO_KVM
>>>> kernel hooks
>>>>=20
>>>> You can't but in any case I don't see the point of the conditional =
here,
>>>> we'll eventually have to load srr1 no ? We can move the load up to =
here
>>>> in all cases or can't we ?
>>>=20
>>> I like the idea, but there is a problem with addition macros which =
may clobber
>>> r11 and PROLOG_ADDITION_MASKABLE_GEN is such a case.
>>=20
>> Mike -v please :)
>=20
> Ben suggested something like this:
> =09
> #define EXCEPTION_PROLOG(n, type, addition) \
> 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ =
\
> 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \
> 	std r10,PACA_EX##type+EX_R10(r13); \
> 	std r11,PACA_EX##type+EX_R11(r13); \
> 	mfcr r10; /* save CR */ \=09
> +	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \
> 	DO_KVM	intnum,srr1; \
> 	addition; /* additional code for that exc. */ \
> 	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \
> 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ =
\
> -	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \
> 	type##_SET_KSTACK; /* get special stack if necessary */\
> 	andi. r10,r11,MSR_PR; /* save stack pointer */ \
>=20
> But one of the addition looks like this:
> =09
> #define PROLOG_ADDITION_MASKABLE_GEN(n) \
> 	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \
> 	cmpwi cr0,r11,0; /* yes -> go out of line */ \
> 	beq masked_interrupt_book3e_##n=09
>=20
> So for maskable gen we end up with:
>=20
> #define EXCEPTION_PROLOG(n, type, addition) \
> 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ =
\
> 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \
> 	std r10,PACA_EX##type+EX_R10(r13); \
> 	std r11,PACA_EX##type+EX_R11(r13); \
> 	mfcr r10; /* save CR */ \
> 	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \
> 	DO_KVM	intnum,srr1; \
> 	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \
> 	cmpwi cr0,r11,0; /* yes -> go out of line */ \
> 	beq masked_interrupt_book3e_##n	\
> 	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \
> 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ =
\
> 	type##_SET_KSTACK; /* get special stack if necessary */\
> 	andi. r10,r11,MSR_PR; /* save stack pointer */ \
> =09
> This affects the last asm line, we load srr1 into r11 but clobber it =
in-between.
> We need a spare register for maskable gen addition. I think we can =
free r10 sooner
> and used it in addition like this:

Ah, makes sense, yes.

>=20
> #define EXCEPTION_PROLOG(n, type, addition) \
> 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ =
\
> 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \	=09
> 	std r10,PACA_EX##type+EX_R10(r13); \
> 	std r11,PACA_EX##type+EX_R11(r13); \

Or just free up another register early on, like here.


Alex

> +	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \
> 	mfcr r10; /* save CR */ \
> + 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ =
\
> 	DO_KVM	intnum,srr1; \
> -	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \
> -	cmpwi cr0,r11,0; /* yes -> go out of line */ \
> +	lbz r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \
> +	cmpwi cr0,r10,0; /* yes -> go out of line */ \
> 	beq masked_interrupt_book3e_##n	\
> 	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \
> - 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ =
\
> -	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \
> 	type##_SET_KSTACK; /* get special stack if necessary */\
> 	andi. r10,r11,MSR_PR; /* save stack pointer */ \
> =09
> -Mike
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
