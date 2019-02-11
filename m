Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D73C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:46:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C5206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 06:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C5206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ybsL3G9LzDqMl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ybqS1N0VzDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 17:44:19 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1B6gq8s017096;
 Mon, 11 Feb 2019 00:42:54 -0600
Message-ID: <9dc53c6bccd6fd303481217f768ec173992431e2.camel@kernel.crashing.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?=
 Le Goater <clg@kaod.org>
Date: Mon, 11 Feb 2019 17:42:52 +1100
In-Reply-To: <20190211023842.GE7230@umbus.fritz.box>
References: <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
 <20190208051523.GD2688@umbus.fritz.box>
 <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
 <20190208215329.GA9529@blackberry>
 <8c915ed7-5aa5-1276-6598-d5dcd115dd56@kaod.org>
 <20190211023842.GE7230@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-11 at 13:38 +1100, David Gibson wrote:
> 
> 1) All in kernel
> 
> The offset always maps directly to guest irq number and the kernel
> somehow binds it either to an IPI or a host irq as necessary.
> Cédric's original code attempts this, but the mechanism of keeping a
> pointer to the VMA can't work.

Why do you need a pointer to the VMA anyway ? unmap_mapping_range()
doesn't need a VMA for the unmap part, and faults/mmaps have the VMA.

> But.. remapping the irqs should be sufficiently infrequent that it
> might be ok to consider simply stepping through all the hosting
> process's VMAs to do this.

Which unmap_mapping_range() does for you as I explained previously. You
only need the address space. See how spufs does it (among others).

> 2) Remapped in qemu (using memory regions)
> 
> I _think_ (in hindsight) was Cédric's been discussing as the
> alternative in more recent posts.
> 
> Qemu maps the IPI pages at one place and the passthrough IRQ pages
> somewhere else.  The IPIs are mapped into the guest as one memory
> region, then any passthrough IRQ pages are mapped over that using
> overlapping memory regions.
> 
> I don't think this approach will work well, because it could require a
> bunch of separate KVM memory slots, which are fairly scarce.
> 
> 3) Remapped in qemu (using mmap())
> 
> This is the approach I (and I think Paul) have been suggested in
> contrast to (1).
> 
> Qemu maps the IPI pages and maps those into the guest.  When we need
> to set up a passthrough IRQ, qemu mmap()s its pages directly over the
> IPI pages, and it remains mapped into the guest with the same memory
> region / memslot as the IPIs are already using.  If the passthrough
> device is removed we have to remap the IPI pages back into place.
> 
> 4) Dedicated irq numbers
> 
> We never re-use regular guest irq numbers for passthrough irqs,
> instead we put them somewhere else and keep those mapped to the
> passthrough irq pages.
> 
> I was favouring this approach, but it does mean there will be a guest
> visible difference between kernel_irqchip=on and off which isn't
> great.
> 
> 
> (1) is the most elegant _interface_, but as we've seen it's
> problematic to implement.  Looking at the for_all_vmas() approach
> could be interesting, but otherwise option (3) might be the most
> practical.
> 
> --

