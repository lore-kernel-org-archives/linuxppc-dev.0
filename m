Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFqLF4tyhzDvj2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 06:12:36 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABJ9DI5056796
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 14:12:34 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nk8b302k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 14:12:34 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 12 Nov 2016 05:12:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AE7E43578057
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 06:12:29 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uABJCTTA23986370
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 06:12:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uABJCSWA025571
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 06:12:29 +1100
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, "Guilherme G. Piccoli"
 <gpiccoli@linux.vnet.ibm.com>,
 marc.zyngier@arm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, frowand.list@gmail.com
Date: Sat, 12 Nov 2016 06:12:27 +1100
In-Reply-To: <20161111163241.GL11945@leverpostej>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161109190457.GC837@leverpostej> <1478813443.2592.2.camel@au1.ibm.com>
 <20161111163241.GL11945@leverpostej>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478891547.2592.13.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-11 at 16:32 +0000, Mark Rutland wrote:
> On Fri, Nov 11, 2016 at 08:30:43AM +1100, Benjamin Herrenschmidt
> wrote:
> > 
> > On Wed, 2016-11-09 at 19:04 +0000, Mark Rutland wrote:
> > > 
> > > 
> > > If we don't have an interrupt-map on a PCI controller, why don't
> > > we
> > > instead log a message regarding that being missing, and give up
> > > early?
> > 
> > Why ? It's legit to not support LSIs.
> 
> Sure; I had envisioned a message like:
> 
> 	pr_info("%s: no interrupt-map, INTx interrupts not possible\n",
> 		pci_controller_name);
> 
> ... Which tells the user exaclty what we know, and doesn't imply
> either
> an error or the actual absence of HW support.

Works for me.

Cheers,
Ben.
