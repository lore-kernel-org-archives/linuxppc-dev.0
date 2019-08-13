Return-Path: <SRS0=6DYt=WJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D0C32750
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 09:53:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2055120663
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 09:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2055120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4677MY3WDVzDqWM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 19:53:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4677KM33ZkzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2019 19:51:48 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC3A337;
 Tue, 13 Aug 2019 02:51:46 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026FC3F706;
 Tue, 13 Aug 2019 02:51:43 -0700 (PDT)
Date: Tue, 13 Aug 2019 10:51:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [EXT] Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit
 property in EP driver.
Message-ID: <20190813095151.GA10070@red-moon>
References: <20190813062840.2733-1-xiaowei.bao@nxp.com>
 <61e6df1c-a0dc-8f05-f74a-85a3cac9823f@ti.com>
 <AM5PR04MB32993CC1344DD660A298C7E1F5D20@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB32993CC1344DD660A298C7E1F5D20@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Roy Zang <roy.zang@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yue.wang@amlogic.com" <yue.wang@amlogic.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
 "jonnyc@amazon.com" <jonnyc@amazon.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "tpiepho@impinj.com" <tpiepho@impinj.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mingkai Hu <mingkai.hu@nxp.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

You should fix your email client set-up to avoid sticking an [EXT]
tag to your emails $SUBJECT.

On Tue, Aug 13, 2019 at 07:39:48AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Kishon Vijay Abraham I <kishon@ti.com>
> > Sent: 2019年8月13日 15:30
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>; lorenzo.pieralisi@arm.com;
> > bhelgaas@google.com; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>;
> > l.stach@pengutronix.de; tpiepho@impinj.com; Leonard Crestez
> > <leonard.crestez@nxp.com>; andrew.smirnov@gmail.com;
> > yue.wang@amlogic.com; hayashi.kunihiko@socionext.com;
> > dwmw@amazon.co.uk; jonnyc@amazon.com; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit
> > property in EP driver.
> > 
> > Caution: EXT Email

See above, this "Caution" stuff should disappear.

Also, quoting the email header is useless, please configure your email
client to remove it.

Thanks,
Lorenzo

> > On 13/08/19 11:58 AM, Xiaowei Bao wrote:
> > > The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1 is
> > > 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware, so set
> > > the bar_fixed_64bit with 0x14.
> > >
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > > v2:
> > >  - Replace value 0x14 with a macro.
> > > v3:
> > >  - No change.
> > > v4:
> > >  - send the patch again with '--to'.
> > > v5:
> > >  - fix the commit message.
> > >
> > >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > index be61d96..ca9aa45 100644
> > > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > @@ -44,6 +44,7 @@ static const struct pci_epc_features
> > ls_pcie_epc_features = {
> > >       .linkup_notifier = false,
> > >       .msi_capable = true,
> > >       .msix_capable = false,
> > > +     .bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> > >  };
> > >
> > >  static const struct pci_epc_features*
> I check other platforms, it is 'static const struct pci_epc_features', I can get the correct 
> Value use this define way in pci-epf-test.c file.
> > >
