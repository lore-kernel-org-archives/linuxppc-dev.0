Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C22C02C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 11:02:56 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/booke64: Use common defines for AltiVec
 interrupts numbers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372726613.8183.104@snotra>
Date: Tue, 2 Jul 2013 03:02:51 +0200
Message-Id: <CC31298B-CEB3-4F35-9400-7C5CEC50BF66@suse.de>
References: <1372726613.8183.104@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2013, at 02:56, Scott Wood wrote:

> On 07/01/2013 07:18:21 PM, Alexander Graf wrote:
>> On 01.07.2013, at 17:35, Mihai Caraman wrote:
>> > On Book3E some SPE/FP/AltiVec interrupts share the same number. Use
>> > common defines to indentify these numbers.
>> So why didn't this happen from the beginning?
>=20
> Ask Kumar.
>=20
>> Why the change?
>=20
> So we can remove this hack in kvm_asm.h:
>=20
> /*
> * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same =
defines
> */
> #define BOOKE_INTERRUPT_SPE_UNAVAIL =
BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> #define BOOKE_INTERRUPT_SPE_FP_DATA =
BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> #define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL =
BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> #define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
>                                =
BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>=20
> It was added as a compilation fix, and it was less intrusive to =
temporarily fix it this way.
>=20
> I am curious why the above code wasn't removed at the end of this =
patchset. :-)

Yeah, and why the intention isn't clearly written down in the patch =
description ;)


Alex
