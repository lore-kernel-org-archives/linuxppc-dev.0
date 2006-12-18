Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B40D767C97
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 21:57:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBIAvCYS032722
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 05:57:12 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBIAvCQG365192
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 03:57:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBIAvBmm011793
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 03:57:12 -0700
Date: Mon, 18 Dec 2006 16:27:06 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20061218105706.GB3911@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17798.6928.378248.28903@cargo.ozlabs.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2006 at 03:37:36PM +1100, Paul Mackerras wrote:
> Mohan Kumar M writes:
> 
> > To overcome this problem, I have created the patch, which
> > checks for the condition if the machine is ppc970 based and maxcpus
> > kernel parameter is specified. If the condition is met, the default
> > distribution server is assigned to be current boot cpu instead of
> > assigning from the gserver#s property.
> 
> It feels hacky to be basing this sort of thing on the PVR.  I would
> like to understand the real problem better.  Is it that we are
> sometimes setting default_distrib_server to point to a CPU which is
> not running?  If so, why and how?

At the time of kexec/kdump shutdown sequence all secondary processors
are removed from the Global Interrupt Queue by calling the corresponding
rtas-set-indicator call. So even though default_distrib_server is 0xff
PIC should distribute the interrupts only to the processors available in
GIQ (please correct me if I am wrong), but its not happening in our
JS20 box. Our JS20 firmware version is FW04310120 dated 07/26/04.

> Is this something that is specific
> to the firmware on IBM 970-based blade systems?  Is there in fact a
> firmware bug that this works around?

Looks like a firmware bug, since I am not able to reproduce this problem
on a JS21 box with the firmware version MB240_470 dated 03/23/2006. I am
planning to upgrade JS20 with latest firmware and test with maxcpus=1

> Why don't we see it on non-970
> based systems?

I have seen secondary thread related interrupt distribution problems on
POWER5 boxes and I fixed it sometime back. Since POWER4 does not have
SMT there is no interrupt distribution problem.

> 
> Paul.
