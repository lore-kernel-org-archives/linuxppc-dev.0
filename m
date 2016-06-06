Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNNfW4jD8zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 15:33:55 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id b5so3407380pas.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jun 2016 22:33:55 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: use _raw variant of page table accessors
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <7ba4cc59-351c-e990-97b4-c3429a0e7f34@gmail.com>
 <1465165853.4274.22.camel@kernel.crashing.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f07f14bc-ab84-a211-e708-589337b23e13@gmail.com>
Date: Mon, 6 Jun 2016 15:33:45 +1000
MIME-Version: 1.0
In-Reply-To: <1465165853.4274.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/06/16 08:30, Benjamin Herrenschmidt wrote:
> On Fri, 2016-06-03 at 15:34 +1000, Balbir Singh wrote:
>>
>> Can we just save the cpu_to_be64(_PAGE_PTE) as _BE64_PAGE_PTE constant
>> in big-endian (pgtable-be-types.h) and similar for other things. I know its
>> not the best option, but we don't really expect these bits to change often or anymore
>>
> How does that help ? The compiler solves it at compile time either
> way, I'm not sure adding yet another constant will improve
> readability here.
> 

I think your right, but having those constants will prevent people from converting from
be64 to cpu, then or'ing and converting back. As long as programmers stick to pxx_raw()
for manipulation we should be in good shape. I was hoping the BE constants would do that,
but its just a matter of discipline

Balbir
