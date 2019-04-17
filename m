Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2E1C282DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:15:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E792073F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Ekj3g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E792073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ksQh3MRDzDqQ8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 05:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M5Ekj3g6"; 
 dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ksNn5cLTzDqNW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 05:14:15 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id z9so12432976pgu.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1c/bh1hlYVfEn4mKBRVU1xOPhJniefdwWFTlRx2729o=;
 b=M5Ekj3g6xU5onSICGt0zQ0oa9dv7xRpU3VjENPfcTbDOxbStSxVLhEiK553/NAow6G
 ID395JJvodH6Wpq4bIhyzsy7xBxbJkn0Lniqp/WY2XRwVGHKs4aVPCcHT57Y7qutCydy
 g0kzKaJDxgDsbpVAf4RPGYgtdmE1CbasYOK1yaLOi3KaISLXzEmqKkdXmI8uZIam78LP
 B2VczDgV/kkHFsrhGyChHO1aShQ0VxVUZvQjlkCuwfcnBB6veeNbL/5ZJn6+ryPAy7+4
 gKBsIZC3C6+u3+NaRFiEKVc1Voj8O31UWKoBpZEjKpoLFRMXZglr+4F0YMm6hrFcpxai
 tIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1c/bh1hlYVfEn4mKBRVU1xOPhJniefdwWFTlRx2729o=;
 b=byo3JawNHwNzgvNtXO4RfSTTiEVcNWLPFhFKVh871rWzjirtHYxC+kyowtKpMD0vjc
 vzlhvOa3HsU7qLkZgblowbv7mTPIpL/z2aFXAPHOKMHhhHZKzxTOHL1tzTEz5XGdj3SR
 2CYzY9S4Po61vMkAu0LY73op4Q7thwq0Z52OAbglPUdxOQSJrKQ7pbSHT2/jC71o+taA
 5MDw+FnRsLpUXrzausVnaw4JlV5oU4xTSon4+ROHnYI037+QnC8p50HBoIWePDpBd5be
 6BaYQ0rggaYDBnI7rCidZdr4cL6Yv/UIcYNuHzwXUf0llJGvRWcGldNt+4u2PBqDnXzp
 wxUA==
X-Gm-Message-State: APjAAAUlB97Maeqs1KMWCe8RfPnbpLB5J6C7Cb43DxvPUO0ocx4D1KsF
 29xH0XMLeJn72ybBzaiO0U0=
X-Google-Smtp-Source: APXvYqyI5RNsi8PMQe96X08s3l275RB7mFk8KZHzrARaarX1ahlM8C5V0A+7ajALDJ1dY5k1wyxR/Q==
X-Received: by 2002:a62:565c:: with SMTP id k89mr90211140pfb.175.1555528452883; 
 Wed, 17 Apr 2019 12:14:12 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z7sm53843108pgh.81.2019.04.17.12.14.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 12:14:12 -0700 (PDT)
Date: Wed, 17 Apr 2019 12:14:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: gabrielcsmo@gmail.com
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable
 'osr'
Message-ID: <20190417191406.GA14405@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
 <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
 <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
 <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Yue Haibing <yuehaibing@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 17, 2019 at 09:58:37PM +0300, gabrielcsmo@gmail.com wrote:

> Nicolin, I am pretty sure I've ran the get_maintainer.pl script but
> I will pay more attention next time... sorry if I forgot to add you.

It's okay for that one as I trust Mark's review anyway. Just
adding us would offload some of his burden, especially for a
device specific change.

Thanks
