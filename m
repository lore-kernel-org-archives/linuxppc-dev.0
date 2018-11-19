Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB00C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:49:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D542080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elBeBSBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D542080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zLYn05vvzF22r
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:49:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="elBeBSBf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a42; helo=mail-vk1-xa42.google.com;
 envelope-from=baicar.tyler@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="elBeBSBf"; 
 dkim-atps=neutral
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zFK015RczDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 03:53:20 +1100 (AEDT)
Received: by mail-vk1-xa42.google.com with SMTP id j23so6763229vke.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2utPuwtZaCV/BmH5oamaY9JFsO2JnKsPFc89xDdn59s=;
 b=elBeBSBf3Zl0/mRynD7UsrBRw6KfrNqMca2tnv/vVJsRzHdSBUQhSf/NkBafIpUsJO
 fvMMHRTPh+UFjBgBKxIJkRzLeWbPBzkw+4nOVhNbcC8EIsebSPiNJ//RCBLjfiv1ooEx
 s5OjIVB+wkryf1qO4UFtnEfVEBhn6SKZCxc2sq4A4HS/6pLaCW34sFtBO3978QPn5f/n
 jrXv6FKEfB49BggqUaPqTtb6hWBt0xOEeGSL49+GIk/gNG4Z9rOivy780SXsSGCBAG7J
 AYt4JojfY8z4Pvh6Mpt6OCJ+WM6/lSv9tWGdzE1sd73pfupkKkV1Quc6LhWttFIqVhWU
 WqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2utPuwtZaCV/BmH5oamaY9JFsO2JnKsPFc89xDdn59s=;
 b=HI7N+VRQtjYdMs+l2QXmyQ4D6Lnuf87QODGDh4IH4xDMLLw9m+qDPKcyX1F/Oop1Ao
 jrAspxrCrHWwTNU/IpxwIJqQLKO875FrldrqWF16VJgzCcUmmymiTOGenFiLo/Nh+Wjz
 mopqEK7ZuTCxVhPPI8Y747SS1ENxT2wxEbE/5DuwrruspzcGd/9B6aqx0sPBB0WOInKU
 zs3+WhczFOYMyyEk6QZmDR2Q4aqx5nmKQs+7WYoUY7ugCOEV4UYGWimbl6bE97e5nzOy
 JgQcp9huM6NftvBiI8opEmy4IvBqv3cYSxTDmDbKfjZpwmuOZgETvlUfRiBtJwjH1Yfk
 bTdg==
X-Gm-Message-State: AGRZ1gKLFr4N0H8p0y74M6dqhLCurRYxVR4jPk7n4fgm+K3+NpUDJrmk
 pEL9+aLziaATnly7WiKvNxxVILMjox+O1hRnMJM=
X-Google-Smtp-Source: AJdET5dZ7CQPQ4KJW9mM/hQray2H4bTnuMC33GiMtLZADf9s5aJqFPlWISsy5TPD8/16LMLyGPJLrj1LZw9ptDHFTSU=
X-Received: by 2002:a1f:ac4:: with SMTP id 187mr9150831vkk.31.1542646398411;
 Mon, 19 Nov 2018 08:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
In-Reply-To: <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
From: Tyler Baicar <baicar.tyler@gmail.com>
Date: Mon, 19 Nov 2018 11:53:05 -0500
Message-ID: <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: okaya@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Nov 2018 07:45:08 +1100
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
Cc: alex_gagniuc@dellteam.com, helgaas@google.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, Shyam_Iyer@dell.com, rjw@rjwysocki.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 oohall@gmail.com, mr.nuke.me@gmail.com, bhelgaas@google.com,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> > I've asked around a few people at Dell and they unanimously agree that
> > _OSC is the correct way to determine ownership of AER. In linux, we
> > use the result of _OSC to enable AER services, but we use HEST to
> > determine AER ownership. That's inconsistent. This series drops the
> > use of HEST in favor of _OSC.
> >
> > [1]https://lkml.org/lkml/2018/11/15/62
>
> This change breaks the existing systems that rely on the HEST table
> telling the operating system about firmware first presence.
>
> Besides, HEST table has much more granularity about which PCI component
> needs firmware such as global/device/switch.
>
> You should probably circulate these ideas for wider consumption in UEFI
> forum as UEFI owns the HEST table definition.

I agree with Sinan, this will break existing systems, and the granularity of the
HEST definition is more useful than the single bit in _OSC.
