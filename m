Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94DA21A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 20:26:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 15:56:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1BE20E005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:56:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L9ffM545940770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:56:32 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L8w9et020506
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 14:28:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/31] powerpc/mm: Convert 4k hash insert to C
In-Reply-To: <1442823396.2819.2.camel@kernel.crashing.org>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823396.2819.2.camel@kernel.crashing.org>
Date: Mon, 21 Sep 2015 14:27:58 +0530
Message-ID: <87k2rkdu95.fsf@linux.vnet.ibm.com>
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

> On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/Makefile        |   3 +
>>  arch/powerpc/mm/hash64_64k.c    | 204 +++++++++++++++++++++
>>  arch/powerpc/mm/hash_low_64.S   | 380 ------------------------------
>> ----------
>>  arch/powerpc/mm/hash_utils_64.c |   4 +-
>>  4 files changed, 210 insertions(+), 381 deletions(-)
>>  create mode 100644 arch/powerpc/mm/hash64_64k.c
>
> Did you check if there was any measurable performance difference ?
>

Not with this patch series. I did look at the .s file generated between
__hash_page_4k and hash64_4k.c and found them similar. 

I will also try some micro benchmarks w.r.t hash insert/update and will
update later with numbers.

-aneesh
