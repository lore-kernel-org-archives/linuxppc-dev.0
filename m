Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BACDDDED1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 19:53:16 +1100 (EST)
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070306220546.GI24926@localdomain>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com> <20070306135754.GB7476@in.ibm.com>
	<20070306220546.GI24926@localdomain>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 09:52:47 +0100
Message-Id: <1173257567.9349.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-06 at 16:05 -0600, Nathan Lynch wrote:
> Mohan Kumar M wrote:
> > Hi,
> > 
> > Here comes the revised version of patch to fix the interrupt missing
> > problem when a kdump kernel is booted with "maxcpus=1" kernel parameter.
> > 
> > In the xics initialization code a check is made to detemine whether
> > maxcpus kernel parameter is present and if its present then
> > default_distrib_server variable is initialized to the current boot cpu
> > id (by default_server variable). So that when ever a kernel is booted
> > with maxcpus kernel parameter all interrupts are routed to the boot cpu
> > only.
> > 
> > Tested on POWER5 and JS20 systems.
> > 
> > Any comment?
> 
> Was the root cause of this problem ever determined?  It sure looked
> like a firmware or hardware problem since it's known to occur only on
> JS20.

js20 and js21 have in common that the firmware "emulates" the XICS on
top of an MPIC, which can cause interesting issues ... like the
requirement of issuing EOI's from the CPU that got the interrupt, among
ohters.

Ben.
