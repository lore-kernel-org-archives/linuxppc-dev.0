Return-Path: <SRS0=rLAe=LB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE356C47082
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 04:43:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9E36120F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 04:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9E36120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fz13Y3Y1Jz3btL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 14:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=mUwrryrM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::62e;
 helo=mail-pl1-x62e.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=mUwrryrM; dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fz1314w0jz2yj1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jun 2021 14:43:18 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id c13so7978069plz.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Jun 2021 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CRj471fcopWwQDLwVjladgw5/TWtqNQ37b4ozfCN7s8=;
 b=mUwrryrMK2/51rlcR19uFKtt3Uz+vhowS1qfTyT3U4jbSFAWkNWauh6vZ1LO5VmIVs
 5ECi3fnIpqEf7SJMnMZB8oq3crwKNTWITd/ZeOFm876BQIrYAX3u/vNdV2CgZCK01tkz
 C8YU7ud0HQKax1RxO59EYt6KRwvWGHRSNo9PWsgDov28KfdcU8hcxJqxXgxw+nPdjo7K
 342fva71vreSrrP8Kmd82X7Kbm8YcsSnvq3hNSryExEQqxyEuVJkiKabNqk+zLsUk8un
 QX0WKhwpmqtVabr66aXRDGAcLJ6aoyf/DzL3OqIqE10TWaZPFDhN5OQPz3qcG9KZwqa3
 ZqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CRj471fcopWwQDLwVjladgw5/TWtqNQ37b4ozfCN7s8=;
 b=uFa5jj76uianbBXdbkWWtcpTubmkQr8lxCRNFhntzgmKDSzUV7THicujxUGwY6AZsf
 HXOKEeF+aOuosaVsvqWv04JoBPo/8vmaHSn23tsMyxXtU1nJFpFmtrM014qpC473NwTw
 TD7sis8v839kkNf++sQ9WgMNZPYO74Z3bBQX0+Hbt8mRb1O09bgxZYrJM3LqbCf0Dp2g
 pmqJxAOHmR/KHl9ZFj/qQrk0wAtDytKfsxXWD06DhZO7GadDntqPSjUfcFHEH49JLfnO
 0rJCitTfHRdmPmZkj1uQlyTwG8RJ/RZ8B/pqziJ1oqK4SZiVB+4YffiyVhJh2/yVEZ+D
 fePQ==
X-Gm-Message-State: AOAM530j+SP1g6HhA3N61HVEnn0Vg0ecJxC6t5flJ9s1AVKoC40dRF1x
 F6v67PwhEIvSHvfxA46P/M5nSh9fTPZCbuU2MpoKHA==
X-Google-Smtp-Source: ABdhPJylkfr3HkdoqNF9xRMFqCn7oO5cpDCL+nuDgN1ppB6ZETr18hlSAOgBmuySRxZfODa5nUP7K4JpxKKLUl+WZPE=
X-Received: by 2002:a17:902:f1cb:b029:10c:5c6d:88b with SMTP id
 e11-20020a170902f1cbb029010c5c6d088bmr16307416plc.52.1623040994149; Sun, 06
 Jun 2021 21:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-18-hch@lst.de>
In-Reply-To: <20210521055116.1053587-18-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 6 Jun 2021 21:43:03 -0700
Message-ID: <CAPcyv4gFEbZH4sXbkvQ32Xv1HiZ6JPL04efGpAWCqaJP_X9jaA@mail.gmail.com>
Subject: Re: [PATCH 17/26] nvdimm-pmem: convert to
 blk_alloc_disk/blk_cleanup_disk
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, nvdimm@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 device-mapper development <dm-devel@redhat.com>, linux-bcache@vger.kernel.org,
 Joshua Morris <josh.h.morris@us.ibm.com>, drbd-dev@lists.linbit.com,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matias Bjorling <mb@lightnvm.io>,
 Nitin Gupta <ngupta@vflare.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-xtensa@linux-xtensa.org, Alex Dubov <oakad@yahoo.com>,
 Heiko Carstens <hca@linux.ibm.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Philip Kelleher <pjk1939@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Chris Zankel <chris@zankel.net>, linux-raid <linux-raid@vger.kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-mmc@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>, Jim Paris <jim@jtan.com>,
 Minchan Kim <minchan@kernel.org>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[ add Sachin who reported this commit in -next ]

On Thu, May 20, 2021 at 10:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Convert the nvdimm-pmem driver to use the blk_alloc_disk and
> blk_cleanup_disk helpers to simplify gendisk and request_queue
> allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 968b8483c763..9fcd05084564 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,7 +338,7 @@ static void pmem_pagemap_cleanup(struct dev_pagemap *pgmap)
>         struct request_queue *q =
>                 container_of(pgmap->ref, struct request_queue, q_usage_counter);
>
> -       blk_cleanup_queue(q);
> +       blk_cleanup_disk(queue_to_disk(q));

This is broken. This comes after del_gendisk() which means the queue
device is no longer associated with its disk parent. Perhaps @pmem
could be stashed in pgmap->owner and then this can use pmem->disk? Not
see any other readily available ways to get back to the disk from here
after del_gendisk().
