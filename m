Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48186C47076
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:23:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4FF61168
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4FF61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmtjR1jTlz3bxk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 May 2021 03:23:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.178;
 helo=mail-pf1-f178.google.com; envelope-from=mcgrof@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fmthz2j9yz300K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 May 2021 03:22:42 +1000 (AEST)
Received: by mail-pf1-f178.google.com with SMTP id d16so15382691pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 10:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4xwt7H3ydSynAZjOEHISSkaEhx58URrfefqnsYajrYo=;
 b=YCEdobRV2RNse4WPp0V0mD6cd5Y6B4uwxnVrJQXNobP2P3ao3fmQWlyZIfCOUi8Hsy
 2Fal6ZjZIuFdbSCJKGXrloemauy/CBWZhFas9B+ejdAMAw3kj4y2os+HidiU7daSf5Zm
 h9pT5ZAeTn5KO69G2EDPOeUtNAzzPOwxsHfgpL6xNGEU3ZfCWUAsSC/HphRRd363U0ZQ
 xVS11fg9aJmuio56sXI9FbYr7umRREKRuQeDbj1O7mwgtcVsGEpIbZTKkzCaPHig7g82
 2+um+xTrx6gF1n+kK3yGNxM7hywxOBMgv9dFso7QCK7gW4O7zrX1Og+85pj0aoj8S+27
 2j0w==
X-Gm-Message-State: AOAM5315N4xLE/l3evoNW2fvo9N3vfvwpC+wbil2tjnw2XxbOOQRXCkY
 xZ91ahDf7NWs3JtIe/uYvmo=
X-Google-Smtp-Source: ABdhPJwN/SKOVHqzTq8eMNvLlpfI5p0TUMMcGqBBBfFtPi25TxwCtdfeNJoGCkAE3FkaxK6OlRwjhQ==
X-Received: by 2002:a63:bc19:: with SMTP id q25mr11009138pge.211.1621617760179; 
 Fri, 21 May 2021 10:22:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id o10sm4951196pgv.28.2021.05.21.10.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:22:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id F13FE423A3; Fri, 21 May 2021 17:22:37 +0000 (UTC)
Date: Fri, 21 May 2021 17:22:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [PATCH 03/26] block: automatically enable
 GENHD_FL_EXT_DEVT
Message-ID: <20210521172237.GA25156@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-4-hch@lst.de>
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

On Fri, May 21, 2021 at 07:50:53AM +0200, Christoph Hellwig wrote:
> Automatically set the GENHD_FL_EXT_DEVT flag for all disks allocated
> without an explicit number of minors.  This is what all new block
> drivers should do, so make sure it is the default without boilerplate
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
