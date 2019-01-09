Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A4C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:03:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756D20883
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJdGXjxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z9qC5Yh8zDqc6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 12:03:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OJdGXjxk"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z9mm0XgVzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 12:01:11 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id f4so4744162ion.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 17:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GLBOEFW1BhFjPn/VvwGPbj8DpAhgGskTf+W4ne2TdMw=;
 b=OJdGXjxkhZTQtX4JfOQs2JCwWwI23LWlpkzbdXpAOovmlh9CPS6tj+yvlCEup40cJ+
 1xoOo/6wNgcr691iBTD3zxSm1JZrm62APL8Ot2Ta6kOWxDzvQcB/3YPl9e/pM9wYMbmV
 M9Rj0Qr3AJm6J3U/6BnqjQ2KP1vGYUpjLqZBKDnGS2onpV8NnO++j3D7VlYKynKMoITC
 6mG3nO+6oQFJsznVPkntwcYhbs5n7TAuolxyWeBNhaKhLrbIKKrq/aJwZwyshRaj5qL0
 e9xGFJsMF5YAsebFlEc1A1igqGxHJnYi0C9LIrNyAcEqmJIz74KHQ0iuzj9pis8zes5E
 LkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GLBOEFW1BhFjPn/VvwGPbj8DpAhgGskTf+W4ne2TdMw=;
 b=GU1SV/ikeRG/CpurWF81wol4J1YonYR/i6clqO6IlGg0sCu3HZzYSPMx4A7QDElsjG
 hzZA7ilUBLkUSQPAslPPv+T+Zey0hp9QBzCdF+2RBf+fwTrRRfSPPUuH9Sasomq0ULwn
 iJHRSgqwO1cTs4xkxAlPy7XuL+GkMC/0pKEcqg28xarEqPF+Hy1qKfJ/lOQq2ecUJ0OS
 +DGGvP2y9FMEV2RloV1ytoaqh26pxlXK+Vdm1LLso+2Y50AGoZldWzS0lisyfpIaBqP4
 piyDLrGD7BgbeQ9Ojae5PVUWeZ8j2ige7LQ6TReaQynJUeum+qS2JeV3cPRBdAtrX8wO
 PCgw==
X-Gm-Message-State: AJcUukfEZMPa99hgq3qRskUqGOnqI3xS+g9NaCL0vOd6/6a9VILx2ms/
 FgoW+2PBfWKRFAI8W7+xWmKXfC9Fs1w2logu0zY=
X-Google-Smtp-Source: ALg8bN5JOGUwXRFTSZbixwnXLfLvw6SzZun/iyX7h1Do+bRYcNnqGYIpRXVv5EI8IIE+PviDVlDMHpGEt1iYaDlek2A=
X-Received: by 2002:a6b:db17:: with SMTP id t23mr2605267ioc.262.1546995669925; 
 Tue, 08 Jan 2019 17:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20190108223024.GA147017@google.com>
In-Reply-To: <20190108223024.GA147017@google.com>
From: Oliver <oohall@gmail.com>
Date: Wed, 9 Jan 2019 12:00:58 +1100
Message-ID: <CAOSf1CFRjynR_qCOH=RXGEqpV6PuhHwzCHhKsniNPojEcif8rg@mail.gmail.com>
Subject: Re: Kconfig label updates
To: Bjorn Helgaas <helgaas@kernel.org>
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
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 9, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi,
>
> I want to update the PCI Kconfig labels so they're more consistent and
> useful to users, something like the patch below.  IIUC, the items
> below are all IBM-related; please correct me if not.
>
> I'd also like to expand (or remove) "RPA" because Google doesn't find
> anything about "IBM RPA", except Robotic Process Automation, which I
> think must be something else.
>
> Is there some text expansion of RPA that we could use that would be
> meaningful to a user, i.e., something he/she might find on a nameplate
> or in a user manual?

"RISC Platform Architecture" apparently. I couldn't find any
documentation written in the last decade that uses the term so it's
probably a hold-over from when pseries and iseries had separate
hardware platforms. Replacing "RPA" with "pseries" would be the least
confusing way to handle it.

> Ideally the PCI Kconfig labels would match the terms used in
> arch/.../Kconfig, e.g.,
>
>   config PPC_POWERNV
>     bool "IBM PowerNV (Non-Virtualized) platform support"
>
>   config PPC_PSERIES
>     bool "IBM pSeries & new (POWER5-based) iSeries"
>
>   config MARCH_Z900
>     bool "IBM zSeries model z800 and z900"
>
>   config MARCH_Z9_109
>     bool "IBM System z9"
>
> Bjorn
>
>
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index e9f78eb390d2..1c1d145bfd84 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_POWERNV
> -       tristate "PowerPC PowerNV PCI Hotplug driver"
> +       tristate "IBM PowerNV PCI Hotplug driver"
>         depends on PPC_POWERNV && EEH
>         select OF_DYNAMIC
>         help
> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_RPA
> -       tristate "RPA PCI Hotplug driver"
> +       tristate "IBM Power Systems RPA PCI Hotplug driver"
>         depends on PPC_PSERIES && EEH
>         help
>           Say Y here if you have a RPA system that supports PCI Hotplug.
> +         This includes the earlier pSeries and iSeries.
>
>           To compile this driver as a module, choose M here: the
>           module will be called rpaphp.
> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_RPA_DLPAR
> -       tristate "RPA Dynamic Logical Partitioning for I/O slots"
> +       tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
>         depends on HOTPLUG_PCI_RPA
>         help
>           Say Y here if your system supports Dynamic Logical Partitioning
> @@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_S390
> -       bool "System z PCI Hotplug Support"
> +       bool "IBM System z PCI Hotplug Support"
>         depends on S390 && 64BIT
>         help
>           Say Y here if you want to use the System z PCI Hotplug
