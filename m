Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRry40q7ZzDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 10:00:43 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78Nx56w061716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 20:00:40 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c7kkga1pm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 20:00:40 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 20:00:40 -0400
Date: Tue, 8 Aug 2017 17:00:34 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: xive: ensure active irqd when setting affinity
References: <20170803013822.GD28905@us.ibm.com>
 <87zibamjfi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zibamjfi.fsf@concordia.ellerman.id.au>
Message-Id: <20170809000034.GB17162@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > From fd0abf5c61b6041fdb75296e8580b86dc91d08d6 Mon Sep 17 00:00:00 2001
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Tue, 1 Aug 2017 20:54:41 -0500
> > Subject: [PATCH] powerpc: xive: ensure active irqd when setting affinity
> >
> > Ensure irqd is active before attempting to set affinity. This should
> > make the set affinity code more robust. For instance, this prevents
> > these messages seen on a 4.12 based kernel when taking cpus offline:
> >
> >    [  123.053037264,3] XIVE[ IC 00  ] ISN 2 lead to invalid IVE !
> >    [   77.885859] xive: Error -6 reconfiguring irq 17
> >    [   77.885862] IRQ17: set affinity failed(-6).
> >
> > The underlying problem with taking cpus offline was fixed in 4.13-rc1 by:
> >
> >    commit 91f26cb4cd3c ("genirq/cpuhotplug: Do not migrated shutdown irqs")
> 
> So do we still need this? Or is the above only a partial fix?

It would be good to have this fix.

Commit 91f26cb4cd3c fixes the problem, so we wont see the errors with
that commit applied. But if such a problem were to show up again, xive
will handle them earlier before hitting those errors.

Sukadev

> 
> I'm a bit confused.
> 
> cheers
