Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06409C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A823B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2A823B1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrCZg4B3VzDqMT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 08:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=walle.cc (client-ip=176.9.125.105; helo=ssl.serverraum.org;
 envelope-from=michael@walle.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=walle.cc header.i=@walle.cc header.a=rsa-sha256
 header.s=mail2016061301 header.b=FkpapXYk; 
 dkim-atps=neutral
X-Greylist: delayed 19734 seconds by postgrey-1.36 at bilbo;
 Wed, 09 Dec 2020 08:11:23 AEDT
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrCXW2zcjzDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 08:11:22 +1100 (AEDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 3E93822EE4;
 Tue,  8 Dec 2020 22:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1607461873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEFjtBVF86/OHAKEUK7w4OIQbvBmdzPeOud2sztujh8=;
 b=FkpapXYkkYDM2Wa6lDGwZbcxVEW5J57qlVbjxNxZm4kOHYNmmsfnqcpb1xD6/p1EX4eQJ4
 R/96LjaUeq7PPPZZows0e9l9dJ7irfcHr0KCnHE2ePf6tsgDCDnLwy5ChY4wJbhJtAIjR/
 4LO2U5+cRQRXidZgmTLDZVXZRW/RDUE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 08 Dec 2020 22:11:11 +0100
From: Michael Walle <michael@walle.cc>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
In-Reply-To: <20201208210613.GA2420289@bjorn-Precision-5520>
References: <20201208210613.GA2420289@bjorn-Precision-5520>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <be626f557ebf580babebad5457023617@walle.cc>
X-Sender: michael@walle.cc
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

Am 2020-12-08 22:06, schrieb Bjorn Helgaas:
> [+cc Qian]
> 
> On Tue, Dec 08, 2020 at 04:41:50PM +0100, Michael Walle wrote:
>> Hi Lorenzo, Krzysztof,
>> 
>> >On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
>> >> Unify ECAM-related constants into a single set of standard constants
>> >> defining memory address shift values for the byte-level address that can
>> >> be used when accessing the PCI Express Configuration Space, and then
>> >> move native PCI Express controller drivers to use newly introduced
>> >> definitions retiring any driver-specific ones.
>> >>
>> >> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
>> >> PCI Express specification (see PCI Express Base Specification, Revision
>> >> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
>> >> implement it the same way.
>> >>
>> >> [...]
>> >
>> >Applied to pci/ecam, thanks!
>> >
>> >[1/5] PCI: Unify ECAM constants in native PCI Express drivers
>> >      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
>> >[2/5] PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
>> >      https://git.kernel.org/lpieralisi/pci/c/3c38579263
>> >[3/5] PCI: iproc: Convert to use the new ECAM constants
>> >      https://git.kernel.org/lpieralisi/pci/c/333ec9d3cc
>> >[4/5] PCI: vmd: Update type of the __iomem pointers
>> >      https://git.kernel.org/lpieralisi/pci/c/89094c12ea
>> >[5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
>> >      https://git.kernel.org/lpieralisi/pci/c/3dc62532a5
>> 
>> Patch 1/5 breaks LS1028A boards:
> 
> I temporarily dropped this series while we figure out what went wrong
> here.

Thanks, let me know if I can test something on the board.

-michael
