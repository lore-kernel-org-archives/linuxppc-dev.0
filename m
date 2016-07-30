Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s1hB84JrLzDrKy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jul 2016 20:08:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 10/21] powerpc/mm: Define radix_enabled() in one place
 & use static inline
In-Reply-To: <1469796870.3000.1.camel@gmail.com>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
 <20160728174611.1ec99066@roar.ozlabs.ibm.com>
 <87d1lwllgs.fsf@concordia.ellerman.id.au> <1469796870.3000.1.camel@gmail.com>
Date: Sat, 30 Jul 2016 20:08:14 +1000
Message-ID: <8737mr5tgx.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Fri, 2016-07-29 at 21:42 +1000, Michael Ellerman wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > Won't MMU_FTRS_POSSIBLE just do the right thing when
>> > !CONFIG_PPC_RADIX_MMU?
>> Yes it should.
>>
>> I'll have to work out why Aneesh thought he needed to do it explicitly
>> and whether that is needed or not.
>
> IIRC, If CONFIG_PPC_RADIX_MMU=3Dn MMU_FTR_RAIDX will not be present in the
> MMU_FTRS_POSSIBLE mask=C2=A0

That's right.

The obvious thing to do would be to define MMU_FTR_RADIX to 0 when
RADIX=3Dn, but that doesn't work because it breaks the ASM FTR macros
(because they check (mmu_features & mask) =3D=3D mask).

So instead we just remove it from the possible mask.

cheers
