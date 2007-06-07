Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33D81DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 12:54:17 +1000 (EST)
Subject: Re: [patch 08/18] PS3: Kexec support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1181183468.4166.5.camel@concordia.ozlabs.ibm.com>
References: <20070606024407.786638029@am.sony.com> >
	<4666233F.1080103@am.sony.com>
	<1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
	<46672D34.8010808@am.sony.com>
	<1181183468.4166.5.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 12:54:06 +1000
Message-Id: <1181184846.31677.277.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 12:31 +1000, Michael Ellerman wrote:
> > >> +  pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__,
> pd->cpu, virq);
> > >> +
> > >> +  local_irq_save(flags);
> > >> +  asm volatile(
> > >> +               "1:        ldarx %0,0,%3\n"
> > >> +               "andc      %0,%0,%2\n"
> > >> +               "stdcx.    %0,0,%3\n"
> > >> +               "bne-      1b"
> > >> +               : "=&r" (old), "+m" (*p)
> > >> +               : "r" (bit), "r" (p)
> > >> +               : "cc" );
> > >> +
> > >> +  lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> > >> +  local_irq_restore(flags);
> > > 
> > > How is this different from set_bit() ?  (asm-powerpc/bitops.h)
> > > 
> > > ps. now that I see you're just moving this code around someone's
> > > probably already asked that question. 

Actually the above is clear_bit :-)

That would thus be something around the lines of:

 clear_bit(&pd->bmp.mask, 63 - virq);

Geoff, feel free to replace it with the clear_bit if you think it's
nicer that way :-) (and double check I didn't smoke crack when doing
the above conversion).

The other one in unmask would be set_bit() of course.

Ben.
