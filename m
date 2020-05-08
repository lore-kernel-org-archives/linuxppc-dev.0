Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB178C47257
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 03:17:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611CB21974
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 03:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RncL95G1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYNToviy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611CB21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Jsnr46snzDrCD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 13:17:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=ming.lei@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RncL95G1; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYNToviy; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Jl3V2L3RzDrBr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 08:13:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588976026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XTZwXR9Z9h3mhkEx2o1bmyDVneFoc2pkGAjVYehhi0=;
 b=RncL95G1n8XUFTaOJapGjDj95acCt1Ym8G7H4dJNG+Pg/r++EnkX0nzb+ThOgN72Me9yXe
 WsaRj8D9yI3Ucsci75A3DbsOc8Js8j4XzsO78PM5KE213nqNF+F2VD3K2sda8Jq6P0cAh7
 ocx771djD+y41WVPdMyFq98Bp9i2vPQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588976027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XTZwXR9Z9h3mhkEx2o1bmyDVneFoc2pkGAjVYehhi0=;
 b=DYNToviyiMl7w9UQ7gUvhh4rfgDyGWwcDsjwd27ECg2H3FwzzSssQXrTZcpq+3N7UBFMm1
 Vu0a1br9K1I1rIwmOj6Qx1d0WI/+76mtYQ3/Vm8jkJxxDipFgxnawZQYtdT21dapbfb3HL
 lnYUcnow49Lv4KkpYGMEYM4Cnrgdi2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-d2xIQt37O8yux2pmv4ZgAg-1; Fri, 08 May 2020 18:13:42 -0400
X-MC-Unique: d2xIQt37O8yux2pmv4ZgAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828A51005510;
 Fri,  8 May 2020 22:13:39 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74FBC1001B07;
 Fri,  8 May 2020 22:13:27 +0000 (UTC)
Date: Sat, 9 May 2020 06:13:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove a few uses of ->queuedata
Message-ID: <20200508221321.GD1389136@T590>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mailman-Approved-At: Sat, 09 May 2020 13:15:46 +1000
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
 linux-raid@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
 linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
 linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 linux-m68k@lists.linux-m68k.org, Philip Kelleher <pjk1939@linux.ibm.com>,
 linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joshua Morris <josh.h.morris@us.ibm.com>, Nitin Gupta <ngupta@vflare.org>,
 drbd-dev@lists.linbit.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 08, 2020 at 06:15:02PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> various bio based drivers use queue->queuedata despite already having
> set up disk->private_data, which can be used just as easily.  This
> series cleans them up to only use a single private data pointer.
> 
> blk-mq based drivers that have code pathes that can't easily get at
> the gendisk are unaffected by this series.

Yeah, before adding disk, there still may be requests queued to LLD
for blk-mq based drivers.

So are there this similar situation for these bio based drivers?


Thanks,
Ming

