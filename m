Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C02C33C9E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 23:32:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCCC222C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 23:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu0y5Rty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCCC222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47y6Dj5l2GzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jan 2020 10:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=Gu0y5Rty; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47y69n6VltzDqDl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2020 10:29:32 +1100 (AEDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76F8C24679;
 Tue, 14 Jan 2020 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579044570;
 bh=k4eU69C07g5/9QQrVCph8KAUUUUEi8RmXHDj6/HO/Ik=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Gu0y5RtywBnxt/5MHNzmIuAGL99UYOUTR4MOUoFz/V8A0XNK0I0bw+ID9QXrLG+b9
 4yxWu1bIpxAgRKCCzCYPru9Le6et10vSO5ADJMjyl++hjxh7tjrdlkd5kSXYwv5i4H
 zD3MC1qTDzqpxI561Q50RCSE3Ph+HIgvwbWCQkns=
Date: Tue, 14 Jan 2020 15:29:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 00/22] mm/gup: prereqs to track dma-pinned pages:
 FOLL_PIN
Message-Id: <20200114152929.807fecabfe2258ae2707a88b@linux-foundation.org>
In-Reply-To: <9d7f3c1a-6020-bdec-c513-80c5399e55d7@nvidia.com>
References: <20200107224558.2362728-1-jhubbard@nvidia.com>
 <2a9145d4-586e-6489-64e4-0c54f47afaa1@nvidia.com>
 <9d7f3c1a-6020-bdec-c513-80c5399e55d7@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?ISO-8859-1?Q?J=E9r?= =?ISO-8859-1?Q?=F4me?= Glisse <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Tue, 14 Jan 2020 12:15:08 -0800 John Hubbard <jhubbard@nvidia.com> wrote:

> > 
> > Hi Andrew and all,
> > 
> > To clarify: I'm hoping that this series can go into 5.6.
> > 
> > Meanwhile, I'm working on tracking down and solving the problem that Leon
> > reported, in the "track FOLL_PIN pages" patch, and that patch is not part of
> > this series.
> > 
> 
> Hi Andrew and all,
> 
> Any thoughts on this?

5.6 is late.  But it was in -mm before (briefly) and appears to be
mature and well-reviewed.

I'll toss it in there and shall push it into -next hopefully today. 
Let's decide 2-3 weeks hence.

