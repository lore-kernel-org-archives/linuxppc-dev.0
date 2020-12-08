Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C046CC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:08:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02A423B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02A423B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrCTW5h21zDqkJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 08:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=c7AcH56T; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrCQg4nFzzDqkL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 08:06:19 +1100 (AEDT)
Date: Tue, 8 Dec 2020 15:06:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607461575;
 bh=fSoNQRcc0LZ9Vd4mfNnsBvZ5tqGU/FOK1XZtvccEZA0=;
 h=From:To:Cc:Subject:In-Reply-To:From;
 b=c7AcH56Thqe+4NCEmqVgXEzAwWClmNtrpb8HtX8PCFxHBUz8Fs68Cj+dMGuehEUvc
 19RjHSE/mjUAt9FlbAu7gSUO0l6+zLTWnm1oiVWlK13pSCawfo2A9v5u7Gp9YKQdP5
 Cii+EnPfpluaZhUhZSGOVp63ldAhb0L2IfPzbDPUL7gbtYEr76QGCbuqnWnToi0la6
 vQvXAGU1s3VYsHFMq6LK6AzvArf88/G4IZYY7o6iXlHhvKskJBykRi7Dze0jVTCeWF
 6zncRzClJoP3Ofzut9MEVgANCxGWCl41bJjUQMHjcNabScCR+A4+8LCnl9bqALN0hM
 aiCUVLDOpIjqA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201208210613.GA2420289@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208154150.20978-1-michael@walle.cc>
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
Cc: kw@linux.com, heiko@sntech.de, shawn.lin@rock-chips.com, paulus@samba.org,
 thomas.petazzoni@bootlin.com, jonnyc@amazon.com, toan@os.amperecomputing.com,
 will@kernel.org, robh@kernel.org, lorenzo.pieralisi@arm.com,
 michal.simek@xilinx.com, linux-rockchip@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Qian Cai <qcai@redhat.com>, rjui@broadcom.com,
 f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, jonathan.derrick@intel.com,
 sbranden@broadcom.com, wangzhou1@hisilicon.com, rrichter@marvell.com,
 linuxppc-dev@lists.ozlabs.org, nsaenzjulienne@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Qian]

On Tue, Dec 08, 2020 at 04:41:50PM +0100, Michael Walle wrote:
> Hi Lorenzo, Krzysztof,
> 
> >On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
> >> Unify ECAM-related constants into a single set of standard constants
> >> defining memory address shift values for the byte-level address that can
> >> be used when accessing the PCI Express Configuration Space, and then
> >> move native PCI Express controller drivers to use newly introduced
> >> definitions retiring any driver-specific ones.
> >> 
> >> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> >> PCI Express specification (see PCI Express Base Specification, Revision
> >> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> >> implement it the same way.
> >> 
> >> [...]
> >
> >Applied to pci/ecam, thanks!
> >
> >[1/5] PCI: Unify ECAM constants in native PCI Express drivers
> >      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
> >[2/5] PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
> >      https://git.kernel.org/lpieralisi/pci/c/3c38579263
> >[3/5] PCI: iproc: Convert to use the new ECAM constants
> >      https://git.kernel.org/lpieralisi/pci/c/333ec9d3cc
> >[4/5] PCI: vmd: Update type of the __iomem pointers
> >      https://git.kernel.org/lpieralisi/pci/c/89094c12ea
> >[5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
> >      https://git.kernel.org/lpieralisi/pci/c/3dc62532a5
> 
> Patch 1/5 breaks LS1028A boards:

I temporarily dropped this series while we figure out what went wrong
here.

Bjorn
