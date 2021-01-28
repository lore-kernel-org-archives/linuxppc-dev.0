Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA693C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 10:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0C864DBD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 10:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0C864DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRGWb2tvnzDsFV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 21:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=atomide.com
 (client-ip=72.249.23.125; helo=muru.com; envelope-from=tony@atomide.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 646 seconds by postgrey-1.36 at bilbo;
 Thu, 28 Jan 2021 21:11:32 AEDT
Received: from muru.com (muru.com [72.249.23.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DRGTc51LYzDrgt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 21:11:32 +1100 (AEDT)
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 752CB80A9;
 Thu, 28 Jan 2021 10:00:44 +0000 (UTC)
Date: Thu, 28 Jan 2021 12:00:35 +0200
From: Tony Lindgren <tony@atomide.com>
To: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
Message-ID: <YBKLQ1m35Bouc6/B@atomide.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc>
 <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc>
 <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24391e62b107040435766fff52bdd31@walle.cc>
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
Cc: Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Saravana Kannan <saravanak@google.com>, PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 Minghuan Lian <minghuan.Lian@nxp.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

* Michael Walle <michael@walle.cc> [210125 19:52]:
> Although I do have the changes for the builtin_platform_driver_probe()
> ready, I don't think it makes much sense to send these unless we agree
> on the increased memory footprint. While there are just a few
> builtin_platform_driver_probe() and memory increase _might_ be
> negligible, there are many more module_platform_driver_probe().

I just noticed this thread today and have pretty much come to the same
conclusions. No need to post a patch for pci-dra7xx.c, I already posted
a patch for pci-dra7xx.c yesterday as part of genpd related changes.

For me probing started breaking as the power-domains property got added.

FYI, it's the following patch:

[PATCH 01/15] PCI: pci-dra7xx: Prepare for deferred probe with module_platform_driver

Regards,

Tony


