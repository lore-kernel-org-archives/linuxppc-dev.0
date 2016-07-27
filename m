Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzbRw4yr8zDqPB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:27:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback in
 a header
In-Reply-To: <1469448688.5978.47.camel@kernel.crashing.org>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
 <20160725141326.6a155483@canb.auug.org.au>
 <871t2i1dv5.fsf@concordia.ellerman.id.au>
 <1469440186.5978.35.camel@kernel.crashing.org>
 <87r3aidmxv.fsf@concordia.ellerman.id.au>
 <1469448688.5978.47.camel@kernel.crashing.org>
Date: Wed, 27 Jul 2016 10:27:53 +1000
Message-ID: <87y44nvsae.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2016-07-25 at 20:36 +1000, Michael Ellerman wrote:
>> That would be nice, but these look fishy at least:
>>=20
>> arch/powerpc/platforms/cell/spu_manage.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!firmware_has_feature(FW_FEATURE_LPAR))
>> arch/powerpc/platforms/cell/spu_manage.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>> > arch/powerpc/platforms/cell/spu_manage.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!firmware_has_feature(FW_FEATURE_LPAR))
>
> Those can just be checks for LV1, I think ..=C2=A0

Yeah they can now.

Previously we had BEAT (the celleb HV), but now that's gone we can
switch those to LV1.

>> > arch/powerpc/platforms/pasemi/iommu.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=
firmware_has_feature(FW_FEATURE_LPAR)) {
>> drivers/net/ethernet/pasemi/pasemi_mac.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return firmware_has_feature(FW_FEATURE_LPAR);
>
> And that was some experiemtal PAPR'ish thing wasn't it ?

Not sure, it was news to me that pasemi ever had any HV support.

cheers
