Return-Path: <SRS0=N2pq=UR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9887C31E51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BF62084D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SnZQ0ZQYzDqRG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 22:34:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SnTp0tjqzDqdV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2019 22:30:05 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5ICTJJT030631;
 Tue, 18 Jun 2019 07:29:24 -0500
Message-ID: <a2494d627548d788650be4af0ee1d6ed700da134.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/pci/of: Parse unassigned resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Jun 2019 22:29:19 +1000
In-Reply-To: <87sgs7ozsa.fsf@concordia.ellerman.id.au>
References: <20190614025916.123589-1-aik@ozlabs.ru>
 <87sgs7ozsa.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, kvm-ppc@vger.kernel.org, Oliver
 O'Halloran <oohall@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-06-18 at 22:15 +1000, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> > The pseries platform uses the PCI_PROBE_DEVTREE method of PCI probing
> > which is basically reading "assigned-addresses" of every PCI device.
> > However if the property is missing or zero sized, then there is
> > no fallback of any kind and the PCI resources remain undiscovered, i.e.
> > pdev->resource[] array is empty.
> > 
> > This adds a fallback which parses the "reg" property in pretty much same
> > way except it marks resources as "unset" which later makes Linux assign
> > those resources with proper addresses.
> 
> What happens under PowerVM is the big question.
> 
> ie. if we see such a device under PowerVM and then do our own assignment
> what happens?

May or may not work ... EEH will be probably b0rked, but then it
shouldn't happen.

Basically PowerVM itself doesn't do anything special with PCI. It maps
a whole PHB (or virtual PHB) into the guest and doesn't care much
beyond that for MMIOs.

What you see in Linux getting in the way is RTAS. It's the one
assigning BAR values etc... within that region setup by the HV, but
RTAS is running in the guest, from the HV perspective it's all the same
really.

So if such a device did exist, RTAS would lose track but it would still
work from a HW/HV perspective. RTAS-driven services such as EEH would
probably fail though.

But in practice this shouldn't happen bcs RTAS will set assigned-
addresses on everything.

Cheers,
Ben.
 

