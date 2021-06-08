Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C6C47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 16:31:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3156128E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 16:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3156128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzwjT5qQyz3bvQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:31:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.170;
 helo=mail-pf1-f170.google.com; envelope-from=bart.vanassche@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fzwj407d2z2xZK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 02:31:03 +1000 (AEST)
Received: by mail-pf1-f170.google.com with SMTP id s14so15210058pfd.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 09:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c/oBlFBZpymRmok4+Br5HKJTKzk4izKuifiUtNGmmMU=;
 b=eqD8DvCruv9Ri2D/NjIoJ9P/8PveI8BDxS2I1g8+8QHjJzsgSHkeFGA+A60dUw/5DX
 TG3e6ZcZpIxOtEEkbC+Nj/PAgH9ARl94i7LHDq5vmbrdYdXziyiHwh9wRcKw6T2Bmusi
 OZ/fOEHiYH9putlIhxjkru6wgJ2UYT6r9Ju3zvBkABbbodovRT8t2dSUHz04ZbSZdoMU
 W99FAQ/wEuMLXDJS3OotrxN/79gdc7p1vpvDcEbKBQAWmSsAGKkPLvUt1NYcxPCdBLdE
 3lHA4YqCTfElAeRcp5IdGPF91gBTBAyL3lRfBvhB96qLhE33HpZuzapjml7WwU3eHrXY
 c1jg==
X-Gm-Message-State: AOAM532ilUvCPA1FSOUTfNsm/7w/LeMfVifvBtZWf3STQO6LWgVCvpT6
 841AhpXg4qfh7yBYvqkfXtM=
X-Google-Smtp-Source: ABdhPJxAnY1ILuuUidoa80Is797vj32J19rnEPL6OqbB3/VUdrwY9tRxfOHxegyAC+CunZFhbY6BTQ==
X-Received: by 2002:a65:6243:: with SMTP id q3mr23851189pgv.297.1623169859346; 
 Tue, 08 Jun 2021 09:30:59 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id c5sm9194629pfn.144.2021.06.08.09.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 09:30:58 -0700 (PDT)
Subject: Re: [PATCH 08/16] dm-writecache: use bvec_kmap_local instead of
 bvec_kmap_irq
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-9-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <4c248453-713f-9da8-04e8-7939388be49a@acm.org>
Date: Tue, 8 Jun 2021 09:30:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608160603.1535935-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
 ceph-devel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 6/8/21 9:05 AM, Christoph Hellwig wrote:
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index aecc246ade26..93ca454eaca9 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -1205,14 +1205,13 @@ static void memcpy_flushcache_optimized(void *dest, void *source, size_t size)
>  static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data)
>  {
>  	void *buf;
> -	unsigned long flags;
>  	unsigned size;
>  	int rw = bio_data_dir(bio);
>  	unsigned remaining_size = wc->block_size;
>  
>  	do {
>  		struct bio_vec bv = bio_iter_iovec(bio, bio->bi_iter);
> -		buf = bvec_kmap_irq(&bv, &flags);
> +		buf = bvec_kmap_local(&bv);
>  		size = bv.bv_len;
>  		if (unlikely(size > remaining_size))
>  			size = remaining_size;
> @@ -1230,7 +1229,7 @@ static void bio_copy_block(struct dm_writecache *wc, struct bio *bio, void *data
>  			memcpy_flushcache_optimized(data, buf, size);
>  		}
>  
> -		bvec_kunmap_irq(buf, &flags);
> +		kunmap_local(buf);
>  
>  		data = (char *)data + size;
>  		remaining_size -= size;

From one of the functions called by kunmap_local():

unsigned long addr = (unsigned long) vaddr & PAGE_MASK;

This won't work well if bvec->bv_offset >= PAGE_SIZE I assume?

Thanks,

Bart.
