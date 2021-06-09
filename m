Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB7C4743D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 01:48:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62FF61208
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 01:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62FF61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G094k0x0Bz3brx
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 11:48:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G094H0Grkz301t
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 11:48:29 +1000 (AEST)
IronPort-SDR: 5F5DKSmmpecDH51OjZrWrZB1+qyHhXph8b2uk6eM4Inpd0Fxm6CQ6PHxkCm9YIK3p9a+audXLX
 yX6/blnnXGHg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192092861"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="192092861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 18:48:23 -0700
IronPort-SDR: SRFfjIkTZkgdiWUkfbuxO/DHCb0ZQrp7YLBvUKhmAbESyYDmfBnXBu/pgXAlW0d/t+PE9XTYIq
 c7l/dYjK3T5A==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="448117931"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 18:48:23 -0700
Date: Tue, 8 Jun 2021 18:48:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/16] ps3disk: use memcpy_{from,to}_bvec
Message-ID: <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608160603.1535935-10-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linux-mips@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 ceph-devel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 08, 2021 at 06:05:56PM +0200, Christoph Hellwig wrote:
>  
>  	rq_for_each_segment(bvec, req, iter) {
> -		unsigned long flags;
> -		dev_dbg(&dev->sbd.core, "%s:%u: bio %u: %u sectors from %llu\n",
> -			__func__, __LINE__, i, bio_sectors(iter.bio),
> -			iter.bio->bi_iter.bi_sector);
> -
> -		size = bvec.bv_len;
> -		buf = bvec_kmap_irq(&bvec, &flags);
>  		if (gather)
> -			memcpy(dev->bounce_buf+offset, buf, size);
> +			memcpy_from_bvec(dev->bounce_buf + offset, &bvec);
>  		else
> -			memcpy(buf, dev->bounce_buf+offset, size);
> -		offset += size;
> -		flush_kernel_dcache_page(bvec.bv_page);

I'm still not 100% sure that these flushes are needed but the are not no-ops on
every arch.  Would it be best to preserve them after the memcpy_to/from_bvec()?

Same thing in patch 11 and 14.

Ira
