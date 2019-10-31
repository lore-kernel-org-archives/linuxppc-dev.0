Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D00CA9ECB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 00:04:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502312086D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 00:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="huUn94OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502312086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4742VJ6flGzF6TB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 11:04:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.65; helo=hqemgate16.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="huUn94OR"; 
 dkim-atps=neutral
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4742GK5JmZzF5k1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 10:53:45 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dbb74090000>; Thu, 31 Oct 2019 16:53:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Oct 2019 16:53:40 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Oct 2019 16:53:40 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 23:53:39 +0000
Subject: Re: [PATCH 19/19] Documentation/vm: add pin_user_pages.rst
To: Ira Weiny <ira.weiny@intel.com>
References: <20191030224930.3990755-1-jhubbard@nvidia.com>
 <20191030224930.3990755-20-jhubbard@nvidia.com>
 <20191031234922.GM14771@iweiny-DESK2.sc.intel.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <85de5845-d403-dc31-4f3b-f006c4a7b2a2@nvidia.com>
Date: Thu, 31 Oct 2019 16:53:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031234922.GM14771@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1572566026; bh=vjWEFq7fNfPLFBVwJSkbaC93kNFVP4oSS83LfHWMvq4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=huUn94OR5NVpnI/NdJ3vTkz0Aags6KkZKFci9Fz5nHWE/pFd85Cktt11D1CQUWnOi
 UTPR4qv0QPFgv/ONDQLcPNmALzbnAKqxnplv+MLSg0Lt5g7PakxG9E1PUBNwTzA4dg
 k5IpEf3tN9qoIDtETnu//UzIRidkW3Ptv7qB5nHQktouL6xNQxT4kKgi3v8i+IvKdv
 ffAJkGbaVSplOPwrv6cDHUyGv5RC9JGCEhmv/YdTyy6OAb8LAtR2JiVi7nJzrIOI/o
 Ji4iiKunwQFUjG8sIvZShB4w9wwsMfCPKf36InyfzANf6JSqnPhJXe3qBOy7AOjUTp
 IqJ2SDnd3CyHg==
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
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, linux-block@vger.kernel.org,
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

On 10/31/19 4:49 PM, Ira Weiny wrote:
> On Wed, Oct 30, 2019 at 03:49:30PM -0700, John Hubbard wrote:
>> Document the new pin_user_pages() and related calls
>> and behavior.
>>
>> Thanks to Jan Kara and Vlastimil Babka for explaining the 4 cases
>> in this documentation. (I've reworded it and expanded on it slightly.)
> 
> As I said before I think this may be better in a previous patch where you
> reference it.

Yes, I'll merge this in with patch #5 ("mm/gup: introduce pin_user_pages*()
and FOLL_PIN").

...
>> +TODO: There is also a special case when the pages are DAX pages: in addition to
>> +the above flags, the caller needs something like a layout lease on the
>> +associated file. This is yet to be implemented. When it is implemented, it's
>> +expected that the lease will be a prerequisite to setting FOLL_LONGTERM.
> 
> For now we probably want to leave this note out until we figure out how this is
> going to work.  Best to say something like:
> 
> Some pages, such as DAX pages, can't be pinned with longterm pins and will
> fail.
> 

OK, that is better, I'll use that instead of the "TODO".


thanks,

John Hubbard
NVIDIA
