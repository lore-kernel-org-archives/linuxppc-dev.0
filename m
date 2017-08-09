Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSBY32lzfzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 23:13:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
In-Reply-To: <4c7613b9-c37e-295a-8e38-04aa34455350@c-s.fr>
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
 <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
 <2111e0d8-3b77-20a0-aab9-3572467eb0d4@c-s.fr>
 <87d185o4m7.fsf@concordia.ellerman.id.au>
 <4c7613b9-c37e-295a-8e38-04aa34455350@c-s.fr>
Date: Wed, 09 Aug 2017 23:13:42 +1000
Message-ID: <87o9ronat5.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
...
> At least it is correct for the ones that use regular pages, and kernel 
> can also be started with nobats or noltlbs at command line, in which 
> case it is usefull to have the page tables correct.

Yep OK.

>> So yes we *should* always mark it no-execute but in practice we can't
>> because it's not page aligned.
>
> On 32 bit it seems to always be aligned to the normal page size, so no 
> problem.
>
>> But if that's different on (some?) 32-bit then we could introduce a new
>> CONFIG symbol that is enabled in the right cases.
>
> For the time being, I have added an "|| CONFIG_PPC32 " on the ifdef, is 
> that OK ?
> See https://patchwork.ozlabs.org/patch/796625/

Yeah looks fine.

cheers
