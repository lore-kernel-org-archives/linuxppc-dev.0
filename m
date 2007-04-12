Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AB60DE018
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 03:12:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l3CHALaj006452
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:10:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CHCpjb138536
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 11:12:51 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CHCoso004422
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 11:12:51 -0600
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2830816F-F1C5-450C-BA68-287D8C312561@kernel.crashing.org>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
	<2830816F-F1C5-450C-BA68-287D8C312561@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 12:11:46 -0500
Message-Id: <1176397906.6379.77.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 12:06 -0500, Kumar Gala wrote:
> On Apr 12, 2007, at 11:41 AM, Segher Boessenkool wrote:
> 
> >> PowerPC 750CL has high BATs.  The patch below sets cpu_features to
> >> match that.
> >> Without it, the original firmware mappings in the high BATs aren't
> >> cleared
> >> which can cause "odd" address translations to occur.
> >
> >> -		.cpu_features		= CPU_FTRS_750,
> >> +		.cpu_features		= CPU_FTRS_750GX,
> >
> > The difference between these two is
> >
> > #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX |  
> > CPU_FTR_HAS_HIGH_BATS)
> > #define CPU_FTRS_750    (CPU_FTR_COMMON)
> >
> > 750GX excludes COMMON, which seems like a bug.  With
> > your change, 750CL uses DUAL_PLL_750FX; does it actually
> > have that feature?
> 
> I agree the 750GX should include COMMON, we probably don't notice  
> since its never in a SMP system.

I'll send a separate patch to fix that.

josh
