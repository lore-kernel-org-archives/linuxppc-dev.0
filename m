Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555ABC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B6220859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcWXxeIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6220859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44n39N3lkyzDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 18:42:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QcWXxeIr"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44n37k03CRzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:40:31 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id d55so7457378ede.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SzBYaJfwULQvLwqE45ZHXpeYUUmpfc5uMjyHxzdr8rY=;
 b=QcWXxeIrAccG6k1GikRcfSwPRn6LuLvUXwxsTYZ+mNxZsr3BHFJY98tpgqudAnuSm4
 VyBgjeFAzSHliF+bYyill+/OWyxIyUo/I6dam16D54rcx+VO01WDA9Ze/bcxQ42+gQBF
 CxDTf8ut0aZ1F5koDWjG73M5oFzyQRx/B8E16L7wMSgEIWqYqoUdxbf7Y63/4l/WHdwV
 /Ats+HFWBTwRMTLr4UMGYrxSN3Q2fscvEKRLAKCR5slck3VUvOVnXSjpCvQfQOhUKjty
 p+HYOJi9pi4ODjVhN66XZMlGSK997UDq6WYr4BvEcYofwrhqZmbSVDYQ6HCP6Rep0Hqq
 RlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SzBYaJfwULQvLwqE45ZHXpeYUUmpfc5uMjyHxzdr8rY=;
 b=V+v9fJODP8D847E5/qEv/mW1AOYcy8g/q97ATAB2+1Vc52zj9W2OnFHpd9v3yjZkWA
 c6UIn515fp3l7ognXOcGP7cVgiQfJHAF4Xp5I64idrEmoPpKwXWOyrxXcvKNzTCIQwFz
 rivf+DW2Kt0mHihlG7FQV2A34RmJTPV5m2DklbOYTsfmYsOilV9vo7fR3BZVW+zFVnjm
 4je442AxccaSe7lk4oNG6HekZkidZmogOeLv/WcM8ytJ/82Cp9g/yNkTYDg55q9GAHMW
 xi13k4/a9D5dhu3dmIbnLfG0t4QxkG0ITt24HyymOH0TvthFGf1EdzQN2GrZkdXh+UV+
 TBEw==
X-Gm-Message-State: APjAAAUeQetPnyvDTtrhRv7kW1/jpWkX3k4DtvYY/E5d0tTnsLJrxuYQ
 fIZqmZz4IG4MUUblhVvXjlBAjN0z3eb1YAh34KI=
X-Google-Smtp-Source: APXvYqx0fHCKxVzrmJejMiEtQKGxGXyaJZ3mIvwqaU7Dpjf/gUy0BClKM5BKOmHF43ZucWdn7HCzxUGmZj/fWmfR7cA=
X-Received: by 2002:a17:906:f03:: with SMTP id
 z3mr6572306eji.280.1555836025018; 
 Sun, 21 Apr 2019 01:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada> <20190421082627.GB8304@Asurada>
In-Reply-To: <20190421082627.GB8304@Asurada>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 21 Apr 2019 11:40:12 +0300
Message-ID: <CAEnQRZAH7qxHVk19UrUrAg3KdDbKz5tg0jwizB9TTLpciRpwfg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
To: Nicolin Chen <nicoleotsuka@gmail.com>
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
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 11:26 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> > On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > > Firstly, according to your commit message, neither imx8qm nor
> > > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > > starts with "mclk1". So, before you change the driver, I don't
> > > > think it's even a right thing to define an "mclk0" in the DT.
> > >
> > > From what I understand mclk0 means option 00b of MSEL bits which is:
> > > * busclk for i.MX8
> > > * mclk1 for i.MX6/7.
> >
> > MSEL bit is used for an internal clock MUX to select four clock
> > inputs. However,  these four clock inputs aren't exactly 1:1 of
> > SAI's inputs. As fas as I can tell, SAI only has one bus clock
> > and three MCLK[1-3]; the internal clock MUX maps the bus clock
> > or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> > inputs[1-3]. So it doesn't sound right to me that you define an
> > "MCLK0" in the DT, as it's supposed to describe input clocks of
> > SAI block, other than its internal clock MUX's.
>
> Daniel, I think I's saying this too confident, though I do feel
> so :) But if you can prove me wrong and justify that there is an
> "MCLK0" as an external input of the SAI block, I will agree with
> this change.

Thanks a lot Nicolin for your input on this! Really appreciate it.
Let me have some time to further investigate it and really figure
out what happens at the hardware level.

thanks,
Daniel.
