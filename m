Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B01C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 01:34:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846020720
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 01:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRnduxVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rTNS65Q9zDqT9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 11:34:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hRnduxVY; dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rTLl0mlMzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 11:33:18 +1000 (AEST)
Received: by mail-il1-x143.google.com with SMTP id l9so3039014ilq.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x99pYwa1dnOzvMHARyvq3wdM6wF3B15xvFgvTOgiQu8=;
 b=hRnduxVYqOiY+fbFT+FYlxtB/hvdIuvh15lxw6gyLq9tvdyWE35P6IsXTkt3CHRKcw
 L6d/lGdHY5APNXYzl048L4v7VjtF2KpgzRQwt0yIv70P12j/VpdfLtsTrMAK+VqH1yCI
 QBAB2p3E7d4I/1OYHetRPqgcrRrID1POtWkCvnNwnSOnAJKfr9FyRgGdcEhEOIoZFSBW
 /2ukft/5XB7tkhWi5R7ToB5Q54QtaZqU80QrEKbyvsTItDKkXl3HbrwryBHvcayJxZgY
 vbSzg8VzneA0g95IcGaiZTdg8rTf3MvIJjkZcLLw/62eQlHlmei4aU9UACQOJ/aSh971
 RfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x99pYwa1dnOzvMHARyvq3wdM6wF3B15xvFgvTOgiQu8=;
 b=TYJRRn4DjH30Ps/66PE4NJpgcwIJLTCc0nAHuqqMWhtcbsvLDqggLjcDGDisn1UhDn
 TAVryZjAe8cOZB9+FEL1BtZvcv9dUNol1/V4jPo0rO1MrMkkauN5FQoTHU8XrIFH4TgA
 2aDe/Is/7Y2ZF52E0YV8rY/S/QN30ZYBJEmr6rrIGZ8ZT+BxMpsCfGwx4pV/NMARzXrH
 naJRuI9jU3QbrzHiTAWBaF/WGY9zg7Qi7HRbhs9IZITSjFmlpe8J/M1LwOiWiNtlcRRl
 KDt97YdnHF1RlNYm85UZs4Z88d1sQ3iSFbasLCfQiCvB9MI03iI2ZOEqRnQhOhXNqnSF
 w4/Q==
X-Gm-Message-State: AOAM532/IbsWUVQugXXMLEDxLzWxNemOHmeKGoQ/wxKcyZqczroUVR0v
 gRT0MRwmZGmxtmF5ZFWDS23P+74w1XNtbGvXdS0=
X-Google-Smtp-Source: ABdhPJzTfCb2U1e8nQgyWrE1u/wEZVkPKLluhndGJCrScd8Q+8irkUc7rvtTbu1dXLAuNwS0lxI2YsHNSSavOLFQ4S8=
X-Received: by 2002:a92:da0b:: with SMTP id z11mr19094462ilm.149.1592875995226; 
 Mon, 22 Jun 2020 18:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200619050619.266888-1-leobras.c@gmail.com>
 <20200619050619.266888-4-leobras.c@gmail.com>
 <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru>
 <ccf7b591f2bf61ba4705699b2e2b050c3cf48d99.camel@gmail.com>
 <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
In-Reply-To: <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 23 Jun 2020 11:33:03 +1000
Message-ID: <CAOSf1CEC-tYH1so5b4P7dQ7s8v1o4qy_u5CG7LKtKNnRQvC4-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of
 remove_ddw into remove_dma_window
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: Leonardo Bras <leobras.c@gmail.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 23, 2020 at 11:12 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> On 23/06/2020 04:59, Leonardo Bras wrote:
> >
> >> Also, despite this particular file, the "pdn" name is usually used for
> >> struct pci_dn (not device_node), let's keep it that way.
> >
> > Sure, I got confused for some time about this, as we have:
> > static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn).
> > but on *_ddw() we have "struct pci_dn *pdn".
>
> True again, not the cleanest style here.
>
>
> > I will also add a patch that renames those 'struct device_node *pdn' to
> > something like 'struct device_node *parent_dn'.

I usually go with "np" or "node". In this case I'd use "parent_np" or
just "parent." As you said pci_dn conventionally uses pdn so that
should be avoided if at all possible. There's some places that just
use "dn" for device_node, but I don't think that's something we should
encourage due to how similar it is to pdn.

> I would not go that far, we (well, Oliver) are getting rid of many
> occurrences of pci_dn and Oliver may have a stronger opinion here.

I'm trying to remove the use of pci_dn from non-RTAS platforms which
doesn't apply to pseries. For RTAS platforms having pci_dn sort of
makes sense since it's used to cache data from the device_node and
having it saves you from needing to parse and validate the DT at
runtime since we're supposed to be relying on the FW provided settings
in the DT. I want to get rid of it on PowerNV because it's become a
dumping ground for random bits and pieces of platform specific data.
It's confusing at best and IMO it duplicates a lot of what's already
available in the per-PHB structures which the platform specific stuff
should actually be looking at.

Oliver
