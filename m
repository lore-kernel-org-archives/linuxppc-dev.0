Return-Path: <SRS0=PO5t=ZF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E00C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 09:07:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F6721A49
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qgoX2qy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F6721A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CdzR754TzF7XS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 20:07:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="qgoX2qy8"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Cdwm0kvnzF62F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2019 20:04:55 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcbc7300000>; Wed, 13 Nov 2019 01:04:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 13 Nov 2019 01:04:48 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:04:48 -0800
Received: from [10.2.160.173] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:04:48 +0000
Subject: Re: [PATCH v3 00/23] mm/gup: track dma-pinned pages: FOLL_PIN,
 FOLL_LONGTERM
To: Daniel Vetter <daniel@ffwll.ch>
References: <20191112000700.3455038-1-jhubbard@nvidia.com>
 <20191112203802.GD5584@ziepe.ca>
 <02fa935c-3469-b766-b691-5660084b60b9@nvidia.com>
 <CAKMK7uHvk+ti00mCCF2006U003w1dofFg9nSfmZ4bS2Z2pEDNQ@mail.gmail.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <7b671bf9-4d94-f2cc-8453-863acd5a1115@nvidia.com>
Date: Wed, 13 Nov 2019 01:02:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHvk+ti00mCCF2006U003w1dofFg9nSfmZ4bS2Z2pEDNQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573635888; bh=WuCLw1mNhRSSrQbzE2XtsJC46JZuOt82gJ5Z6A5sU6M=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=qgoX2qy8q+Pz4xwaUpJCPUDYqLc7AOyeowDXx94iSygezEmzpCR7ZZxo0cljsfswu
 ukE0Cm+f0R483iPntRfn/ABXBRqJdTjYQOd5BMk3/+ahH8sNYpooo8xojMC+j2QKMp
 YnZN0Muwss41C3UGdYFy5MS6hRmL0789DFptbHHfPd5vitO0CxsRYBJyPt01+pG4cX
 6cPdl9NwtrthmFzBA5/mOnD1+FGwYZl+/Gsvcsk8njJ9ZjDk+S/T82e3qWgu+CaLxi
 GAWOKJgmoqYLWXc9CemtInbG0/tG5R+23jPdDf2TY9FLXzVWhi+Ia12J1oxABZoP9Y
 i24f/CxZw1J0Q==
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
 kvm@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, "open
 list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf <bpf@vger.kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev <netdev@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/13/19 12:22 AM, Daniel Vetter wrote:
...
>>> Why are we doing this? I think things got confused here someplace, as
>>
>>
>> Because:
>>
>> a) These need put_page() calls,  and
>>
>> b) there is no put_pages() call, but there is a release_pages() call that
>> is, arguably, what put_pages() would be.
>>
>>
>>> the comment still says:
>>>
>>> /**
>>>   * put_user_page() - release a gup-pinned page
>>>   * @page:            pointer to page to be released
>>>   *
>>>   * Pages that were pinned via get_user_pages*() must be released via
>>>   * either put_user_page(), or one of the put_user_pages*() routines
>>>   * below.
>>
>>
>> Ohhh, I missed those comments. They need to all be changed over to
>> say "pages that were pinned via pin_user_pages*() or
>> pin_longterm_pages*() must be released via put_user_page*()."
>>
>> The get_user_pages*() pages must still be released via put_page.
>>
>> The churn is due to a fairly significant change in strategy, whis
>> is: instead of changing all get_user_pages*() sites to call
>> put_user_page(), change selected sites to call pin_user_pages*() or
>> pin_longterm_pages*(), plus put_user_page().
> 
> Can't we call this unpin_user_page then, for some symmetry? Or is that
> even more churn?
> 
> Looking from afar the naming here seems really confusing.


That look from afar is valuable, because I'm too close to the problem to see
how the naming looks. :)

unpin_user_page() sounds symmetrical. It's true that it would cause more
churn (which is why I started off with a proposal that avoids changing the
names of put_user_page*() APIs). But OTOH, the amount of churn is proportional
to the change in direction here, and it's really only 10 or 20 lines changed,
in the end.

So I'm open to changing to that naming. It would be nice to hear what others
prefer, too...


thanks,
-- 
John Hubbard
NVIDIA
