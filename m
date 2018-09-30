Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C838C004D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 07:07:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954C32075E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 07:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvWgTMn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954C32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NGh21PWpzF3B0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 17:07:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvWgTMn9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvWgTMn9"; 
 dkim-atps=neutral
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NGdT1xt1zF3B0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 17:05:16 +1000 (AEST)
Received: by mail-ed1-x534.google.com with SMTP id h4-v6so11438648edi.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dv0ynZ5EPLtr4fQ61GaEfLVfsz41YYaqUU3FKo55toc=;
 b=WvWgTMn9Os/4D1LzZQajdQ+a/DEBgxz4Vi/jqcc3WjDuyOvQqENZqg/sIgpmT7pui4
 6jRMXMIwtaIRu9aM+3N903FhOlcOCpnqF9rg7S3v7j2ukVpYyhYFWKG1y5RtXukGRKaD
 f19FnUcDCTAVVYl4Ij/XB9/ejDPKgqqNhlpgywi+yUcHwUFhH1nN7UjVlYniZSKdzmNm
 axx9XgEjyi67NARxZcm8VuuTA3+vWkZFTsMvMy95ilhQPlbj0Wm5BxUFD46PJvBWUo/Y
 41om5+qW8bXPqFUtDhGr6YjLytJ3Ne9k3MFX4Zey+kDMgMWDaNSYl0Rv7oa4evz+j8Yu
 xy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dv0ynZ5EPLtr4fQ61GaEfLVfsz41YYaqUU3FKo55toc=;
 b=QcLTgm4m2OBkWGiuYhvuuvvBCqF+UZtAwW3wSX14uyjEra/wzG/oSdW00IYjkzYm0l
 NlKsV1qF48yqGNPKsZh3c+PKJ+F5gL884XSN0ndfkbr0s7CztB6vNUOclWDIH2ShpXka
 PUFloAhVKSt0cWV/MNrm2Tr1DiTgZLZmIlQUDC0ePyzbdbXFH7U1aNbhq0tKDZR42fRB
 ntHZ5bQwpU9okAyNwnG/g8tOvusUw+/HpovCGH+akySS4rDlwyKDSr8elGYPo6Al8Sdq
 il4EytCRuq7N1/1BLkM4WkKXuCBKVFnPkhIC8O/pBQiI8Apd3/R0TiuMjX04LreEzgmQ
 dxuw==
X-Gm-Message-State: ABuFfogo0k9679E+mhCu8muC2RFwjGkuKt8w7pum0Lhc8QjPS63IbDAe
 yslgfpTv0jRyPFmQnUs/5Q+MJR2KZ67lO4WSr76N7Szc
X-Google-Smtp-Source: ACcGV63fGVxd1I0WnJajg2BfKl6FvC1vl5dFArlixViMPx8HLEqYq9t9LSnHEatT3+vaEnb1d8SRSgt1FYPPTiMLlIs=
X-Received: by 2002:a50:ae03:: with SMTP id
 c3-v6mr11520393edd.114.1538291113457; 
 Sun, 30 Sep 2018 00:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <20180929221321.GX23155@gate.crashing.org>
In-Reply-To: <20180929221321.GX23155@gate.crashing.org>
From: Raz <raziebe@gmail.com>
Date: Sun, 30 Sep 2018 10:05:01 +0300
Message-ID: <CAPB=Z-ojoLwhNWhE6agindvF_41gQYdjZkvquGBF86FYju37vA@mail.gmail.com>
Subject: Re: Looking for architecture papers
To: segher@kernel.crashing.org
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

First, thank you.
And another question, is there a development environment that
resembles Fixed Virtual Platform for ARM ( FVP ARM) ?





On Sun, Sep 30, 2018 at 1:13 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi Raz,
>
> On Sun, Sep 30, 2018 at 12:24:35AM +0300, Raz wrote:
> > I want to learn about powerpc architecture, mainly hypervisor and
> > partioning.  I download the books (1,2, and 3 ) but I feel it lacks
> > a lot of information. Are there other books ?
>
> I suspect you are looking at an ancient version of the architecture.
> The current version is 3.0B, available here:
> https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0
>
> Good luck and have fun,
>
>
> Segher
