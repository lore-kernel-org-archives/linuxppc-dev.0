Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E7C4707A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:18:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80F6109F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80F6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fmtc96F59z3bsr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 May 2021 03:18:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.216.48; helo=mail-pj1-f48.google.com;
 envelope-from=mcgrof@gmail.com; receiver=<UNKNOWN>)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fmtbm0cKkz2ykH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 May 2021 03:18:11 +1000 (AEST)
Received: by mail-pj1-f48.google.com with SMTP id
 lx17-20020a17090b4b11b029015f3b32b8dbso5918776pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 10:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PKUzbY5iIGLiRwydllRSQJCscB+6IrSLbJrzulbqCPE=;
 b=rxAYHRJapadnnnBRhEaTk3q9X+brNgPjt0+jiS4mxIl3z7pNe89Mf0TEWOcZjaUI4j
 ETzydg1SoILVfw2krnhliELX4+bm4Rvewp1MAn9jEmddkizkG1vyWimccN5nuEwb3LV5
 Hy2HTbCMxZUXsuj27gI8n0e++blMOAd4JmvLv9IxI4eD2rDrwFhY4c3TEsqDJUw7wydu
 CsbLzSz3Zd8Sd9epMXdYR2W0OusYtg0xHoHGvhk7ONoQv22eDzKsQDik5t0IQ7FX3HhE
 WgPabizGuQO8pveBH91XCXvYF+zUaZ/y85HiRUYEGQ+/K7mLJp097YYTSjts6dDZt9Nq
 lKKg==
X-Gm-Message-State: AOAM532bj8QQkPLI3oDONIqzw1U7ZYppfHDm57fsUlq1kP3/9KmPy84T
 YIGneaun9Npg1yJbmvhUN+o=
X-Google-Smtp-Source: ABdhPJwK8NtIAa5B5/oxZS0IR7nB67qYtN97nOKjvFJRfkRjUCvWO1h3QwEBBuBpXaKTLAx6Ca3tYw==
X-Received: by 2002:a17:903:30c4:b029:f0:ad43:4ca with SMTP id
 s4-20020a17090330c4b02900f0ad4304camr12902892plc.70.1621617489433; 
 Fri, 21 May 2021 10:18:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id f5sm9178273pjp.37.2021.05.21.10.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:18:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 29A6B423A3; Fri, 21 May 2021 17:18:07 +0000 (UTC)
Date: Fri, 21 May 2021 17:18:07 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [PATCH 02/26] block: move the DISK_MAX_PARTS sanity
 check into __device_add_disk
Message-ID: <20210521171807.GA25090@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-3-hch@lst.de>
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
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
 Mike Snitzer <snitzer@redhat.com>, linux-m68k@vger.kernel.org,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Joshua Morris <josh.h.morris@us.ibm.com>,
 linux-s390@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matias Bjorling <mb@lightnvm.io>,
 Nitin Gupta <ngupta@vflare.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-xtensa@linux-xtensa.org, Alex Dubov <oakad@yahoo.com>,
 Heiko Carstens <hca@linux.ibm.com>, Coly Li <colyli@suse.de>,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, drbd-dev@tron.linbit.com,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
 Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 21, 2021 at 07:50:52AM +0200, Christoph Hellwig wrote:
> Keep this together with the first place that actually looks at
> ->minors and prepare for not passing a minors argument to
> alloc_disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
