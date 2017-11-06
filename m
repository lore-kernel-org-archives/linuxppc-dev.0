Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVx3J1JcfzDr6m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 02:16:12 +1100 (AEDT)
Subject: Re: [PATCH 0/5] VA allocator fixes
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <cc66ea81-fd9a-0bd5-8a8c-5abdc604200b@redhat.com>
Date: Mon, 6 Nov 2017 16:16:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2017 11:03 AM, Nicholas Piggin wrote:
> Florian found a nasty corner case with the VA allocation logic
> for crossing from 128TB to 512TB limit on hash, and made a
> really superb report of the problem -- traces, reproducer recipes,
> analysis, etc. which already mostly solved it.
> 
> The first patch in the series should solve Florian's particular
> case, the next 3 are other issues with addr_limit. The last
> patch is technically a cleanup but I think it's fairly important
> in terms of understanding the code and also enabling some BUG
> checks (when addr_limit == 0).
> 
> I have not tested these exactly on Florian's test case, but
> some tests of my own behave better afterwards. Hopefully he has
> time to re-test. Some careful review would be welcome too.

I think I have applied the five patches you posted, but I still get a 
brk value above 128 TiB:

# /lib64/ld64.so.1 ./a.out
initial brk value: 0x7fffde960000
probing at 0x80000001fffc

I assumed you wanted to reject those?

In either case, I recommend to tweak the VM layout, so that ld.so does 
not land closely to to the 128 TiB limit, so that the brk failure or 
returning of 48-bit addresses is avoided.

Thanks,
Florian
