Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF0BC10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:24:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FC320859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDGbhJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC320859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nX4w0hxVzDqST
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 13:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSDGbhJy"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nX3J1CW9zDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 13:23:21 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 9so5025635pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Z+sDPrkVShQ3SV/eZUAJkyobdgecsoIqwEYrWD1W76s=;
 b=ZSDGbhJyxjWrjtlzjZrWNtPSJeDJho5p6X5BJZM350JlqZy4knfTvU9nhjIcRHOgEH
 jSad+pL4r37wVD7oj0XFgaQ3LttHOwtjJCnTHYswfRMBBO0SFeYsPoLz8aq+GuwPukYY
 BdZSrQyguCMqUG8lES6qRjkmHQkZLhTY/YMSsh4ZAv5ObkDQAA37osl0S+Ed8VM48Gx0
 gkrEO+zhW22L9/+phghX6ji3t5vmtdr+zmi2pHZ3Z7nNbmfAHUAyowvK9UtWNKGvJAqW
 XxkHoALIf//QtKINl7MWbIrwCoar7m+/5t0ohfmZsz47hDiLQIvh4usuo6L1PT8G+fZC
 PizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z+sDPrkVShQ3SV/eZUAJkyobdgecsoIqwEYrWD1W76s=;
 b=VJD98unoSuhdvNKo3WgHPOMXglbqC8kUA8LSA0vBir+MScY+hbQegYEMPYUJmnXK1w
 +hy8K432mVhSy9T3W87V+mUot54+aNB+QDEuML6zHlkBLAFShOHlNNdqygC1sli2lClR
 0VNxBc9YBVr2h7IL5gKUooQjgbpQnXxLPdWRoDCHXDAeIlQ3DXkeszcZWo9HbFgZ4vPG
 nvqoXho3CwlhQnqaw3kHIUS/yb40dXAR9vTGCS3wiQHpu04Csof45LKcmlE1cvGwLNZl
 IxRhB9jBKPrhIYy7H92Juf8MrO+NhxMY43L7VMcir5XOPdpa8pf4mtL85gRVsWnXgh7x
 jrNA==
X-Gm-Message-State: APjAAAUajs9aTRwWF7dsDKPva2DMHRUG+v2hcQ45aUDjQx+jK3YRgQ6j
 m8JP7FU0ziUogptoRU4IsJi4v7i1
X-Google-Smtp-Source: APXvYqzdHTD2SBWS8zz9XUjeR4TAVRuYUMZjFUqeTU2U7VAWVpYQgTuksvO6MXdv8ubqPB9K01MrwQ==
X-Received: by 2002:a63:5560:: with SMTP id f32mr16971001pgm.334.1555903398132; 
 Sun, 21 Apr 2019 20:23:18 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 b16sm15530733pfo.168.2019.04.21.20.23.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 20:23:17 -0700 (PDT)
Date: Sun, 21 Apr 2019 20:23:11 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190422032310.GA8300@Asurada>
References: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
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

On Mon, Apr 22, 2019 at 03:15:34AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > 
> > On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > > When we want to support more sample rate, for example 12kHz/24kHz
> > we
> > > need update the process_option table, if we want to support more
> > > sample rate next time, the table need to be updated again. which is
> > > not flexible.
> > >
> > > We got a function fsl_asrc_sel_proc to replace the table, which can
> > > give the pre-processing and post-processing options according to the
> > > sample rate.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > 
> > A couple of more small comments.
> > 
> > And please add this when you resend:
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
> > 
> > Since we have a ratio validation somewhere else, it's okay to drop this line -
> > - it may confuse people since the function no longer checks these
> > unsupported cases.
> 
> I add this for may be in the future we forget the limitation. Just for a reminder.

Okay. Let's use something more practical like:

+* Make sure to exclude following unsupported cases before calling the function:
+* 1) outrate > 8.125 * inrate
+* 2) outrate > 16.125 * inrate
