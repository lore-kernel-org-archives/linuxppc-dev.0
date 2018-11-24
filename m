Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B51C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 04:00:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153AC20673
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 04:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOa3E8ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153AC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431zx53GGfzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 15:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="WOa3E8ve";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431ztK2hjYzDqVV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 14:58:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rnt75NovqVREUcNFpNXwhtKry1MGSJYgxwyIiIT7cjM=; b=WOa3E8veuEPBENe8Rkn2rbWC4
 CcnJVvjxj1938b+WMg+lpH4tBhEQoInXFChdPXzfxhWjAADqWP/N/tyyLzqWrBlOvShmcnzzi1J9c
 cMNShOjvBNiupl8ZU8HN0F/0fxc/KRzRpX7YInRCuxra4em8K2G8CoL8qu1u79HHO0nbQnRSEdc67
 DHkaZ/BZCINx9jMGK34cOyIIcQCkWLcMz8XZhb7q7uu+DkluHqHeXBLzsV9i49LFpUCCOh74eIr1k
 zoBCwOnCDAGMcPYZVzD+MRt2qPgAX+kQpeVYpUzoOqaU9zyh17o41RgfG5j1uQFQX3t09vXeM3kUW
 tq/8y9xgA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gQP51-00050n-Rx; Sat, 24 Nov 2018 03:58:03 +0000
Date: Fri, 23 Nov 2018 19:58:03 -0800
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: dad4f140ed ("Merge branch 'xarray' of .."):  Mem-Info:
Message-ID: <20181124035803.GX3065@bombadil.infradead.org>
References: <5bf8a766.2eiLO6qApoh2dO55%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf8a766.2eiLO6qApoh2dO55%lkp@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-input@vger.kernel.org, linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 24, 2018 at 09:20:38AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit dad4f140edaa3f6bb452b6913d41af1ffd672e45

I think you've got the wrong bisection point, confused by other messages.
Here's the messages I think you intend to chase:

[  155.389297] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck
 for 52s!
[  155.409004] BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 40
s!
[  155.420377] Showing busy workqueues and worker pools:
[  155.428445] workqueue events: flags=0x0
[  155.434634]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[  155.437904]     pending: cache_reap
[  155.449671] workqueue events_power_efficient: flags=0x82
[  155.458000]   pwq 2: cpus=0 flags=0x4 nice=0 active=3/256
[  155.461269]     pending: neigh_periodic_work, do_cache_clean, check_lifetime


but you're getting hung up on the testsuite problems.


