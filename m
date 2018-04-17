Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QgJS40nLzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 08:43:20 +1000 (AEST)
Received: by mail-pl0-x236.google.com with SMTP id m7-v6so1240307plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:43:20 -0700 (PDT)
Date: Wed, 18 Apr 2018 08:43:07 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V1 00/11] powerpc/mm/book3s64: Support for split pmd ptlock
Message-ID: <20180418084308.79e28ede@gmail.com>
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 16 Apr 2018 16:57:12 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This patch series add split pmd pagetable lock for book3s64. nohash64 also should
> be able to switch to this. I need to workout the code dependency. This series
> also migh have broken the build on platforms otherthan book3s64. I am sending this early
> to get feedback on whether we should continue with the approach.
> 
> We switch the pmd allocator to use something similar to what we already use for
> level 4 pagetable allocation. We get an order 0 page and divide that to fragments
> and hand over fragments when we get request for a pmd pagetable. The pmd lock is
> now stashed in the struct page backing the allocated page.

That's only for the THP case right?

> 
> The series helps in reducing lock contention on mm->page_table_lock.
>

The numbers look good.
