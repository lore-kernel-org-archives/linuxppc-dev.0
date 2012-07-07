Return-Path: <B02008@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FA9B2C0209
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 18:39:47 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
 kernel hooks
Date: Sat, 7 Jul 2012 08:39:36 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15CF83@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <1341440735.16808.42.camel@pasglop>
 <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net>,
 <7305F50A-8E77-4E88-8EB8-4046A7E94DF9@suse.de>
In-Reply-To: <7305F50A-8E77-4E88-8EB8-4046A7E94DF9@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

>________________________________________=0A=
>From: Alexander Graf [agraf@suse.de]=0A=
>Sent: Saturday, July 07, 2012 2:11 AM=0A=
>To: Caraman Mihai Claudiu-B02008=0A=
>Cc: Benjamin Herrenschmidt; <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-=
dev; qemu-ppc@nongnu.org List=0A=
>Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM ker=
nel hooks=0A=
>=0A=
>On 07.07.2012, at 00:33, Caraman Mihai Claudiu-B02008 wrote:=0A=
>=0A=
>>> -----Original Message-----=0A=
>>> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=0A=
>>> Sent: Thursday, July 05, 2012 1:26 AM=0A=
>>> To: Alexander Graf=0A=
>>> Cc: Caraman Mihai Claudiu-B02008; <kvm-ppc@vger.kernel.org>; KVM list;=
=0A=
>>> linuxppc-dev; qemu-ppc@nongnu.org List=0A=
>>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM=
=0A=
>>> kernel hooks=0A=
>>>=0A=
>>> You can't but in any case I don't see the point of the conditional here=
,=0A=
>>> we'll eventually have to load srr1 no ? We can move the load up to here=
=0A=
>>> in all cases or can't we ?=0A=
>>=0A=
>> I like the idea, but there is a problem with addition macros which may c=
lobber=0A=
>> r11 and PROLOG_ADDITION_MASKABLE_GEN is such a case.=0A=
>=0A=
>Mike -v please :)=0A=
=0A=
Ben suggested something like this:=0A=
	=0A=
 #define EXCEPTION_PROLOG(n, type, addition) \=0A=
 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ \=0A=
 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \=0A=
 	std r10,PACA_EX##type+EX_R10(r13); \=0A=
 	std r11,PACA_EX##type+EX_R11(r13); \=0A=
 	mfcr r10; /* save CR */ \	=0A=
+	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \=0A=
	DO_KVM	intnum,srr1; \=0A=
 	addition; /* additional code for that exc. */ \=0A=
 	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \=0A=
 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \=0A=
-	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \=0A=
 	type##_SET_KSTACK; /* get special stack if necessary */\=0A=
 	andi. r10,r11,MSR_PR; /* save stack pointer */ \=0A=
=0A=
But one of the addition looks like this:=0A=
	=0A=
 #define PROLOG_ADDITION_MASKABLE_GEN(n) \=0A=
 	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \=0A=
	cmpwi cr0,r11,0; /* yes -> go out of line */ \=0A=
	beq masked_interrupt_book3e_##n	=0A=
=0A=
So for maskable gen we end up with:=0A=
=0A=
 #define EXCEPTION_PROLOG(n, type, addition) \=0A=
 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ \=0A=
 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \=0A=
 	std r10,PACA_EX##type+EX_R10(r13); \=0A=
 	std r11,PACA_EX##type+EX_R11(r13); \=0A=
 	mfcr r10; /* save CR */ \=0A=
	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \=0A=
 	DO_KVM	intnum,srr1; \=0A=
	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \=0A=
	cmpwi cr0,r11,0; /* yes -> go out of line */ \=0A=
	beq masked_interrupt_book3e_##n	\=0A=
	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \=0A=
 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \=0A=
 	type##_SET_KSTACK; /* get special stack if necessary */\=0A=
 	andi. r10,r11,MSR_PR; /* save stack pointer */ \=0A=
	=0A=
This affects the last asm line, we load srr1 into r11 but clobber it in-bet=
ween.=0A=
We need a spare register for maskable gen addition. I think we can free r10=
 sooner=0A=
and used it in addition like this:=0A=
=0A=
 #define EXCEPTION_PROLOG(n, type, addition) \=0A=
 	mtspr SPRN_SPRG_##type##_SCRATCH,r13; /* get spare registers */ \=0A=
 	mfspr r13,SPRN_SPRG_PACA; /* get PACA */ \		=0A=
 	std r10,PACA_EX##type+EX_R10(r13); \=0A=
 	std r11,PACA_EX##type+EX_R11(r13); \=0A=
+	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \=0A=
	mfcr r10; /* save CR */ \=0A=
+ 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \=0A=
 	DO_KVM	intnum,srr1; \=0A=
-	lbz r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \=0A=
-	cmpwi cr0,r11,0; /* yes -> go out of line */ \=0A=
+	lbz r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */ \=0A=
+	cmpwi cr0,r10,0; /* yes -> go out of line */ \=0A=
	beq masked_interrupt_book3e_##n	\=0A=
 	std r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */ \=0A=
- 	stw r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \=0A=
-	mfspr r11,SPRN_##type##_SRR1;/* what are we coming from */ \=0A=
 	type##_SET_KSTACK; /* get special stack if necessary */\=0A=
 	andi. r10,r11,MSR_PR; /* save stack pointer */ \=0A=
	=0A=
-Mike=
