Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wPbjz0JVqzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 02:57:11 +1000 (AEST)
Date: Fri, 12 May 2017 12:57:08 -0400 (EDT)
Message-Id: <20170512.125708.475573831936972365.davem@davemloft.net>
To: pasha.tatashin@oracle.com
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
References: <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
 <9088ad7e-8b3b-8eba-2fdf-7b0e36e4582e@oracle.com>
 <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 11 May 2017 16:59:33 -0400

> We should either keep memset() only for deferred struct pages as what
> I have in my patches.
> 
> Another option is to add a new function struct_page_clear() which
> would default to memset() and to something else on platforms that
> decide to optimize it.
> 
> On SPARC it would call STBIs, and we would do one membar call after
> all "struct pages" are initialized.

No membars will be performed for single individual page struct clear,
the cutoff to use the STBI is larger than that.
