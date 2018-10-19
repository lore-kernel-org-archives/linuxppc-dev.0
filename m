Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904BCECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:10:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC24520838
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1Y9ZK5fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC24520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bvBB3J8pzF3Yy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 16:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="1Y9ZK5fy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="1Y9ZK5fy"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bv7c2B9kzF3Hj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:08:11 +1100 (AEDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id w9J57fDX004298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 14:07:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9J57fDX004298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539925661;
 bh=mYjXID3VQmfIEufK9cARuqSnPYUqryDcSZUlpJZAewA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1Y9ZK5fyIB2Accb6pTy7yVKn6mKHVUA7eMYaNc3Dv4aB34/qhZOrT7eOhO5QnMvpc
 9sC932supXKoexoJT6CYI1Ok0OlWnj+D9dsQLo0TB/9SuYxg+aIi4/DjD8QTn/TJQe
 N+y90dFt/aLO2PP//AUUxiHz/BtH0R5iECtC0KpYVtGYVibF6mA+6C0MpK9z16fhxZ
 JUyItv4smufVSgs9qGttycS3HgeAT0+qeZ9gMus27iTn41gS85efJXnWay8NyLA9KU
 oBJnubkvsb7Llm1IRY4FevsChbVv2lW7+8vgiw6kz+r57roY9BUdkAgNCMddS9XT+V
 xEmdyujFfuYmA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id e126so24555569vsc.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:07:41 -0700 (PDT)
X-Gm-Message-State: ABuFfoi22lK/ECw2z/t5BzneBJaHFC7ayMFmAEEJNCIg+0z6WZP0DlTO
 k+FE+FY4cnjvObXE4nvRXHHNaf46uMy7kaNXJYg=
X-Google-Smtp-Source: ACcGV60+ZPcmOytHtgLIeEc9t4tMNXp0dYDWA083Ni5ycAjI7Cy45BYFIxfylO9JQUtZhKE4X5jSt+ZyOSVmOoUm1Dk=
X-Received: by 2002:a67:3793:: with SMTP id j19mr13514804vsi.215.1539925660531; 
 Thu, 18 Oct 2018 22:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-5-hch@lst.de>
In-Reply-To: <20181017080201.10866-5-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 14:07:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
Message-ID: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
To: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 17, 2018 at 5:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAS_PCI symbol that indicates availability

HAS_PCI -> HAVE_PCI


> of PCI support and the handle the rest in drivers/pci.
>
> Note that for powerpc we now select HAVE_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>



Just in case, could you double-check these?
PCI_ENDPOINT
PCI_ENDPOINT_CONFIGFS
PCI_EPF_TEST


Previously, architecture without "source drivers/pci/Kconfig"
could not enable PCI_ENDPOINT.

Now, any architecture can enable it
regardless of its actual PCI availability
because PCI_ENDPOINT is only guarded by HAS_DMA.


We could add 'depends on HAVE_PCI' or something
to guard it to avoid changing the logic.


config PCI_ENDPOINT
        bool "PCI Endpoint Support"
        depends on HAVE_PCI     # Is this correct ??
        depends on HAS_DMA


or better to have 'depends on PCI' ?


PCI ML is also CC'ed, so comments are appreciated.



-- 
Best Regards
Masahiro Yamada
