Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6DCECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:33:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0922083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0922083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c91K1SnkzF3c6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 02:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=joshtriplett.org
 (client-ip=217.70.178.242; helo=mslow2.mail.gandi.net;
 envelope-from=josh@joshtriplett.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joshtriplett.org
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c8z645SqzF3Ss
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 02:31:45 +1100 (AEDT)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id B5E3F3A7D74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:11:03 +0200 (CEST)
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net
 [50.39.174.102]) (Authenticated sender: josh@joshtriplett.org)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0F9261BF204;
 Fri, 19 Oct 2018 15:10:25 +0000 (UTC)
Date: Fri, 19 Oct 2018 08:10:23 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/9] powerpc: PCI_MSI needs PCI
Message-ID: <20181019151019.GA5618@localhost>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019120952.32763-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> Various powerpc boards select the PCI_MSI config option without selecting
> PCI, resulting in potentially not compilable configurations if the by
> default enabled PCI option is disabled.  Explicitly select PCI to ensure
> we always have valid configs.
[...]
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -24,6 +24,7 @@ config BLUESTONE
>  	default n
>  	select PPC44x_SIMPLE
>  	select APM821xx
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_MSI
>  	select PPC4xx_PCI_EXPRESS
> @@ -78,6 +79,7 @@ config KATMAI
>  	select 440SPe
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI

This case already had PCI selected a couple of lines above.

>  	select PPC4xx_MSI
>  	help
> @@ -219,6 +221,7 @@ config AKEBONO
>  	select SWIOTLB
>  	select 476FPE
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_HSTA_MSI
>  	select I2C
> -- 
> 2.19.1
> 
