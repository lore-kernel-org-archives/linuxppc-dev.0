Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB9C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 10:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2082067D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 10:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2082067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467lll3kGQzDqvr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 20:13:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 467ljC1KTYzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 20:11:08 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79F3344;
 Wed, 14 Aug 2019 03:11:06 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EC253F706;
 Wed, 14 Aug 2019 03:11:05 -0700 (PDT)
Date: Wed, 14 Aug 2019 11:11:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv6 1/2] PCI: layerscape: Add the bar_fixed_64bit property
 in EP driver.
Message-ID: <20190814101100.GA29414@e121166-lin.cambridge.arm.com>
References: <20190814020330.12133-1-xiaowei.bao@nxp.com>
 <20190814092952.GA26840@e121166-lin.cambridge.arm.com>
 <AM5PR04MB32994A55A2951DD071C19F66F5AD0@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB32994A55A2951DD071C19F66F5AD0@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Roy Zang <roy.zang@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "M.h. Lian" <minghuan.lian@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 14, 2019 at 09:48:00AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: 2019年8月14日 17:30
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Cc: M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>;
> > bhelgaas@google.com; linuxppc-dev@lists.ozlabs.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCHv6 1/2] PCI: layerscape: Add the bar_fixed_64bit property
> > in EP driver.

Do not quote the email header in your replies.

> > I asked you to remove the period at the end of the patch $SUBJECT and you
> > did not, either you do not read what I write or explain me what's going on.
> Sorry, I didn't understand the meaning of period correctly before. 
> > 
> > On Wed, Aug 14, 2019 at 10:03:29AM +0800, Xiaowei Bao wrote:
> > > The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1 is
> > > 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware, so set
> > > the bar_fixed_64bit with 0x14.
> > >
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > 
> > Kishon ACK'ed this patch and you have not carried his tag.
> > 
> > I will make these changes but that's the last time I do that for you.
> Thanks a lot, your means is that I don't need to send the v7 patch and you help me to
> Correct this patch, yes? Thanks a lot for your help about the rules of the upstream. I will
> Correct this error next time. ^.^ 

I fixed that up and pushed out, pci/layerscape, for v5.4.

Thanks,
Lorenzo

> > Lorenzo
> > 
> > > ---
> > > v2:
> > >  - Replace value 0x14 with a macro.
> > > v3:
> > >  - No change.
> > > v4:
> > >  - send the patch again with '--to'.
> > > v5:
> > >  - fix the commit message.
> > > v6:
> > >  - remove the [EXT] tag of the $SUBJECT in email.
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
> > >  	.linkup_notifier = false,
> > >  	.msi_capable = true,
> > >  	.msix_capable = false,
> > > +	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> > >  };
> > >
> > >  static const struct pci_epc_features*
> > > --
> > > 2.9.5
> > >
