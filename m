Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6513CC10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:58:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E5C20833
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otc2/zJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E5C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nWW2340FzDqS9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:58:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="otc2/zJt"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nWTM3r1mzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:57:27 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id ck15so5137767plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fGJoT5iB3bTc4LGaAwtIuRxmdPfiW9i6PCIuaqVn52U=;
 b=otc2/zJtPE0IMHOpA6/YsVhEgmLq1Lk+8YDlDwTaIx6wvy/pma9tCX6qYfBUJnvhFO
 QsRZ180OuByZxxtUFm5P0tZxuxrF/bl6aqkOTI4sjXB7fHcnu4Fk2id53oYfi0JH2J6P
 s0F1L4upKQmZ1gK7I0VqViPXpdDjVTpaNUPmK3LziFLjIkZ8jVhf/tcVND8DBTKgNoam
 E5RQ+Gwc+41/dqnCcJhsek8ctu0TAtp8b+kyvVaWwx2Q0ipgkevadNdLTexHB9w5XyHT
 Vg2OZ/MJ9uR2ZYd2FU7swkmMJ4G92yB1897g+c1H+AryRDEpx5oc9+W0fhXCSKobUa/l
 CrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fGJoT5iB3bTc4LGaAwtIuRxmdPfiW9i6PCIuaqVn52U=;
 b=bKmn+QsxGwiUtE8Qi3dBu/pW6Gb3VkVteoNlliCzgmDtOPCH90n0G3HZoVdKz23lPg
 F0KLqIvCzynBWzBFTIqDoVwla+R/1YFMQxyU1xZZkAvIa3DrklysW59KNFadiCOnkMzf
 7OFOCX3BpaInzsNmYhCqy1rCSL1V4KTbvPnQ9azb1/csqTqSsWytmp+jA6SUjg7jDYfc
 5h+qdiJ4mHnS88uPRDNMBfJNnzcv+0h3Ag+pTg/+sesJdfE7VEthaWAkD2wcaK50zch8
 W+yIPturIaS6dMj6Vte4BohXk5ypjF1KHIRVsQQ6kwk3XdMtv1DY4337VHWLojEz5Dgn
 9LEg==
X-Gm-Message-State: APjAAAV7/Laz7KxYFHgMDC9KFs9rL9n/gzfNfuw2iYDiGGHK3eAazCV1
 bILZFX5nLPFGRjn+YuZJyR8=
X-Google-Smtp-Source: APXvYqxy4ekFS/1HN5LPbs7i85iomf4KFHFlaxlE4v9IhjO13xxemVUJeOREIBDYANBXhvq/LkikrA==
X-Received: by 2002:a17:902:20c9:: with SMTP id
 v9mr17760317plg.239.1555901844050; 
 Sun, 21 Apr 2019 19:57:24 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 f2sm17202364pgc.30.2019.04.21.19.57.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 19:57:23 -0700 (PDT)
Date: Sun, 21 Apr 2019 19:57:19 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190422025715.GB9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> When we want to support more sample rate, for example 12kHz/24kHz
> we need update the process_option table, if we want to support more
> sample rate next time, the table need to be updated again. which
> is not flexible.
> 
> We got a function fsl_asrc_sel_proc to replace the table, which can
> give the pre-processing and post-processing options according to
> the sample rate.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

A couple of more small comments.

And please add this when you resend:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin

Since we have a ratio validation somewhere else, it's okay to
drop this line -- it may confuse people since the function no
longer checks these unsupported cases.

> +static int fsl_asrc_sel_proc(int inrate, int outrate,

I think "void" type should be just fine as we made sure there
is no unsupported cases running in this function.
