Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FD1C46475
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:40:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E8B20856
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkO369SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E8B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hzSg5j1GzF13T
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 22:40:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkO369SI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkO369SI"; 
 dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hXNZ3bg7zF3Gv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 05:20:27 +1100 (AEDT)
Received: by mail-lj1-x242.google.com with SMTP id p1-v6so2002148ljg.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T56q1WFOtYNSeaP64ZTRRqTdS6w1Bc+ijJta1+x82Qk=;
 b=XkO369SIZ60TFFWgesTcdetuDj2QB7WRtVPtpTB4xytqLmNAIBrZn2x1EnQjWSEfee
 l+Sdg9H0MI7wqmFl4ECVG7UIIr3SYv2PdgFqUiGzLDXgAk5UmyaWhy5zgCt8A7WNJSuS
 tjEP0fj7LXmQP5dAbmsM+Vzq78z9qermJUJCcs2tVId9tO8YYcA1eJDdUt+ty9c1d0Rc
 ECu14JrsKDN6Zdyc7iUk2eGl5CxSd520bbbR2zkt4CNqLsFY0mTXOObgSr/RtYDFCu9X
 6N7/AMgdKOfhCflYzznIfvTl1iAPgrSvHquqK538W8qhu11etZBUc2ecgXGJCsrYYA31
 whKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T56q1WFOtYNSeaP64ZTRRqTdS6w1Bc+ijJta1+x82Qk=;
 b=QBe8XMbqdDabRHVGgizXzlwEK6Pms4V5j/JjfjD0Iq1ObQh82uMG1MSpmhLPPo+CYH
 0+Ad9/8R3KUUyKsJnUIi0grmVm+HurYDbHk5kYlRUJCwlNTOZ6hmKgiYSD4p0fMUDQfK
 pEUBbp4T3BQYwgnJn0XO+iGfFZd77cKojJX7TsVCJgAdYFm16jGrGmMRKBSUqI5VRxxY
 k1fe+R+iodHeTQyX3hrgawPbtQ43zHCe+TsVP+Mz5rCW2QeG8nNawxXCI/kSCPXKYgQh
 jKpnqvHqZmRjrgTuL6y1pGHeAGBGtaq4Rf/aKBc0xWFNLsJK9qP/3XhOCb4kpOU/BcYJ
 AnSQ==
X-Gm-Message-State: AGRZ1gJmDyrTVoNXSQoEuGVn+0nQmuSoLYRs1XRaBvSC+g+QFBUPs0QS
 phLjAmq80WG3UXxac/E03bh/bMhOqhGlpURSsEE=
X-Google-Smtp-Source: AJdET5djV3qCBBz+Am4ofKk8nvp7aX8mrHg4ZeqwTTv4xhxojmBX0n6Mvm3k4FkDlOHXlVQsJmJenqUuHARFYuadFc4=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr3117652ljd.94.1540578023113; 
 Fri, 26 Oct 2018 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
In-Reply-To: <20181026172549.3628-1-colin.king@canonical.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Oct 2018 20:20:12 +0200
Message-ID: <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To: colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 27 Oct 2018 22:38:08 +1100
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
Cc: kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Dave Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 maarten.lankhorst@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
 maxime.ripard@bootlin.com, jk@ozlabs.org, sean@poorly.run
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES

? It is not a typo, it is the name of the error (POSIX). Same thing
for the rest of the patches.

Cheers,
Miguel
