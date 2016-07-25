Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryd2l2gFWzDqfV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 20:36:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback in
 a header
In-Reply-To: <1469440186.5978.35.camel@kernel.crashing.org>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
 <20160725141326.6a155483@canb.auug.org.au>
 <871t2i1dv5.fsf@concordia.ellerman.id.au>
 <1469440186.5978.35.camel@kernel.crashing.org>
Date: Mon, 25 Jul 2016 20:36:12 +1000
Message-ID: <87r3aidmxv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2016-07-25 at 15:33 +1000, Michael Ellerman wrote:
>> When we detect a PS3 we set both PS3_LV1 and LPAR at the same time,
>> so
>> there should be no way they can get out of sync, other than due to a
>> bug in the code.
>
> I thought I had changed PS3 to no longer set LPAR ?

Nope:

FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,

...

#ifdef CONFIG_PPC_PS3
	/* Identify PS3 firmware */
	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
		powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
#endif

> I like having a flag that basically says PAPR and that's pretty much
> what LPAR is, in fact I think I've been using it elsewhere with that
> meaning

That would be nice, but these look fishy at least:

arch/powerpc/platforms/cell/spu_manage.c:       if (!firmware_has_feature(FW_FEATURE_LPAR))
arch/powerpc/platforms/cell/spu_manage.c:       if (!firmware_has_feature(FW_FEATURE_LPAR)) {
arch/powerpc/platforms/cell/spu_manage.c:       if (!firmware_has_feature(FW_FEATURE_LPAR))
arch/powerpc/platforms/pasemi/iommu.c:      !firmware_has_feature(FW_FEATURE_LPAR)) {
drivers/net/ethernet/pasemi/pasemi_mac.c:       return firmware_has_feature(FW_FEATURE_LPAR);

cheers
