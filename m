Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41620C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 06:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A380F2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 06:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuILsXDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A380F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44frTV1LLSzDqQs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:19:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TuILsXDT"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44frRm2VS1zDqPB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 16:17:54 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id d11so4103706edp.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lf+C1XhWdcUgcmh0IBJFZDPyvKyMGzpdrIKaxYF8nYc=;
 b=TuILsXDTSPyLCU2yPniMsq4AP5sh7N/2kS7ePq1+AwqFk9e7ZhjHL/xxiBwAUBzgSB
 P/ieWaaf9TWp5IEgxFW9X2mTqhhyuXT0OAhoSz5O28dUO0Aq54n5ci5bHwbOYtkANBic
 dIr0stoWoPqrO8VcR0AITCUJxNrMXUqMGQOmnXNGOuBC/9a9qp+SJ1rPQqm/0Jt7o0hY
 ZLDYdmyFSbyKitf8yZTaWc3XPMndAZr4p7bDyzrO6UDSdm/EtbuByEPU6IleUhbi71XF
 xnENwXfJBgUC8E97ExkbnuK6y250b8oW3XgYQzcv4RDeYLd8Ipvg0zekbiMNZlPPTKjG
 l9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lf+C1XhWdcUgcmh0IBJFZDPyvKyMGzpdrIKaxYF8nYc=;
 b=mIbr1Zrjph1+gPiq62jF4UNjUO8ALjvTJHV6rllE1rFc8wMa4W8MzE3bwcoGV5mLiZ
 P2JtvPCTjQakfxtHTIOhn5xjOYzdSXYh/Rlstz9VvMQG3bg3yV9C8m3reLP66kiIY4Fg
 qYXSjdCbcPEgdjToAOGsL8vkFV1YbpOS57z+KwiI9hVkJDU5h0/6QZ8D1h/9FoWZe5fD
 kpRlcYDavzaLPyz8rq5ePU/RTXbPBnVFtd2wK7GTzmAcBOAMIg481i/5OZcD84OAKQ1r
 o0KSmAKfcq3pDovYY19pTeOWZIUZMcJGzDT9mYOdfbrGKW4FbjH6k+cMJF1dDL6M3RxQ
 18gg==
X-Gm-Message-State: APjAAAWRoqvJcMxcLyZyQU2vp8rn5aqSo/wwcuPLhAOcO1bYtUokBj0d
 eYMOP+vUt4JnguNsrmxIYs0Dj+B88Rn0kTLE/Kg=
X-Google-Smtp-Source: APXvYqyQ/djWT680jtjmvzQpmammX4mg71izhEtp2TW45xmS8gBV6pNpY1J1rRfjOsk6T1UngrW774QwaZQmIZrEvtU=
X-Received: by 2002:a05:6402:12d5:: with SMTP id
 k21mr15425730edx.75.1554963467959; 
 Wed, 10 Apr 2019 23:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
In-Reply-To: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 11 Apr 2019 09:17:36 +0300
Message-ID: <CAEnQRZB4CQ=zkSRyfFeFgBSZiJVjL4K_ecrdHYMmuvc_YePmfA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4] ASoC: fsl_esai: Fix missing break in
 switch statement
To: "S.j. Wang" <shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Thu, Apr 11, 2019 at 6:06 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
> independent of each other, so replace fall-through with break.
>
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
>
Since it is obvious that you will need to send v5 please remove the new line
between Fixes and Signed-off-by. This is a common practice and some tools
might depend on this to parse the Fixes tag.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: <stable@vger.kernel.org>
