Return-Path: <SRS0=a6W3=DB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A941C4346E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 07:17:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8E420936
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 07:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt1H2ClY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8E420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BxmZM10k2zDqkx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 17:16:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d43;
 helo=mail-io1-xd43.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bt1H2ClY; dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bxlnt3GTHzDqbF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 16:41:54 +1000 (AEST)
Received: by mail-io1-xd43.google.com with SMTP id u6so2145116iow.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2020 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nc/zXBadEVOmIc4OHWI+QEDHr9bs5kygtZ+w9n+QyNA=;
 b=bt1H2ClYpG6wRBMl3caRAX4oc9cclKQ6XJRi8LQ5BQkrpCJxtex3tyrMwzGPAVaax6
 tRNaBZriP+Xkd4JTfFowUvkRuRV0vvU41uk+CXSIm7gcTxm5aG79V6Ap6fxA7Mehmn+X
 WJ69uyB0ZlPtvrGPuUAYcgQkrEjGFoAJWBPb8rtXq7xXicAkuVyee/N0YE1hVBMyiETD
 ldtFhrgTZ6OFkXJ98rEtgBcpscpLNRscXohkBRnn19V0iDJHisgA1ZyZ6CTVgIn7Bjtb
 70WO9FbMuw9f+alGIudE/2zj1ae8t7oBk4uF3xY3cvUJCL5pIpz0Si3KflORXaUakP+/
 6WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nc/zXBadEVOmIc4OHWI+QEDHr9bs5kygtZ+w9n+QyNA=;
 b=Vry31uLeCwWSFzc2K9vhabYhhyxLn8x2vk0UJnk7sQ05oWb0WsE9C2/E+CarvarCnO
 XY5JaZQu6xPIvOzF7hzCOZCcW+QQj6Ji1FmN0rPQyZewhfOHZSR099h2emwukMbdl8Zh
 QhJhn6JhWhpVWUTMuxZbJg3q9MhXD4h1EXQ5kHIdW5BGBQtc2SaL4SHWR5XnREC9ut+a
 E0bcj2YxLZbIADlleToKYA904FlEvkCfOJCREnFPlYH7/OgOmpsHwj6GG1oBK4qWAI9E
 hvcLpSpNHHXbsaqW7KZaMAKQzCYkxZ1rU2tWFBAACcYmSQCBMnlUnZWSf14aPt7qe+fA
 SrEg==
X-Gm-Message-State: AOAM532dOuGe8Zz7cYDC0kxXPGeTGiG2LBNg5ro4bWrJgJSUwchvChP2
 3wPtkRhyea57GC3omK4vUQjtVfgtLK323D0iupI=
X-Google-Smtp-Source: ABdhPJz9Z48rA7YNFkkLeQn2ItT1DskwJV6AnHnzPbQ2u5MHEkr6m8hq1mErYNocrznn0VblhKBV5Qgv1f8gkKFFKX0=
X-Received: by 2002:a02:ccca:: with SMTP id k10mr2538463jaq.111.1600929710016; 
 Wed, 23 Sep 2020 23:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200924051343.16052.9571.stgit@localhost.localdomain>
In-Reply-To: <20200924051343.16052.9571.stgit@localhost.localdomain>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 24 Sep 2020 16:41:39 +1000
Message-ID: <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel
 modules
To: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
<mamatha4@linux.vnet.ibm.com> wrote:
>
> This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> (descriptions taken from Kconfig file)
>
> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> ---
>  drivers/pci/hotplug/rpadlpar_core.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index f979b70..bac65ed 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
>  module_init(rpadlpar_io_init);
>  module_exit(rpadlpar_io_exit);
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");

RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
this already?

The only potential problem I can see is scripts doing: modprobe
rpadlpar_io or similar

However, we should be able to fix that with a module alias.

Oliver
