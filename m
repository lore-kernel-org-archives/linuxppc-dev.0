Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3AC4743D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:00:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6525A61287
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6525A61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G09Kq3P1Hz2yy9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 12:00:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G09KG6cmwz2xfT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 11:59:46 +1000 (AEST)
IronPort-SDR: f7gaLjpQU0uec3xlrcZNr+6o699HhWynYJH6jLxuxpQK6bcl5Qpicy1lOzsSCi0pTQNx6LXnJy
 HUsp2owaFZjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192094055"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="192094055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 18:59:44 -0700
IronPort-SDR: l5m0zsMDo0S/BY6flob2JC9Z0fcbfXs0snnKIkUOGNUZsN5SIUPiUFSjvaStBruug7QhFYdMqJ
 TyBwGFTSV0lA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="482201365"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 18:59:44 -0700
Date: Tue, 8 Jun 2021 18:59:43 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: switch the block layer to use kmap_local_page
Message-ID: <20210609015943.GV3697498@iweiny-DESK2.sc.intel.com>
References: <20210608160603.1535935-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608160603.1535935-1-hch@lst.de>
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

On Tue, Jun 08, 2021 at 06:05:47PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the core block layer code and all users of the
> existing bvec kmap helpers to use kmap_local_page.  Drivers that
> currently use open coded kmap_atomic calls will converted in a follow
> on series.

Other than the missing flush_dcache's.

For the series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Diffstat:
>  arch/mips/include/asm/mach-rc32434/rb.h |    2 -
>  block/bio-integrity.c                   |   14 ++++------
>  block/bio.c                             |   37 +++++++---------------------
>  block/blk-map.c                         |    2 -
>  block/bounce.c                          |   35 ++++++--------------------
>  block/t10-pi.c                          |   16 ++++--------
>  drivers/block/ps3disk.c                 |   19 ++------------
>  drivers/block/rbd.c                     |   15 +----------
>  drivers/md/dm-writecache.c              |    5 +--
>  include/linux/bio.h                     |   42 --------------------------------
>  include/linux/bvec.h                    |   27 ++++++++++++++++++--
>  include/linux/highmem.h                 |    4 +--
>  12 files changed, 64 insertions(+), 154 deletions(-)
