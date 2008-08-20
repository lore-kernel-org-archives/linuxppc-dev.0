Return-Path: <hollisb@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08A43DE621
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 04:30:07 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KIU3lO010316
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 14:30:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KIU1EQ209544
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 12:30:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KIU06J029582
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 12:30:01 -0600
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <48AC13E5.5010503@linux.vnet.ibm.com>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
	<48AC13E5.5010503@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 13:30:00 -0500
Message-Id: <1219257000.14362.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 14:53 +0200, Christian Ehrhardt wrote:
> 
> Arnd Bergmann wrote:
> > On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
> >   
> >> Dependent on the already existing CONFIG_KVM_GUEST config option
> this patch
> >> changes wrteei to wrtee allowing the hypervisor to rewrite those to
> nontrapping
> >> instructions. Maybe we should split the kvm guest otpimizations in
> two parts
> >> one for the overhead free optimizations and on for the rest that
> might add
> >> some complexity for non virtualized execution (like this one).
> >>
> >> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> >>     
> >
> > How significant is the performance impact of this change for
> non-virtualized
> > systems? If it's very low, maybe you should not bother with the
> #ifdef, and
> > if it's noticable, you might be better off using dynamic patching
> for this.
> >
> >       Arnd <><
> >   
> To be honest I unfortunately don't know how big the impact for 
> non-virtualized systems is. I would like to test it, but without 
> hardware performance counters on the core I have I'm not sure (yet)
> how 
> to measure that in a good way - any suggestion welcome.

I don't see why we need performance counters. Can't we just compare any
bare metal benchmark results with the patch both applied and not?

-- 
Hollis Blanchard
IBM Linux Technology Center
