Return-Path: <vgoyal@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 007F6DDEFF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 17:06:38 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2766ZGO027909
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 01:06:35 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2766ZqC119020
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 23:06:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2766YI2009163
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 23:06:35 -0700
Date: Wed, 7 Mar 2007 11:36:23 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070307060623.GA5469@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
Reply-To: vgoyal@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2007 at 03:16:55PM +0100, Michael Ellerman wrote:
> On Tue, 2007-03-06 at 19:27 +0530, Mohan Kumar M wrote:
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
> 
> First, I don't know why we keep telling people to use maxcpus=1 for
> kexec/kdump - it's causing bugs, and I don't know of any that it fixes?
> 

Logically speaking, there is no need to bring up all the cpus in the
system to capture the dump. A single cpu can do the job, may be in
relatively lesser memory. Just because we see bugs with maxcpus=1, does
not mean we should try to bring up all the cpus in second kernel. I think
we should try to clean maxcpus=1 path instead.

Thanks
Vivek
