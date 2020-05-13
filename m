Return-Path: <SRS0=uIst=63=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D9DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 18:35:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBF3205CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 18:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBF3205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49MjzJ0DHyzDqg4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 04:35:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49MjwX1ZfCzDqc7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 04:33:13 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0F27368C65; Wed, 13 May 2020 20:33:05 +0200 (CEST)
Date: Wed, 13 May 2020 20:33:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Song Liu <song@kernel.org>
Subject: Re: [PATCH 12/15] md: stop using ->queuedata
Message-ID: <20200513183304.GA29895@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
 <20200508161517.252308-13-hch@lst.de>
 <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-raid <linux-raid@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
 open list <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, linux-m68k@lists.linux-m68k.org,
 Philip Kelleher <pjk1939@linux.ibm.com>, linux-bcache@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 13, 2020 at 11:29:17AM -0700, Song Liu wrote:
> On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for the cleanup. IIUC, you want this go through md tree?

Yes, please pick it up though the md tree.
