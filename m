Return-Path: <mohan@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FEDEDDEED
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 04:41:51 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l26Hfk2R014481
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 12:41:46 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l26He0fm266442
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 12:40:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l26He0L4025997
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 12:40:00 -0500
Received: from explorer.in.ibm.com ([9.124.96.40])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l26Hdwih025888
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 12:39:59 -0500
Received: from explorer.in.ibm.com (explorer.in.ibm.com [127.0.0.1])
	by explorer.in.ibm.com (Postfix) with ESMTP id 12245282FDC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 23:09:42 +0530 (IST)
Received: (from mohan@localhost)
	by explorer.in.ibm.com (8.13.5/8.13.5/Submit) id l26Hdfui032253
	for linuxppc-dev@ozlabs.org; Tue, 6 Mar 2007 23:09:41 +0530
Date: Tue, 6 Mar 2007 23:09:41 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Clearing the interrupt
Message-ID: <20070306173941.GE7476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I would like to get some suggestions to implement the interrupt clearing
methods in kdump kernel.

After a panic situation, first kernel goes through each irq_desc
structure and if any interrupt is in progress, it calls eoi handler for
that interrupt. eoi handler is called from the crashing cpu context.

	for_each_irq(irq) {
		struct irq_desc *desc = irq_desc + irq;

		if (desc->status & IRQ_INPROGRESS)
			desc->chip->eoi(irq);

		if (!(desc->status & IRQ_DISABLED))
			desc->chip->disable(irq);
	}


But initially some another cpu might have acknowledged the interrupt and
started processing the interrupt. But eoi handler may not be called by
the cpu which acknowledged the interrupt.

Is there any problem with the above approach? Is there any restriction
such that a cpu which acknowledged the interrupt only should send the eoi
signal?

Regards,
Mohan.
