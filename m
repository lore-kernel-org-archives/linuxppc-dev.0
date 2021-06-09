Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD8C48BE0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 09:38:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C5E61285
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 09:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5E61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G0MVH63mjz3byD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 19:38:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=AUn30ilb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::136;
 helo=mail-il1-x136.google.com; envelope-from=idryomov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=AUn30ilb; dkim-atps=neutral
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G0MTp6sM7z2yWp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 19:37:50 +1000 (AEST)
Received: by mail-il1-x136.google.com with SMTP id x18so24594174ila.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jun 2021 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=11paM/1lp22CavDEEN3A/olA+tOS+m0UgIjuNNPMc5c=;
 b=AUn30ilbL3NzF5q2BCp0QVXHikpm8Vm6yUAM9SdAhos2m9u8xXGwxlhY7L/mh5ETkk
 xMDLHdDCnvMj9u5VwkHn37GW+ujRpw2uJn/g/RTKxpbLL7paohPJB9BFTIoD6vBOz0FJ
 wlEZkhAcmqWn9YlRTm67JdkNWHAiNqs9sQF7kLfjGLtZZjwbbdwYYhZL9eEqO6j8XGwT
 WGtn6z7Ok1u7/f7AJWVfLsFL4AOnd9bBJ2NKdphWe6mO0Sya+xn+4ljLwykvBX8unsLj
 qDtDo0A3iPuoyVDOa2dKVu/uzCQIFKij1E9QJ4Rpt6+OuJFeAbsxKLDuKg+JVf9eTdvV
 qvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=11paM/1lp22CavDEEN3A/olA+tOS+m0UgIjuNNPMc5c=;
 b=YZQ0qnjao7ZgEqCr2K1kyMe/URb67f6nbc5KPjbyA9hD+giTwaq0DQzmrXm9p/1jeN
 z/4U6UR719KzO/OjTbSPUYH74mEjRPhpAKfYmTqiTBlyV0i7M9HmJ3zdHho7NJRodkiV
 mLlHCqHTawvazZY7/GfeBLEiy3TbtLNTWOidw2xOE5bx3+mZtD43K3/9dFk0UWWeYyYl
 amuOkaIKSjOHI1PL6IQkMz44vQ0a8IotYGHi55kadti4fEVeqenBwcR2iUqPcvuM/FQ/
 UvFA+8JQ++f9npt1Bep+wVvAp4t22GY8FZISMwg5W6WYu6OdaM1Jd1Q0PIdUY1rBT9Rq
 GJNw==
X-Gm-Message-State: AOAM531dtzWkYRQYVP4PHIkMxYchN7i8iDk1/9UTmS3wcBlLROhReA0R
 TkHOW6oUwoQh//eMtsu3eeZlwSvx4dUCWSwLV4g=
X-Google-Smtp-Source: ABdhPJy5AROZdbsU+O1Vh/bwrnsq7wRpZEor176YD0iLaHDJhsh5Ad6i076nqZiL2In6oQ6aCiJFsx/mBME7wo4cSUc=
X-Received: by 2002:a05:6638:267:: with SMTP id
 x7mr7028650jaq.51.1623231466755; 
 Wed, 09 Jun 2021 02:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-8-hch@lst.de>
In-Reply-To: <20210608160603.1535935-8-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 9 Jun 2021 11:37:45 +0200
Message-ID: <CAOi1vP-zSAnx5z7EbPNVLoCHWdK5iGjXU7KKrRL8YZF1QfMf3A@mail.gmail.com>
Subject: Re: [PATCH 07/16] rbd: use memzero_bvec
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 LKML <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
 dm-devel@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 8, 2021 at 6:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use memzero_bvec instead of reimplementing it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bbb88eb009e0..eb243fc4d108 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1219,24 +1219,13 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
>         rbd_dev->mapping.size = 0;
>  }
>
> -static void zero_bvec(struct bio_vec *bv)
> -{
> -       void *buf;
> -       unsigned long flags;
> -
> -       buf = bvec_kmap_irq(bv, &flags);
> -       memset(buf, 0, bv->bv_len);
> -       flush_dcache_page(bv->bv_page);
> -       bvec_kunmap_irq(buf, &flags);
> -}
> -
>  static void zero_bios(struct ceph_bio_iter *bio_pos, u32 off, u32 bytes)
>  {
>         struct ceph_bio_iter it = *bio_pos;
>
>         ceph_bio_iter_advance(&it, off);
>         ceph_bio_iter_advance_step(&it, bytes, ({
> -               zero_bvec(&bv);
> +               memzero_bvec(&bv);
>         }));
>  }
>
> @@ -1246,7 +1235,7 @@ static void zero_bvecs(struct ceph_bvec_iter *bvec_pos, u32 off, u32 bytes)
>
>         ceph_bvec_iter_advance(&it, off);
>         ceph_bvec_iter_advance_step(&it, bytes, ({
> -               zero_bvec(&bv);
> +               memzero_bvec(&bv);
>         }));
>  }
>

Ira already brought up the fact that this conversion drops
flush_dcache_page() calls throughout.  Other than that:

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
