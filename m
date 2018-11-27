Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C82C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 18:48:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344AF2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1NkMX5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344AF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434CVM51ZkzDqfB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 05:48:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1NkMX5g";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a42; helo=mail-vk1-xa42.google.com;
 envelope-from=baicar.tyler@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1NkMX5g"; 
 dkim-atps=neutral
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434CRc4fgBzDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 05:46:20 +1100 (AEDT)
Received: by mail-vk1-xa42.google.com with SMTP id t132so4540871vkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hQTVYi/IX2AKLhpwGzc+W4Z78Vf1wsvfIygNygWDrpE=;
 b=O1NkMX5gSQym1ZHxSW2nPI7UUNMYYB1BcymE3f/pL/1krh9wyMNUjpCwmoboD0HNks
 kKSIspCARkYH0R6sSZfmeLToD5RK+eDRTVmHKSAGe66nEkNzSV3vcaDm4aqtCN9cHxxr
 LMW+EgdOWYAbw/t0uorblBvknJ/Pm7tGQdsCNOAwIrQmMXa4qa/yYuOjW9V8URPLtNle
 lxhlDYNkgSd9Wjx82AH8yCQ+61f2TEBtIpgwrb7lp31xi/15wxy52AYoV4pda8u6yEEt
 KZPbfTZ+4Gj9MYY9jEUkbHrKiPkDWlYdEfUI9Ls4QFvPKeS9Bq/8wWKZQR/ccfoTTLST
 c15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hQTVYi/IX2AKLhpwGzc+W4Z78Vf1wsvfIygNygWDrpE=;
 b=ER4Z23xv6VtA4b1yxZeWPUf4JmwhQ3cOboXk2FKmOJVrmXWH6j2UEf1zWdRNqncvFk
 1x2Qu5szJFScI5mF8wwPKVaWXzlGBz3K5fumMyMU3+a0P+soRLNvxEINBf+Z37wDsFBf
 DkdEMQk8XW560NWmHVPYZ2zdiNsbqH798QkJz6KE6P5CM+GqnJWWUErWxyJE7Jvns/gL
 GgVOPigZu1z98gky/qr1MDEINLo6VSWdPXKzV8LPydZO478Oaf00upyK2EXh8ONipwFx
 vJYrmxq6NNH9p3oTrxpJPNl/EcH8d7gRlgWP2u+UDuEz4Iq00kfCH5C9pYIslCtvkBcZ
 boZg==
X-Gm-Message-State: AA+aEWZxV8H8jkPNWnL4In/3I1rsL/51v4chem7+wr+gBb+YmT87fRIh
 17fnKr6uB1HOfevoL/4iIiSDxoSSPO4Iug6E/SY=
X-Google-Smtp-Source: AFSGD/XUyF3HxcHdb/0AOzE0E/BgNWSBqJHw7iGkDFASWxF50bPcCw2N/mStGuROZo0OBWAXAq/ka2ZjQAwqwdVa4lI=
X-Received: by 2002:a1f:eecf:: with SMTP id m198mr13521763vkh.49.1543344377798; 
 Tue, 27 Nov 2018 10:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
 <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org>
 <336e233b1ad642dcac9638d5fb275810@ausx13mps321.AMER.DELL.COM>
 <c385770a-9eec-b040-7861-0a3d455148b9@kernel.org>
In-Reply-To: <c385770a-9eec-b040-7861-0a3d455148b9@kernel.org>
From: Tyler Baicar <baicar.tyler@gmail.com>
Date: Tue, 27 Nov 2018 13:46:05 -0500
Message-ID: <CABo9ajDNECh8WNACUwTBLPF_UDvMq5XGqYF3ZT8ehnO0F3n=5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: okaya@kernel.org
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
Cc: Alex_Gagniuc@dellteam.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver <oohall@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Austin.Bolen@dell.com, Bjorn Helgaas <bhelgaas@google.com>,
 Shyam.Iyer@dell.com, linuxppc-dev@lists.ozlabs.org,
 Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 27, 2018 at 1:32 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 11/27/2018 1:22 PM, Alex_Gagniuc@Dellteam.com wrote:
> > On 11/20/2018 04:08 PM, Sinan Kaya wrote:
> >> I followed the ASWG thread yesterday. There will be a meeting next week to
> >> discuss this.
> >
> > Any updates on the meeting?
> >
> >
>
> Tyler should be able to get an update.

As per Harb, the meetings are on Thursdays so it will be discussed this
Thursday since last week was a holiday.

Thanks,
Tyler
