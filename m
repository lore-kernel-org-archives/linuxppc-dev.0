Return-Path: <SRS0=V+RV=ZN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9FCC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 08:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D94D20855
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 08:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GJ7FLsOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D94D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JYNG4sKWzDqDl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 19:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="GJ7FLsOP"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JXzn4yqFzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 19:39:33 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dd64d3b0000>; Thu, 21 Nov 2019 00:39:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 21 Nov 2019 00:39:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 21 Nov 2019 00:39:27 -0800
Received: from [10.2.169.101] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 08:39:26 +0000
Subject: Re: [PATCH v7 06/24] goldish_pipe: rename local pin_user_pages()
 routine
To: Christoph Hellwig <hch@infradead.org>
References: <20191121071354.456618-1-jhubbard@nvidia.com>
 <20191121071354.456618-7-jhubbard@nvidia.com>
 <20191121080831.GD30991@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ca78671b-4ce6-05f6-01ae-2d0b79810956@nvidia.com>
Date: Thu, 21 Nov 2019 00:36:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121080831.GD30991@infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1574325563; bh=IjAmlqSQ50mtR26fvAkI3XcKPC6M4/uU5ND8d4hZ9sk=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=GJ7FLsOPPSpCRACz8ISfrqvd6vXd1a++lXIZbI549CHSZBewXeafsw0KWGYiFyEQk
 AjT450/QZ9YlyRa61hUCDn7RU+Oc8PL9dGnNibH+8bRoPgHv7Hz9Gs/GqPZ/w8xTGJ
 UkFV63r7a5GxMQEBp17Bq1eVxtVmga7DN1IyZXoIl4Zpf7mXrb2vg8FAmf6Cu6rI6y
 ak3fa9vBD/bNjvt15SEsNGr7fQAZcfHOLD1JwudJ1lf0vZTrImmtVmX/zYP64flAJZ
 dWmb9NYUnY/5E0dPUahr3TtiO6k8/kvovVBf9GgTEDfKn0Ljy0UH2gpWXn36gxJ8fZ
 1KUFjQ7Bhke0w==
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
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
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
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/21/19 12:08 AM, Christoph Hellwig wrote:
> On Wed, Nov 20, 2019 at 11:13:36PM -0800, John Hubbard wrote:
>> +static int pin_goldfish_pages(unsigned long first_page,
>> +			      unsigned long last_page,
>> +			      unsigned int last_page_size,
>> +			      int is_write,
>> +			      struct page *pages[MAX_BUFFERS_PER_COMMAND],
>> +			      unsigned int *iter_last_page_size)
> 
> Why not goldfish_pin_pages?  Normally we put the module / subsystem
> in front.

Heh, is that how it's supposed to go?  Sure, I'll change it. :)

> 
> Also can we get this queued up for 5.5 to get some trivial changes
> out of the way?
> 

Is that a question to Andrew, or a request for me to send this as a
separate patch email (or both)?


thanks,
-- 
John Hubbard
NVIDIA
