Return-Path: <SRS0=uftn=2G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233EC43603
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B982072B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="amsVlFr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B982072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cG5j5cjLzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 09:24:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.143;
 helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="amsVlFr4"; 
 dkim-atps=neutral
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cG3819dlzDqR2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 09:21:55 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df803630000>; Mon, 16 Dec 2019 14:21:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 16 Dec 2019 14:21:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 14:21:50 -0800
Received: from [10.2.165.205] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 22:21:49 +0000
Subject: Re: [PATCH v11 23/25] mm/gup: track FOLL_PIN pages
To: Jan Kara <jack@suse.cz>
References: <20191212101741.GD10065@quack2.suse.cz>
 <20191214032617.1670759-1-jhubbard@nvidia.com>
 <20191216125353.GF22157@quack2.suse.cz>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <86297621-0200-01db-923b-9f8d3ee87354@nvidia.com>
Date: Mon, 16 Dec 2019 14:18:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216125353.GF22157@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576534883; bh=YMhg/Haff63lefKvHJkcKDJlwsa7xb5b4lrnUemlU7g=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=amsVlFr4hw9MYNrHr5/DYyX51JWA4Fkp/OrGL5Hbx4jMwoyI9BWBiyVnsOuxsMRIB
 iaLSTfEX4Yqo/iVj68XTBu0YqNDpOKgLZv4iJJL9jXaVCKbZ5JRpa2udb5A5igVcw2
 1sJ9NO2FUwaGqY/GZOYBsW4L6j0KjdlhAuITY2UHIyczf/OJ5Ld/YorqU0JPKNcd1d
 I994/z/XcmSLl51Zt+AHfBnbzOf+k0FilaRTGpdBKRUjSH3tUdnc5ed7upp7HB/ZdP
 yPbbF1+4hTs972ehSF2pBSOHKp1BKWsgCDOuYbNfow5D4LRa3DPocQgihOq0BFqmMR
 WOmZ1eSWqtu/A==
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
Cc: Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/16/19 4:53 AM, Jan Kara wrote:
...

> I'd move this still a bit higher - just after VM_BUG_ON_PAGE() and before
> if (flags & FOLL_TOUCH) test. Because touch_pmd() can update page tables
> and we don't won't that if we're going to fail the fault.
> 

Done. I'll post a full v11 series shortly.

> With this fixed, the patch looks good to me so you can then add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 

btw, thanks for the thorough review of this critical patch (and for your
patience with my mistakes). I really appreciate it, and this patchset would
not have made it this far without your detailed help and explanations.


thanks,
-- 
John Hubbard
NVIDIA
