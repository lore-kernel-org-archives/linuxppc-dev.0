Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B3DA8B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 17:22:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11194DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 17:22:47 +1000 (EST)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1249322265.6192.5.camel@norville.austin.ibm.com>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
	<1249079342.1509.99.camel@pasglop>	<1249265010.5516.31.camel@concordia>
	<2EA75185-AC33-4BCA-AE53-A60E6D98DC46@kernel.crashing.org>
	<1249319197.6192.3.camel@norville.austin.ibm.com>
	<1249322265.6192.5.camel@norville.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 17:22:36 +1000
Message-Id: <1249370556.18245.35.camel@pasglop>
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

On Mon, 2009-08-03 at 12:57 -0500, Dave Kleikamp wrote:
> > cpu_last_thread_in_core(cpu) is a moving target.  You want something
> > like:
> > 
> > cpu = cpu_first_thread_in_core(cpu);
> > last = cpu_last_thread_in_core(cpu);
> > while (cpu <= last) {
> >       __clear_bit(id, stale_map[cpu]);
> >       cpu++;
> > }
> 
> Or, keeping the for loop:
> 
> for (cpu = cpu_first_thread_in_core(cpu), last =
> cpu_last_thread_in_core(cpu);
>      cpu <= last; cpu++)
>         cpu++;

Yeah, whatever form is good, I had a brain fart and didn't "see" that in
the end of loop, cpu would have actually crossed the boundary to the
next core and so cpu_last_thread_in_core() would change. Just some short
circuit in a neuron somewhere.

Cheers,
Ben.
