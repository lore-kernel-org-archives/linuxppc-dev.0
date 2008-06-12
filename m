Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FF63DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 17:25:53 +1000 (EST)
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts, trigger
	EOI to reenable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 17:23:15 +1000
Message-Id: <1213255395.14478.28.camel@pasglop>
Mime-Version: 1.0
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, general@lists.openfabrics.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-10 at 16:44 +0200, Stefan Roscher wrote:
> During corner case testing, we noticed that some versions of ehca 
> do not properly transition to interrupt done in special load situations.
> This can be resolved by periodically triggering EOI through H_EOI, 
> if eqes are pending.
> 
> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>

This patch is fine with me as long as the FW/HW people can confirm that
calling spurrious EOI's like that will not affect other interrupts.

The side effect of writing 0xff to the xirr should be irrelevant as long as
this is not done from within a HW interrupt handler (timer interrupts or
softirqs are fine).

Due to the already incestuous relationship between HCA and the hypervisor,
I don't mind having the H call directly in the driver.

So as long as the FW/HW people are ok with that workaround, then it has
my ack as well.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
