Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3C359B7B76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 08:29:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95934DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2009 08:29:13 +1000 (EST)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
	<2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
	<6FD94305-B60D-4DAF-8296-88345D11187F@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 01 Aug 2009 08:29:02 +1000
Message-Id: <1249079342.1509.99.camel@pasglop>
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

On Thu, 2009-07-30 at 22:35 -0500, Kumar Gala wrote:
> >               /* XXX This clear should ultimately be part of
> local_flush_tlb_mm */
> > -             __clear_bit(id, stale_map[cpu]);
> > +             for (cpu = cpu_first_thread_in_core(cpu);
> > +                  cpu <= cpu_last_thread_in_core(cpu); cpu++)
> > +                     __clear_bit(id, stale_map[cpu]);
> >       }
> 
> This looks a bit dodgy.  using 'cpu' as both the loop variable and  
> what you are computing to determine loop start/end..
> 
Hrm... I would have thought that it was still correct... do you see any
reason why the above code is wrong ? because if not we may be hitting a
gcc issue...

IE. At loop init, cpu gets clamped down to the first thread in the core,
which should be fine. Then, we compare CPU to the last thread in core
for the current CPU which should always return the same value.

So I'm very interested to know what is actually wrong, ie, either I'm
just missing something obvious, or you are just pushing a bug under the
carpet which could come back and bit us later :-)

Cheers,
Ben.
