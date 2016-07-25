Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryVJv1nzGzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:33:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback in
 a header
In-Reply-To: <20160725141326.6a155483@canb.auug.org.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
 <20160725141326.6a155483@canb.auug.org.au>
Date: Mon, 25 Jul 2016 15:33:02 +1000
Message-ID: <871t2i1dv5.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Michael,
>
> On Mon, 25 Jul 2016 12:57:50 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> hpte_init_lpar() is part of the pseries platform, so name it as such.
>> Provide the fallback implementation in a header, rather than using a
>> weak function.
>
> firmware_has_feature(FW_FEATURE_LPAR) can also be true for
> CONFIG_PPC_PS3.  Is this a problem?

No it shouldn't be, because the PS3_LV1 check should have already hit:

	/* Select appropriate backend */
	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
		ps3_early_mm_init();
	else if (firmware_has_feature(FW_FEATURE_LPAR))
		hpte_init_pseries();
	else
		hpte_init_native();

When we detect a PS3 we set both PS3_LV1 and LPAR at the same time, so
there should be no way they can get out of sync, other than due to a
bug in the code.

cheers
