Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:47:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA1421871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYIpj78U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA1421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LZMH5NtCzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 05:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iYIpj78U"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LZKN55LpzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 05:46:00 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id h8so7055832pgp.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VK+LR0HkVqg+g+PEO6ILwoTxff4AKvWaTBsfdr3of4I=;
 b=iYIpj78Uow+epfVI2I4/DzbxPYJo+kPm8shi/mF9THDc2mHwDQ7+QfdOkqwWuWszJN
 5n6ZW891Z5JP0F38trCOPPevhIl38tHasEC+R5Om/hD0xMO7WfPKzBnoouFxgHySeD8a
 b2go/a1LrpojG1Jtjs23b4Z7jDVWNz/UXDobDx8CaIeU1C7xpawuRrHHfNNeXQK3EdAT
 KBAQytW9RdyH23f9LFb2QtaIEywM8onAMO5JsDPt5hLmWBexeKeyIWXNSwGt+UOUfsU7
 kDaPfOoUUpi9Os0AgqukbTED8SLsBS+Q8G39Qgh7tqgjLcaY8dJPw73fpWlu1Zbm8RVY
 lL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VK+LR0HkVqg+g+PEO6ILwoTxff4AKvWaTBsfdr3of4I=;
 b=OvC61p+tRKdLYLLG7qV+1oR3WwPAFt6dIbYTme4dtfe6CdOmfnNXKtViVlbFEifAEb
 gXzgzkahrNBXrXb3DPKCFouOAeuXfJvzBX1ElIU++KSSptooJZZCTjiloJt46vgQnigo
 JvH5RLtSeNeOJT3pnlFm2ilJYAcqQ2exDZiRSoojY6vgYT7eQRc/dLLgrAvSGU0kdb/N
 Hpu3RVXB5PTBY8VHdOl6qvtzMMtUrpTTgNmVm6Rs2RRAzEnj+NC+3R26tb2kvsq5ASQA
 Gyu+wE4qQ7dqyLwM9mxvoBz9aVeT3rgug+aH/CReMiX74s6460X3O1AeInu5h+K86eto
 BZZQ==
X-Gm-Message-State: APjAAAUZqbpdrQVihaMbcAqKnIOOtCjo2Ynlg4BC7yvQ/yv+i5tQHQB6
 aOqaj9cbreLJBkfzs8uYZVFeUOQ66o/7P/fa4H0=
X-Google-Smtp-Source: APXvYqw3TaxggeBqtyecfcMSQvxbFW+vbW2qdzwAX7pBaJpkFDvdlCJlVOt04//Li6XBATgSfVeNl6ARjOea5LrZAvY=
X-Received: by 2002:a63:2907:: with SMTP id p7mr4803411pgp.161.1552675556399; 
 Fri, 15 Mar 2019 11:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
 <20190315181118.GF9224@smile.fi.intel.com>
 <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
In-Reply-To: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2019 20:45:45 +0200
Message-ID: <CAHp75VdCy0vtk0wYKrCKFKzdGQXaXQkgL_zWfCZGKas5JO9HtA@mail.gmail.com>
Subject: Re: serial driver cleanups v2
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
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
Cc: linux-arm-msm@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, macro@linux-mips.org,
 Peter Korsgaard <jacmet@sunsite.dk>, Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 David Brown <david.brown@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, slemieux.tyco@gmail.com,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 8:44 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 15.03.19 19:11, Andy Shevchenko wrote:


> OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
> it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

Compare  iomap vs. ioREmap.

-- 
With Best Regards,
Andy Shevchenko
