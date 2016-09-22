Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfp4M3d6bzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 17:28:03 +1000 (AEST)
Received: from localhost (unknown [192.168.12.234])
 by localhost (Postfix) with ESMTP id 3sfp4D1Dyqz9ttFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id V5pZz93UrJfB for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 3sfp4D0n78z9ttFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6571D8B8B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WbbF5Izuwaij for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
Received: from [127.0.0.1] (po10863.idsi0.si.c-s.fr [172.25.231.27])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 46A528B79A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 09:27:56 +0200 (CEST)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc: port 64 bits pgtable_cache to 32 bits
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
 <23a3735dcff5f26f55b8d6051d95c683b7f5947f.1474441302.git.christophe.leroy@c-s.fr>
Message-ID: <5f387783-1644-7b9c-0051-c527be9e3271@c-s.fr>
Date: Thu, 22 Sep 2016 09:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <23a3735dcff5f26f55b8d6051d95c683b7f5947f.1474441302.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Today powerpc64 uses a set of pgtable_caches while powerpc32 uses
> standard pages when using 4k pages and a single pgtable_cache
> if using other size pages.
>
> In preparation of implementing huge pages on the 8xx, this patch
> replaces the specific powerpc32 handling by the 64 bits approach.
>
> This is done by:
> * moving 64 bits pgtable_cache_add() and pgtable_cache_init()
> in a new file called init-common.c
> * modifying pgtable_cache_init() to also handle the case
> without PMD
> * removing the 32 bits version of pgtable_cache_add() and
> pgtable_cache_init()
> * copying related header contents from 64 bits into both the
> book3s/32 and nohash/32 header files
>
> On the 8xx, the following cache sizes will be used:
> * 4k pages mode:
> - PGT_CACHE(10) for PGD
> - PGT_CACHE(3) for 512k hugepage tables
> * 16k pages mode:
> - PGT_CACHE(6) for PGD
> - PGT_CACHE(7) for 512k hugepage tables
> - PGT_CACHE(3) for 8M hugepage tables
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

-aneesh
