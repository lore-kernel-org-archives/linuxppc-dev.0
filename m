Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C29C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 01:21:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9282080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 01:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H9CQWRwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9282080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yrdz4vlGzF3Mn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 12:21:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="H9CQWRwJ";
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yrb024lfzF31w
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 12:19:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7LUWbQKNC9ero45eNqmcVOEcr31ejDs4Sku6065JQqg=; b=H9CQWRwJr57gdh8Cn5tMdDRMt
 +3bCj+5z7MsQV9BsH173LzaHNM4cHq+UAqEGBwU56ZtHGiNtXvdASh1GGGYGZQrmSxMYC/5m7qcyg
 hl497L3otZVRQsp7mP3OzgQxFrLlPORfkqS5dlgVzF/+zy9jVBX0MXKnE81IR82m5SLWEd6ln917F
 D0ks4Y4AZYMnQiZ9tIS+lmzkryJ5VzyXuHErn8FG1pIbDTHqLCETEXAW7QhSzZN2okVLZCkL9Uz8E
 nBAHLU7mOliGG9ryVKbgZ2wVnX6Q3MXSM2u1riFhVFufRPDgDH0lAaEeVHtnt9NN4FJoUlASNWXHa
 WjE6Y47kA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gOYDR-00017k-5S; Mon, 19 Nov 2018 01:19:05 +0000
Date: Sun, 18 Nov 2018 17:19:04 -0800
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <rong.a.chen@intel.com>
Subject: Re: [LKP] dad4f140ed [ 7.709376] WARNING:suspicious_RCU_usage
Message-ID: <20181119011904.GE7861@bombadil.infradead.org>
References: <20181119010820.GM18977@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119010820.GM18977@shao2-debian>
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
 LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, LKP <lkp@01.org>, linux-input@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 19, 2018 at 09:08:20AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is

Umm.  I don't see a 'suspicious RCU usage' message in here.  I see a
lot of vmalloc warnings ... ?

> [    7.699777] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.724561] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.737925] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.750283] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.777903] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.787175] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.796181] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.804841] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
