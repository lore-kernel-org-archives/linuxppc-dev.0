Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20188DDFF8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 07:53:05 +1000 (EST)
Subject: Re: PS3 early lock-up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1217886287.24157.87.camel@pasglop>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
	<1217886287.24157.87.camel@pasglop>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 07:52:57 +1000
Message-Id: <1217886777.24157.91.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > ps3_hpte_insert() seems to be called during system initialization with the
> > following values of rflags:
> >   - first call: 0x190
> >   - initial memory: 0x194 (455 times)
> >   - hotplug memory:
> >       o crash: 0x115
> >       o OK: 0x117
> > 
> > Do you have an idea of what's really going on?
> 
> Weird... Both look incorrect. In fact, it's a bit scary...
> 
> The one with the 7 at the end means that user space as RO access to
> the segment (oops !) and supervisor too. The one with the 5 means
> RO for user and RW for supervisor.
> 
> That is unless your HV is munging them in strange ways... I don't
> know why LV1 is refusing a combination though.
> 
> As for the flags, it depends what htab_bolt_mapping() is called
> with.
> 
> Do you have a backtrace ? I'm a bit lots in the mem hotswap code
> trying to figure out where the mapping comes from..

Ah, found it... It should be ok... both the mapping of the RAM itself
and vmemmap_populate() should be passing 

  _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;

Which should be 0x194.

Can you find out where that stupid value comes from ?

Ben.
