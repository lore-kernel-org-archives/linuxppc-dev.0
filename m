Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F498C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 01:56:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB438213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 01:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Lb7Sgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB438213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Jbl1BPbzDr5T
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 12:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6Lb7Sgg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::133; helo=mail-it1-x133.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6Lb7Sgg"; 
 dkim-atps=neutral
Received: from mail-it1-x133.google.com (mail-it1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439JXn52rwzDr2q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 12:53:26 +1100 (AEDT)
Received: by mail-it1-x133.google.com with SMTP id x19so24751183itl.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F2JrG5JSg9cUoRofFVNO5VtJ+WPxWIYqzJic4FWzVpI=;
 b=E6Lb7Sggjb6bkkd9GtBJWBH0OT1W0gnYS80+oj62r9Qr8xo3p03uudSYC5kqH7dF31
 lwJc7ZHVvDdnjw81jJVhRKvskbRI+eP/ujwVII2jxTAKPUyt00VjXDgohogK8vfDnXC9
 QJJA7f5gVDX692N74ynsEW5yjHxS/64SwlJyb12sNSToEgyUS40TM4FovFcl6+HMImsL
 3h4UuKGg3dSbipEritLqkxDS4+55iX4NkOa1ZcaZLWt4aB4McJNxVzWs5S69jh5vSEVU
 PU75i55tHrFAB6AWv5jy5othBJTK5+asKY/6qkvrF3EfKQJQS5RVCzeMpcB4OlNj55A5
 nmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F2JrG5JSg9cUoRofFVNO5VtJ+WPxWIYqzJic4FWzVpI=;
 b=PIVVnexXu4NJrGpkpa+WlgPPWtaD8PeWyF15/soWUcYTrl+bAwi7YuDhOX3ApSO7cp
 59vio/mSQbBm9s4102mzmDeom2TYBVU6UVWWcaOXT3i0xvQmKv2AcTXw0e+peOuy8I4U
 JvoAWoEltkbCMRYaqJ+Nb4NZtdL2dTJzWXbrtNXwToDGPm8jmHlBGYL9yF/b9CoI0Wa3
 HCrgsYEEn4QWHlt1PipJNMrRsQnKP2l+SPliV7Rk2S51vmnvEzoIFuJXiVqDTyBIdYXX
 efb0cjxkelCkmE92aR3mf7R4dvsEMevYTibST3oPf06BMI2c8g9Em4vnS4iXIHwX6gxu
 q6aQ==
X-Gm-Message-State: AA+aEWYIeSvu0ukGm82NxRkvUcGYYLApNPD6PHdF95lkCzEgvJeCA+qn
 GHNl28EvdIQmHSZVsCY75EE3Fb+W8Q4Wc9OVPac=
X-Google-Smtp-Source: AFSGD/VrHpbISDKiX/hZ6dpqSdCqT5bNthf9W540WIPjQh1RPFHhRXMNtjg4jwQiWdfpuGgDIsA35nqfOwj3WO1ENiU=
X-Received: by 2002:a24:d081:: with SMTP id
 m123mr17787140itg.119.1544061204148; 
 Wed, 05 Dec 2018 17:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-33-robh@kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 6 Dec 2018 09:53:12 +0800
Message-ID: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
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
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> and "sai", so there's not any reason to use strstr and of_node_name_eq

I am not quite sure about the replacement of strstr.
IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

I am currently out of town so cannot verify the patch.

Fabio, would it be possible for you to run a boot test?

Thanks
Nicolin
