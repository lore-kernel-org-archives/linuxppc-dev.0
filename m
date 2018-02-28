Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrslv0GlCzF0l4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 21:50:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/npu: Cleanup MMIO ATSD flushing
In-Reply-To: <2478842.lxjFpUTe5s@new-mexico>
References: <20171214011008.4388-1-bsingharora@gmail.com>
 <5227513.IOhi8YYFsi@new-mexico>
 <CAKTCnzkO+NWKDwj8RE_jX_N0uu-vY5HRf4AdkJyjsLvL1Loqhg@mail.gmail.com>
 <2478842.lxjFpUTe5s@new-mexico>
Date: Wed, 28 Feb 2018 21:50:18 +1100
Message-ID: <87y3jd2xsl.fsf@concordia.ellerman.id.au>
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

Alistair Popple <alistair@popple.id.au> writes:

>> @aneesh can you please look at this? @mpe can we pick this up if there
>> are no objections?
>
> @mpe any objections to picking this up for this release? Or do you want to wait
> for the next one? (there are likely more bugfixes coming for ATS support).

I can grab it for this release if it's fixing a bug, the subject makes
it sound like a cleanup. Do we have a Fixes tag for it?

I don't particularly like the potentially very long loop in
pnv_npu2_invalidate_helper() which spends most of its time with
interrupts off. I worry we're going to see soft lockups pointing there
if we get a very large invalidate.

cheers
