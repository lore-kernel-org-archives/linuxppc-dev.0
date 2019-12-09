Return-Path: <SRS0=oaAR=Z7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25CC43603
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 23:54:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D173D20721
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 23:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ihr9PvOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D173D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47X0R93zs1zDqSQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 10:54:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.65;
 helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="Ihr9PvOr"; 
 dkim-atps=neutral
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47X0G82LFgzDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 10:46:40 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5deedcd50000>; Mon, 09 Dec 2019 15:46:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 09 Dec 2019 15:46:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 09 Dec 2019 15:46:35 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec
 2019 23:46:34 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec 2019
 23:46:34 +0000
Subject: Re: [PATCH v8 20/26] powerpc: book3s64: convert to pin_user_pages()
 and put_user_page()
To: Andrew Morton <akpm@linux-foundation.org>
References: <20191209225344.99740-1-jhubbard@nvidia.com>
 <20191209225344.99740-21-jhubbard@nvidia.com>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <08f5d716-8b31-b016-4994-19fbe829dc28@nvidia.com>
Date: Mon, 9 Dec 2019 15:46:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191209225344.99740-21-jhubbard@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1575935189; bh=F+Jj+I6m5b/J9KOGS4UgD+CyKLIIOUmRatgjOS3uz0Y=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Ihr9PvOrf4hppHWZcETbUAQh9t9Aev3oHDGCoIypSp3n/NX/AuC/Td0gE6AmeDIUE
 2+DT2NTLT9eP7U1PFgWavm5zzTvPlCDL5cWWUpkrpD60HT7XF7/5PaBcDrqebNpuex
 CI+QS4g3QKJbV4WzqLe9+cTj1E1lVYuR0ZJtmRhZpYLLoZW9GXVF72aUROzLtSMDuT
 v0HaolI7qQoROQScZaDiu3CN2mz+32WCjaJtRJLPhJNY7eBr0NjQYl2fNOij0hv+9K
 AR+SKxG6MA/CqvylD8YhPmC/JAQ+Ecqay7f94R+oer9y3owEi11v6+bX3P3xFoNI7R
 rN6yFpWqkjcOQ==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Paul
 Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/9/19 2:53 PM, John Hubbard wrote:
...
> @@ -212,10 +211,9 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>  		if (!page)
>  			continue;
>  
> -		if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
> -			SetPageDirty(page);
> +		put_user_pages_dirty_lock(&page, 1,
> +				mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY);
>  
> -		put_page(page);


Correction: this is somehow missing the fixes that resulted from Jan Kara's review (he
noted that we can't take a page lock in this context). I must have picked up the 
wrong version of it, when I rebased for -rc1.

Will fix in the next version (including the commit description). Here's what the
corrected hunk will look like:

@@ -215,7 +214,8 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
                if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
                        SetPageDirty(page);
 
-               put_page(page);
+               put_user_page(page);
+
                mem->hpas[i] = 0;
        }
 }


thanks,
-- 
John Hubbard
NVIDIA
