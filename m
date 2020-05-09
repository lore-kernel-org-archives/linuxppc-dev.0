Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D791C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 15:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A220CC7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bCOSwnBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A220CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49K9cG0JZvzDr48
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 01:10:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2a00:1450:4864:20::62e;
 helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=bCOSwnBB; dkim-atps=neutral
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49K9Y84XbjzDr2q
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 01:07:31 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id n17so3882657ejh.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2020 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
 b=bCOSwnBBjfPXdvYGJ+yVECFvPTePDH1ANyISrMhvJ1qWqJvVThnHr98KsSwJqA14nC
 yCPOxIRhJYUKs+I0Z7zlDnbc2VJgVwWpDdEA4tIPWEVVkzgs6TyhzHr/LnVPIJc5YbZe
 /Ga31Bb5nRqdr5sF01D+4kD7nuppvALvlvKumT0LdbEKLra5xfeiNf57Wv0ExKnHb7Rg
 DbJPWuDEL/VR1p8vve4AZ1c4iNgOcgeDoJddMOToTohvJc+NMCp5pllqs5xHvWVFoT1b
 hZ2eMoVCvm/W3nphozJEpzuE720t10XyAVjkj8Y23QAnpJ3YgiSQvtyoRGLEW8+4DwBB
 HlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
 b=KZON/ZwTkMUocSBDRLi80KVLxZKsEkpAZqC3oj1k6t9/0LLazxesTHv6DD6cFBAzE9
 CT5cPHPJNiNiUtkO6zZmD+TqQbol12qrG87WrSQUHrB3vyJMs4WHUUEAvol4v4G/0kmI
 Y25o7ShOSxZri2qDXbaMaMZrJFWvF1EPDGybJRa6gKtQ5LUj+vUyFU1reBpwl9dr4XfJ
 +628OMacCrG/zabuuGujaR6JwDjBcD6nNzYz7l2rJ5CyHKW3t8gbUtotk8TzKqZa+qvD
 4aHGrfLhLhRZP8tJIBb1esGf33TKZ2JfkahBjrZt1Zs1Rp2yRpmJJKnwjRcg55sIPFBe
 BLIw==
X-Gm-Message-State: AGi0PuY3hA/yI4vGAEZbzYZ3Qy7YGBqYTo9d9qhB9jGiYSyS3yMy1N+A
 xfODKbaKaEUxbGPG5PE3KVY7zaj3+15wvgwEarNZ9g==
X-Google-Smtp-Source: APiQypKilW3QgeYL9j+z8BH4y4sSKlWKWi60GEoJhZT78wFbACZI36hD4PovUMVH8UfEyvLbc+3je7NxPGD32jSs39Q=
X-Received: by 2002:a17:906:855a:: with SMTP id
 h26mr6685025ejy.56.1589036845508; 
 Sat, 09 May 2020 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de>
 <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de>
In-Reply-To: <20200509082352.GB21834@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 9 May 2020 08:07:14 -0700
Message-ID: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
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
 linux-nvdimm <linux-nvdimm@lists.01.org>, Geoff Levand <geoff@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jim Paris <jim@jtan.com>, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, linux-m68k@lists.linux-m68k.org,
 Philip Kelleher <pjk1939@linux.ibm.com>, linux-bcache@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Morris <josh.h.morris@us.ibm.com>, Nitin Gupta <ngupta@vflare.org>,
 drbd-dev@lists.linbit.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 9, 2020 at 1:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 08, 2020 at 11:04:45AM -0700, Dan Williams wrote:
> > On Fri, May 8, 2020 at 9:16 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > various bio based drivers use queue->queuedata despite already having
> > > set up disk->private_data, which can be used just as easily.  This
> > > series cleans them up to only use a single private data pointer.
> >
> > ...but isn't the queue pretty much guaranteed to be cache hot and the
> > gendisk cache cold? I'm not immediately seeing what else needs the
> > gendisk in the I/O path. Is there another motivation I'm missing?
>
> ->private_data is right next to the ->queue pointer, pat0 and part_tbl
> which are all used in the I/O submission path (generic_make_request /
> generic_make_request_checks).  This is mostly a prep cleanup patch to
> also remove the pointless queue argument from ->make_request - then
> ->queue is an extra dereference and extra churn.

Ah ok. If the changelogs had been filled in with something like "In
preparation for removing @q from make_request_fn, stop using
->queuedata", I probably wouldn't have looked twice.

For the nvdimm/ driver updates you can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...or just let me know if you want me to pick those up through the nvdimm tree.
