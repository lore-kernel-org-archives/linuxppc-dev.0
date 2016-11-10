Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFGSK6rzqzDrBy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:30:57 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAALTDpv144181
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 16:30:56 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mschtrgn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 16:30:55 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 11 Nov 2016 07:30:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F1F0A2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:30:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAALUnxV23527530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:30:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAALUn34018575
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:30:49 +1100
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Mark Rutland <mark.rutland@arm.com>, "Guilherme G. Piccoli"
 <gpiccoli@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com, frowand.list@gmail.com,
 robh+dt@kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 11 Nov 2016 08:30:43 +1100
In-Reply-To: <20161109190457.GC837@leverpostej>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161109190457.GC837@leverpostej>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478813443.2592.2.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-09 at 19:04 +0000, Mark Rutland wrote:
> 
> 
> If we don't have an interrupt-map on a PCI controller, why don't we
> instead log a message regarding that being missing, and give up
> early?

Why ? It's legit to not support LSIs.

> That sounds like a more generically useful error message; it's also
> possible that a DT author simply forgot to add the map, and the
> platform has suitable interrupts wired up.

But it's not necessarily an error...

> > This patch introduces a different message for this specific case,
> > and it also reduces the level of the message from error to warning.
> > Before this patch, when an adapter was plugged in a slot without
> Level
> > interrupts capabilities, we saw generic error messages like this:
> > 
> >     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-
> 22
> > 
> > Now, with this applied, we see the following specific message:
> > 
> >     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot
> of this
> >     device has no Level-triggered Interrupts capability.
> 
> Following my above example, this has gone from opaque to potentially
> misleading

I'm not sure. At least for some of our platforms this is the correct
message :-) Our Hypervisor doesn't allow LSIs on some slots.

I think it's not that misleading. It's obvious something is wrong with
LSIs, which you can easily figure out from there.

Cheers,
Ben.
