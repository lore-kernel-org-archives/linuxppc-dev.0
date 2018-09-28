Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DACC43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:24:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1516E20657
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 20:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1516E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MNSc5g1CzF3Qn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 06:24:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=pengutronix.de
 (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33; helo=metis.ext.pengutronix.de;
 envelope-from=l.stach@pengutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
X-Greylist: delayed 943 seconds by postgrey-1.36 at bilbo;
 Sat, 29 Sep 2018 06:22:47 AEST
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MNQb65YrzF3HY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 06:22:47 +1000 (AEST)
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1g5z2E-0000yI-6l; Fri, 28 Sep 2018 22:06:46 +0200
Message-ID: <4c740fb03dec9dbd45264207da96fcd2051e634f.camel@pengutronix.de>
Subject: Re: drivers binding to device node with multiple compatible strings
From: Lucas Stach <l.stach@pengutronix.de>
To: Frank Rowand <frowand.list@gmail.com>, Li Yang <leoyang.li@nxp.com>, Rob
 Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@secretlab.ca>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 28 Sep 2018 22:06:41 +0200
In-Reply-To: <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Am Freitag, den 28.09.2018, 12:43 -0700 schrieb Frank Rowand:
> + Frank
> 
> On 09/27/18 15:25, Li Yang wrote:
> > Hi Rob and Grant,
> > 
> > Various device tree specs are recommending to include all the
> > potential compatible strings in the device node, with the order from
> > most specific to most general.  But it looks like Linux kernel doesn't
> > provide a way to bind the device to the most specific driver, however,
> > the first registered compatible driver will be bound.
> > 
> > As more and more generic drivers are added to the Linux kernel, they
> > are competing with the more specific vendor drivers and causes problem
> > when both are built into the kernel.  I'm wondering if there is a
> > generic solution (or in plan) to make the most specific driver bound
> > to the device.   Or we have to disable the more general driver or
> > remove the more general compatible string from the device tree?

Not really contributing to the solution, but the hard question to
answer is when do you know what the most specific driver is? The most
specific driver might well be a module that can be loaded at any time,
while there might already be other less specific drivers around.

In general I would say that if your device is specific enough to
warrant a whole new driver, it should not declare compatibility with
the generic thing in the compatible, but then this is kind of exporting
an Linux implementation detail to DT.

Regards,
Lucas

