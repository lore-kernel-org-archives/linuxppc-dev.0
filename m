Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC5C04AAD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 11:31:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36BE206BF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 11:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36BE206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yLCy2f5PzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 21:31:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yLBH6vkCzDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2019 21:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44yLBG6Z5qz9s9T;
 Mon,  6 May 2019 21:29:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 03/15] powerpc/mm: convert Book3E 64 to pte_fragment
In-Reply-To: <0076ad26-9d0e-e408-3521-b8e17669bb04@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
 <c440b242da6de3823c4ef51f35f38405bbd51430.1556293738.git.christophe.leroy@c-s.fr>
 <0076ad26-9d0e-e408-3521-b8e17669bb04@c-s.fr>
Date: Mon, 06 May 2019 21:29:55 +1000
Message-ID: <8736lryg5o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 26/04/2019 =C3=A0 17:58, Christophe Leroy a =C3=A9crit=C2=A0:
>> Book3E 64 is the only subarch not using pte_fragment. In order
>> to allow refactorisation, this patch converts it to pte_fragment.
>>=20
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu_context.h       |  6 -----
>>   arch/powerpc/include/asm/nohash/64/mmu.h     |  4 +++-
>>   arch/powerpc/include/asm/nohash/64/pgalloc.h | 33 ++++++++++----------=
--------
>>   arch/powerpc/mm/Makefile                     |  4 ++--
>>   arch/powerpc/mm/mmu_context.c                |  2 +-
>>   5 files changed, 18 insertions(+), 31 deletions(-)
>>=20
> [...]
>
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index 3c1bd9fa23cd..138c772d58d1 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -9,6 +9,7 @@ CFLAGS_REMOVE_slb.o =3D $(CC_FLAGS_FTRACE)
>>=20=20=20
>>   obj-y				:=3D fault.o mem.o pgtable.o mmap.o \
>>   				   init_$(BITS).o pgtable_$(BITS).o \
>> +				   pgtable-frag.o \
>>   				   init-common.o mmu_context.o drmem.o
>>   obj-$(CONFIG_PPC_MMU_NOHASH)	+=3D mmu_context_nohash.o tlb_nohash.o \
>>   				   tlb_nohash_low.o
>> @@ -17,8 +18,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:=3D hash_native_64.o
>>   obj-$(CONFIG_PPC_BOOK3E_64)   +=3D pgtable-book3e.o
>>   obj-$(CONFIG_PPC_BOOK3S_64)	+=3D pgtable-hash64.o hash_utils_64.o slb.=
o \
>>   				   $(hash64-y) mmu_context_book3s64.o \
>> -				   pgtable-book3s64.o pgtable-frag.o
>> -obj-$(CONFIG_PPC32)		+=3D pgtable-frag.o
>> +				   pgtable-book3s64.o
>
> Looks like the removal of pgtable-frag.o for CONFIG_PPC_BOOK3S_64 didn't=
=20
> survive the merge.

Hmm, I don't remember having problems there but clearly something went
wrong.

> Will send a patch to fix that.

Thanks.

cheers
