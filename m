Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E174DDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:42:21 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l02BgEUV027956
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 06:42:14 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l02BgEJG511436
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 04:42:14 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l02BgE6f030191
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 04:42:14 -0700
Date: Tue, 2 Jan 2007 17:12:12 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Fastboot] [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070102114212.GA4019@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061218105706.GB3911@in.ibm.com>
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

On Mon, Dec 18, 2006 at 04:27:06PM +0530, Mohan Kumar M wrote:
> On Mon, Dec 18, 2006 at 03:37:36PM +1100, Paul Mackerras wrote:
> > 
> > It feels hacky to be basing this sort of thing on the PVR.  I would
> > like to understand the real problem better.  Is it that we are
> > sometimes setting default_distrib_server to point to a CPU which is
> > not running?  If so, why and how?
> 
> At the time of kexec/kdump shutdown sequence all secondary processors
> are removed from the Global Interrupt Queue by calling the corresponding
> rtas-set-indicator call. So even though default_distrib_server is 0xff
> PIC should distribute the interrupts only to the processors available in
> GIQ (please correct me if I am wrong), but its not happening in our
> JS20 box. Our JS20 firmware version is FW04310120 dated 07/26/04.
>
> > Is this something that is specific
> > to the firmware on IBM 970-based blade systems?  Is there in fact a
> > firmware bug that this works around?
> 
> Looks like a firmware bug, since I am not able to reproduce this problem
> on a JS21 box with the firmware version MB240_470 dated 03/23/2006. I am
> planning to upgrade JS20 with latest firmware and test with maxcpus=1
>

Even after updating the JS20 box with the latest firmware FW06470160
dated 11/21/06, we are facing the same problems with "maxcpus=1" kernel
parameter. As mentioned earlier, we do not have this problem on JS21
hardware. JS20 has PPC970 cpus while JS21 has PPC970MP cpus. Could it be
a reason? Still we are not able to conclude whether it is related to
firmware or not.

Paul, can you tell us which approach we can follow to solve this
problem? The patch I have sent earlier was hackish. So do we need to use
"noirqdistrib" kernel parameter in addition to "maxcpus=1" to avoid
these problems?

Mohan.

 
> > Why don't we see it on non-970
> > based systems?
> 
> I have seen secondary thread related interrupt distribution problems on
> POWER5 boxes and I fixed it sometime back. Since POWER4 does not have
> SMT there is no interrupt distribution problem.
> 
> > 
> > Paul.
