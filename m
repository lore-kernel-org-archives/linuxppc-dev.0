Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996491A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 18:15:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 13:44:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 118553940079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:43:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T8DiYg13893722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:43:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T8DiFQ006188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:43:44 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/31] powerpc/mm: Convert 4k hash insert to C
In-Reply-To: <1442823396.2819.2.camel@kernel.crashing.org>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823396.2819.2.camel@kernel.crashing.org>
Date: Tue, 29 Sep 2015 13:43:43 +0530
Message-ID: <874midprrc.fsf@linux.vnet.ibm.com>
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


I looked at the performance number with and without patch. I don't see much
impact in the numbers. We do have a path lengh increase ( I measured this
using systemsim)

Path length __hash_page_4k
with patch: 196
without patch: 142

Path length __hash_page_64k
with patch: 219
without patch: 154


But even if we have a path lengh increase of around 50 instructions. We don't see
the impact when running workload. I tried the kernelbuild test. 

With THP enabled (which is default) we see an improvement. I haven't fully looked at
the reason. This could be due to reduced contention of ptl lock. __hash_thp_page is
already a C code.

make -j64 vmlinux modules 
With fix:
---------
real    1m35.509s
user    56m8.565s
sys     4m34.973s

real    1m32.174s
user    57m2.336s
sys     4m39.142s

Without fix:
---------------
real    1m37.703s
user    58m50.783s
sys     7m52.440s


real    1m37.890s
user    57m55.445s
sys     7m50.501s


THP disabled:

make -j64 vmlinux modules 
With fix:
---------
real    1m37.197s
user    58m28.672s
sys     7m58.188s

real    1m44.638s
user    58m37.551s
sys     7m53.960s

Without fix:
------------
real    1m41.224s
user    58m46.944s
sys     7m49.714s


real    1m42.585s
user    59m14.019s
sys     7m52.714s


-aneesh
