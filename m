Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHJMY3ywhzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 04:04:56 +1100 (AEDT)
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, akpm@linux-foundation.org,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
Date: Wed, 18 Oct 2017 13:03:10 -0400
MIME-Version: 1.0
In-Reply-To: <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrey,

I asked Will, about it, and he preferred to have this patched added to 
the end of my series instead of replacing "arm64/kasan: add and use 
kasan_map_populate()".

In addition, Will's patch stops using large pages for kasan memory, and 
thus might add some regression in which case it is easier to revert just 
that patch instead of the whole series. It is unlikely that regression 
is going to be detectable, because kasan by itself makes system quiet 
slow already.

Pasha
