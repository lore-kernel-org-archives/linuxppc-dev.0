Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC1252C0201
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 09:11:24 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel
 hooks
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Sat, 7 Jul 2012 01:11:16 +0200
Message-Id: <7305F50A-8E77-4E88-8EB8-4046A7E94DF9@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <1341440735.16808.42.camel@pasglop>
 <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net>
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


On 07.07.2012, at 00:33, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>> Sent: Thursday, July 05, 2012 1:26 AM
>> To: Alexander Graf
>> Cc: Caraman Mihai Claudiu-B02008; <kvm-ppc@vger.kernel.org>; KVM =
list;
>> linuxppc-dev; qemu-ppc@nongnu.org List
>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add =
DO_KVM
>> kernel hooks
>>=20
>> On Wed, 2012-07-04 at 16:29 +0200, Alexander Graf wrote:
>>=20
>>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)				=
\
>>>> +	BEGIN_FTR_SECTION					\
>>>> +		mfspr	reg, spr;			  	\
>>>> +	END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>>>> +#else
>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)
>>>> +#endif
>>>=20
>>> Bleks - this is ugly. Do we really need to open-code the #ifdef =
here?
>>> Can't the feature section code determine that the feature is =
disabled
>>> and just always not include the code?
>>=20
>> You can't but in any case I don't see the point of the conditional =
here,
>> we'll eventually have to load srr1 no ? We can move the load up to =
here
>> in all cases or can't we ?=20
>=20
> I like the idea, but there is a problem with addition macros which may =
clobber
> r11 and PROLOG_ADDITION_MASKABLE_GEN is such a case.

Mike -v please :)


Alex
