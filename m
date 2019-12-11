Return-Path: <SRS0=Dwgl=2B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2128C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 21:27:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081252054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n8ng2gW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081252054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Y94y6s37zDqlf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 08:27:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.143;
 helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="n8ng2gW+"; 
 dkim-atps=neutral
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Y92Y45VJzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2019 08:25:41 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df15eb80000>; Wed, 11 Dec 2019 13:25:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 11 Dec 2019 13:25:34 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 11 Dec 2019 13:25:34 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Dec
 2019 21:25:34 +0000
Subject: Re: [PATCH v9 10/25] mm/gup: introduce pin_user_pages*() and FOLL_PIN
To: Jonathan Corbet <corbet@lwn.net>
References: <20191211025318.457113-1-jhubbard@nvidia.com>
 <20191211025318.457113-11-jhubbard@nvidia.com>
 <20191211135737.581add2f@lwn.net>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <c8930e77-9c99-2d3d-743d-9d58176ea690@nvidia.com>
Date: Wed, 11 Dec 2019 13:25:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211135737.581add2f@lwn.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576099513; bh=h8WoxBOtUL7d4aBHwikvS71dFoLle6Q1qJcgfYlGzoI=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=n8ng2gW+8yccOTJ0sb0qKZBSBkMzrO2w+mX1jwAwhVYYv3FE21MXjsfMjjhApcnib
 wo8d+ZRlDZwi9+66AYkoZtFFMIJupZ7au9saOmm/kNh3KbsRApo1SSaYZzqpFUg9dv
 APDY2cvczFMX0P05ANDG9Wpe8w2DHHN7/JdQsO1AuudRaAw4keF3jV1uyq3uA82xUI
 ieCnDqXdxIHT69mdMVDE/JA7qgs+lLHW/JROAhLDlkZchTV8THtwKre9xUIr3vtdDd
 8O/vqZHRFo4GrCktOUJaI0JiNxox7/Ns2xEUIaiCnKWdDSbo4DOz0JmZdD1qJCvncm
 kDdssHEUgirjg==
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
 linux-kselftest@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-rdma@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
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
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/11/19 12:57 PM, Jonathan Corbet wrote:
> On Tue, 10 Dec 2019 18:53:03 -0800
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> Introduce pin_user_pages*() variations of get_user_pages*() calls,
>> and also pin_longterm_pages*() variations.
> 
> Just a couple of nits on the documentation patch
> 
>> +++ b/Documentation/core-api/pin_user_pages.rst
>> @@ -0,0 +1,232 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +====================================================
>> +pin_user_pages() and related calls
>> +====================================================
>> +
>> +.. contents:: :local:
>> +
>> +Overview
>> +========
>> +
>> +This document describes the following functions: ::
>> +
>> + pin_user_pages
>> + pin_user_pages_fast
>> + pin_user_pages_remote
> 
> You could just say "the following functions::" and get the result you're
> after with a slightly less alien plain-text reading experience.

I see. That works nicely: same result with fewer :'s. 

> 
> Of course, you could also just say "This document describes
> pin_user_pages(), pin_user_pages_fast(), and pin_user_pages_remote()." But
> that's a matter of personal taste, I guess.  Using the function() notation
> will cause the docs system to automatically link to the kerneldoc info,
> though.  

OK. I did try the single-sentence approach just now, but to me the one-per-line
seems to make both the text and the generated HTML slightly easier to look at. 
Of course, like you say, different people will have different preferences. So 
in the end I've combined the tips, like this:

+Overview
+========
+
+This document describes the following functions::
+
+ pin_user_pages()
+ pin_user_pages_fast()
+ pin_user_pages_remote()


> 
>> +Basic description of FOLL_PIN
>> +=============================
>> +
>> +FOLL_PIN and FOLL_LONGTERM are flags that can be passed to the get_user_pages*()
>> +("gup") family of functions. FOLL_PIN has significant interactions and
>> +interdependencies with FOLL_LONGTERM, so both are covered here.
>> +
>> +FOLL_PIN is internal to gup, meaning that it should not appear at the gup call
>> +sites. This allows the associated wrapper functions  (pin_user_pages*() and
>> +others) to set the correct combination of these flags, and to check for problems
>> +as well.
>> +
>> +FOLL_LONGTERM, on the other hand, *is* allowed to be set at the gup call sites.
>> +This is in order to avoid creating a large number of wrapper functions to cover
>> +all combinations of get*(), pin*(), FOLL_LONGTERM, and more. Also, the
>> +pin_user_pages*() APIs are clearly distinct from the get_user_pages*() APIs, so
>> +that's a natural dividing line, and a good point to make separate wrapper calls.
>> +In other words, use pin_user_pages*() for DMA-pinned pages, and
>> +get_user_pages*() for other cases. There are four cases described later on in
>> +this document, to further clarify that concept.
>> +
>> +FOLL_PIN and FOLL_GET are mutually exclusive for a given gup call. However,
>> +multiple threads and call sites are free to pin the same struct pages, via both
>> +FOLL_PIN and FOLL_GET. It's just the call site that needs to choose one or the
>> +other, not the struct page(s).
>> +
>> +The FOLL_PIN implementation is nearly the same as FOLL_GET, except that FOLL_PIN
>> +uses a different reference counting technique.
>> +
>> +FOLL_PIN is a prerequisite to FOLL_LONGTGERM. Another way of saying that is,
> 
> FOLL_LONGTERM typoed there.
> 

Good catch. Fixed.

thanks,
-- 
John Hubbard
NVIDIA


