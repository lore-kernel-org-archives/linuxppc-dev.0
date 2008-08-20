Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07E2BDE91C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 05:18:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KJIsiD025634
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 15:18:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KJInhs089824
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:18:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KJInrJ029228
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:18:49 -0600
Date: Wed, 20 Aug 2008 15:18:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Message-ID: <20080820151848.69cb8f16@zod.rchland.ibm.com>
In-Reply-To: <1219259211.14362.94.camel@localhost.localdomain>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
	<48AC13E5.5010503@linux.vnet.ibm.com>
	<1219257000.14362.90.camel@localhost.localdomain>
	<1219258333.26429.29.camel@jdub.homelinux.org>
	<1219259211.14362.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 20 Aug 2008 14:06:51 -0500
Hollis Blanchard <hollisb@us.ibm.com> wrote:  
> > > > To be honest I unfortunately don't know how big the impact for 
> > > > non-virtualized systems is. I would like to test it, but without 
> > > > hardware performance counters on the core I have I'm not sure (yet)
> > > > how 
> > > > to measure that in a good way - any suggestion welcome.
> > > 
> > > I don't see why we need performance counters. Can't we just compare any
> > > bare metal benchmark results with the patch both applied and not?
> > 
> > Do you know of one that causes a large amount of
> > local_irq_{disable,enable}s to be called?
> 
> I think *every* workload causes a large number of
> local_irq_{disable,enable} calls... :)

Well, sure.  I was just going for "test the change as specifically as
possible."  One could write a module that did X number of
disable/enable pairs and reported the timebase at start and end to
compare.  X could even be a module parameter.  Just to try and
eliminate noise or whatever from the testing.

/me shrugs.

josh
