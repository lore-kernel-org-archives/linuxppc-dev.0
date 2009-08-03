Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07D1AB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 03:06:48 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69839DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 03:06:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73HAODv028357
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:10:24 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73H6dPh240476
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:06:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73H6cKO003285
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:06:39 -0400
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2EA75185-AC33-4BCA-AE53-A60E6D98DC46@kernel.crashing.org>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop>	<1249265010.5516.31.camel@concordia>
	<2EA75185-AC33-4BCA-AE53-A60E6D98DC46@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 12:06:37 -0500
Message-Id: <1249319197.6192.3.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-03 at 11:21 -0500, Kumar Gala wrote:
> On Aug 2, 2009, at 9:03 PM, Michael Ellerman wrote:
> 
> > On Sat, 2009-08-01 at 08:29 +1000, Benjamin Herrenschmidt wrote:
> >> On Thu, 2009-07-30 at 22:35 -0500, Kumar Gala wrote:
> >>>>              /* XXX This clear should ultimately be part of
> >>> local_flush_tlb_mm */
> >>>> -             __clear_bit(id, stale_map[cpu]);
> >>>> +             for (cpu = cpu_first_thread_in_core(cpu);
> >>>> +                  cpu <= cpu_last_thread_in_core(cpu); cpu++)
> >>>> +                     __clear_bit(id, stale_map[cpu]);
> >>>>      }
> >>>
> >>> This looks a bit dodgy.  using 'cpu' as both the loop variable and
> >>> what you are computing to determine loop start/end..
> >>>
> >> Hrm... I would have thought that it was still correct... do you see  
> >> any
> >> reason why the above code is wrong ? because if not we may be  
> >> hitting a
> >> gcc issue...
> >>
> >> IE. At loop init, cpu gets clamped down to the first thread in the  
> >> core,
> >> which should be fine. Then, we compare CPU to the last thread in core
> >> for the current CPU which should always return the same value.
> >>
> >> So I'm very interested to know what is actually wrong, ie, either I'm
> >> just missing something obvious, or you are just pushing a bug under  
> >> the
> >> carpet which could come back and bit us later :-)
> >
> > for (cpu = cpu_first_thread_in_core(cpu);
> >     cpu <= cpu_last_thread_in_core(cpu); cpu++)
> >        __clear_bit(id, stale_map[cpu]);
> >
> > ==
> >
> > cpu = cpu_first_thread_in_core(cpu);
> > while (cpu <= cpu_last_thread_in_core(cpu)) {
> > 	__clear_bit(id, stale_map[cpu]);
> > 	cpu++;
> > }

cpu_last_thread_in_core(cpu) is a moving target.  You want something
like:

cpu = cpu_first_thread_in_core(cpu);
last = cpu_last_thread_in_core(cpu);
while (cpu <= last) {
	__clear_bit(id, stale_map[cpu]);
	cpu++;
}

> >
> > cpu = 0
> > cpu <= 1
> > cpu++ (1)
> > cpu <= 1
> > cpu++ (2)
> > cpu <= 3
> > ...
> 
> Which is pretty much what I see, in a dual core setup, I get an oops  
> because we are trying to clear cpu #2 (which clearly doesn't exist)
> 
> cpu = 1
> (in loop)
> 	clearing 1
> 	clearing 2
> OOPS
> 
> - k

-- 
David Kleikamp
IBM Linux Technology Center
