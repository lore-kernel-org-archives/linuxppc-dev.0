Return-Path: <SRS0=EHb9=YY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F87CA9ECB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345132080F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ItGdt9jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345132080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473vRH13cpzF6FP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 05:46:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.65; helo=hqemgate16.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="ItGdt9jP"; 
 dkim-atps=neutral
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473vNb3sPCzF61D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 05:43:42 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dbb2b600000>; Thu, 31 Oct 2019 11:43:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Oct 2019 11:43:38 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Oct 2019 11:43:38 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 18:43:37 +0000
Subject: Re: [PATCH 02/19] mm/gup: factor out duplicate code from four routines
To: Ira Weiny <ira.weiny@intel.com>
References: <20191030224930.3990755-1-jhubbard@nvidia.com>
 <20191030224930.3990755-3-jhubbard@nvidia.com>
 <20191031183549.GC14771@iweiny-DESK2.sc.intel.com>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <75b557f7-24b2-740c-2640-2f914d131600@nvidia.com>
Date: Thu, 31 Oct 2019 11:43:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031183549.GC14771@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1572547424; bh=tVTQ7w70LzXRWNozMw5pcweYnGaSw6wKS7taKOoMvgQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ItGdt9jPwuaxZEwBZAmOs6QRw3y1ekRCXIkAk884e9fffuoHSkMv3IXuQ7vsU8mJ+
 6sn7OAiE4sod/01pqRwiHcd242kDvH4VxxD334MsuTzmzdN+z2Tf4SkqA4hAm5RUgb
 DQz3BJUfTbN/krdQz9Fy07dfiumXVmkiVCv2liRNNsMOm+vluNn2/EZjBIhVCKbXA7
 WVHpKyr4oMIxF6v1Zhp2z85oNzL7rjapLTslb3D5k7UtqTOOxnqps/GxGVAfXIr7tc
 /ZNTHbsdctd0KY29GLOk6czDGwBpbgAriROyniZOORRqIrKjgDjOEDFf1BfnHlTH/3
 EDGo/Nn1OpOQw==
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
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Aneesh Kumar
 K . V" <aneesh.kumar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/31/19 11:35 AM, Ira Weiny wrote:
> On Wed, Oct 30, 2019 at 03:49:13PM -0700, John Hubbard wrote:
...
>> +
>> +static void __remove_refs_from_head(struct page *page, int refs)
>> +{
>> +	/* Do a get_page() first, in case refs == page->_refcount */
>> +	get_page(page);
>> +	page_ref_sub(page, refs);
>> +	put_page(page);
>> +}
> 
> I wonder if this is better implemented as "put_compound_head()"?  To match the
> try_get_compound_head() call below?

Hi Ira,

Good idea, I'll rename it to that.

> 
>> +
>> +static int __huge_pt_done(struct page *head, int nr_recorded_pages, int *nr)
>> +{
>> +	*nr += nr_recorded_pages;
>> +	SetPageReferenced(head);
>> +	return 1;
> 
> When will this return anything but 1?
> 

Never, but it saves a line at all four call sites, by having it return like that.

I could see how maybe people would prefer to just have it be a void function,
and return 1 directly at the call sites. Since this was a lower line count I
thought maybe it would be slightly better, but it's hard to say really.

thanks,

John Hubbard
NVIDIA
