Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F1C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:31:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B9A208C0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH6qtt0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B9A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mPfc2tqJzDqVM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 17:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH6qtt0V"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mPcr3FmkzDqRP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 17:30:01 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id e92so1749191plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g0walm6P/6efwRjWHafui6XopYt2biYmefDXoU2XjRE=;
 b=KH6qtt0VpizwpZFptxDfqcSzA2segQb7TS6O9woGE5I+aei8vBn3sLh52rlSoazVuy
 OHUNEqDVtT76eMq/M18lNCI01w/JfipEksmpPUtvh7eFreeRBLhYTgHtWNR1FVEvyQNk
 V3/BHdfPfPHyZaaXWWOlvC9hlem31FOgsgYtmE3xMtuMmBR+vTC3302lknaLV5RuAgqo
 NdNE2V2Cpv/vX7g9hrbKSxgkh3aIZrEjkWGiOl1EN4SAU3xtZOeiKndtVknLUmikXXVe
 lJgEKFH2r9ZbOX/5Nmb7DZifcRH7qYxhEfTqbwABnQBBQKpfzhKpOWuol9ey6zeb0z9h
 pJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g0walm6P/6efwRjWHafui6XopYt2biYmefDXoU2XjRE=;
 b=fFyon+3pz6N07ZP2Cwk9VGkLGJE4I+PnNUtV51tInlr8vz1ckpKB4TX6AmzkAx8iCW
 0aoWlBJQilZq7qHAcTJCaWmUPf5k4MmaOkWonJLqxTETa3OvNEXzwyunBIeZB9DPVqxh
 fZrL9a7IomTY6W+YkVbO1ZX+tGnfIEnAbrxfoTzrtCTUf9wbz6ITMOuAytATTQOY4Z/W
 0bX+nx7U81QwCIkemLxpTm8tRmi62W3es96z3Nb4RSsZ/v5Dc7zhTj5OotnXso9l9QCt
 dGxwH74towCqZCGgaovIaJheQ43Slfic4CzuHjAc8iecA7R5+6tX3XWBc5yUfUZBX4X9
 h1jg==
X-Gm-Message-State: APjAAAWnptpCe9LloatygphEQn6a82/UMGz39gW2vPbWW8gXbFxG0m+2
 v+UeYZgdh/QAyu3gTPlxbKY=
X-Google-Smtp-Source: APXvYqx8WtwDlr62vGrC2txHOyb68rGmoHA3DCGoeTVnpAOYYSMuow453OJDTXCPlk0T+FwfRxuEXw==
X-Received: by 2002:a17:902:848d:: with SMTP id
 c13mr7850119plo.279.1555745398461; 
 Sat, 20 Apr 2019 00:29:58 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 t13sm16299156pgo.14.2019.04.20.00.29.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Apr 2019 00:29:57 -0700 (PDT)
Date: Sat, 20 Apr 2019 00:29:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190420072952.GA10408@Asurada>
References: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
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

On Sat, Apr 20, 2019 at 07:23:59AM +0000, S.j. Wang wrote:
> > >       /* Validate input and output sample rates */
> > > -     for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> > > -             if (inrate == supported_input_rate[in])
> > > +     for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> > > +             if (inrate == supported_asrc_rate[in])
> > >                       break;
> > 
> > Not sure if we still need it upon having hw_constraint. Maybe m2m needs it?

> Yes.

OK. Then we can leave it there. Thanks
