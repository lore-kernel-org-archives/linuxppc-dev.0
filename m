Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D786FDE9E2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 05:07:01 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KJ6snL016555
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 15:06:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KJ6rqs1839114
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 15:06:53 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KJ6qJB017504
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:06:52 -0600
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
From: Hollis Blanchard <hollisb@us.ibm.com>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1219258333.26429.29.camel@jdub.homelinux.org>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
	<48AC13E5.5010503@linux.vnet.ibm.com>
	<1219257000.14362.90.camel@localhost.localdomain>
	<1219258333.26429.29.camel@jdub.homelinux.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 14:06:51 -0500
Message-Id: <1219259211.14362.94.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 14:52 -0400, Josh Boyer wrote:
> On Wed, 2008-08-20 at 13:30 -0500, Hollis Blanchard wrote:
> > On Wed, 2008-08-20 at 14:53 +0200, Christian Ehrhardt wrote:
> > > 
> > > Arnd Bergmann wrote:
> > > > On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
> > > >   
> > > >> Dependent on the already existing CONFIG_KVM_GUEST config option
> > > this patch
> > > >> changes wrteei to wrtee allowing the hypervisor to rewrite those to
> > > nontrapping
> > > >> instructions. Maybe we should split the kvm guest otpimizations in
> > > two parts
> > > >> one for the overhead free optimizations and on for the rest that
> > > might add
> > > >> some complexity for non virtualized execution (like this one).
> > > >>
> > > >> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> > > >>     
> > > >
> > > > How significant is the performance impact of this change for
> > > non-virtualized
> > > > systems? If it's very low, maybe you should not bother with the
> > > #ifdef, and
> > > > if it's noticable, you might be better off using dynamic patching
> > > for this.
> > > >
> > > >       Arnd <><
> > > >   
> > > To be honest I unfortunately don't know how big the impact for 
> > > non-virtualized systems is. I would like to test it, but without 
> > > hardware performance counters on the core I have I'm not sure (yet)
> > > how 
> > > to measure that in a good way - any suggestion welcome.
> > 
> > I don't see why we need performance counters. Can't we just compare any
> > bare metal benchmark results with the patch both applied and not?
> 
> Do you know of one that causes a large amount of
> local_irq_{disable,enable}s to be called?

I think *every* workload causes a large number of
local_irq_{disable,enable} calls... :)

-- 
Hollis Blanchard
IBM Linux Technology Center
