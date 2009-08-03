Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D87CB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 03:57:53 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86156DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 03:57:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73HqAHV029672
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:52:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73HvkF2057216
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:57:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73HvkM3022715
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Aug 2009 13:57:46 -0400
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1249319197.6192.3.camel@norville.austin.ibm.com>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop>	<1249265010.5516.31.camel@concordia>
	<2EA75185-AC33-4BCA-AE53-A60E6D98DC46@kernel.crashing.org>
	<1249319197.6192.3.camel@norville.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 12:57:45 -0500
Message-Id: <1249322265.6192.5.camel@norville.austin.ibm.com>
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

On Mon, 2009-08-03 at 12:06 -0500, Dave Kleikamp wrote:
> On Mon, 2009-08-03 at 11:21 -0500, Kumar Gala wrote:
> > On Aug 2, 2009, at 9:03 PM, Michael Ellerman wrote:
> > 

> > > for (cpu = cpu_first_thread_in_core(cpu);
> > >     cpu <= cpu_last_thread_in_core(cpu); cpu++)
> > >        __clear_bit(id, stale_map[cpu]);
> > >
> > > ==
> > >
> > > cpu = cpu_first_thread_in_core(cpu);
> > > while (cpu <= cpu_last_thread_in_core(cpu)) {
> > > 	__clear_bit(id, stale_map[cpu]);
> > > 	cpu++;
> > > }
> 
> cpu_last_thread_in_core(cpu) is a moving target.  You want something
> like:
> 
> cpu = cpu_first_thread_in_core(cpu);
> last = cpu_last_thread_in_core(cpu);
> while (cpu <= last) {
> 	__clear_bit(id, stale_map[cpu]);
> 	cpu++;
> }

Or, keeping the for loop:

for (cpu = cpu_first_thread_in_core(cpu), last =
cpu_last_thread_in_core(cpu);
     cpu <= last; cpu++)
	cpu++;

> 
> > >
> > > cpu = 0
> > > cpu <= 1
> > > cpu++ (1)
> > > cpu <= 1
> > > cpu++ (2)
> > > cpu <= 3
> > > ...
> > 
> > Which is pretty much what I see, in a dual core setup, I get an oops  
> > because we are trying to clear cpu #2 (which clearly doesn't exist)
> > 
> > cpu = 1
> > (in loop)
> > 	clearing 1
> > 	clearing 2
> > OOPS
> > 
> > - k
> 
-- 
David Kleikamp
IBM Linux Technology Center
