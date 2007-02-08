Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 042E6DDE41
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 08:20:16 +1100 (EST)
Subject: Re: [PATCH] Celleb: improve htab lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200702080751.45278.arnd@arndb.de>
References: <200702080618.l186InGM014774@toshiba.co.jp>
	<200702080751.45278.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 08:20:05 +1100
Message-Id: <1170969605.2620.340.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 07:51 +0100, Arnd Bergmann wrote:
> On Thursday 08 February 2007 07:18, Ishizaki Kou wrote:
> > s);
> > +       local_irq_save(flags);
> > +       spin_lock(&beat_htab_lock);
> >         dummy1 = beat_lpar_hpte_getword0(slot);
> >  
> >         if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
> >                 DBG_LOW("not found !\n");
> > -               spin_unlock_irqrestore(&beat_htab_lock, flags);
> > +               spin_unlock(&beat_htab_lock);
> > +               local_irq_restore(flags);
> >                 return;
> >         }
> >  
> >         lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
> >                 &dummy1, &dummy2);
> > -       spin_unlock_irqrestore(&beat_htab_lock, flags);
> > +       spin_unlock(&beat_htab_lock);
> > +       local_irq_restore(flags);
> 
> The function normally used here would be spin_lock_irq()/spin_unlock_irq(),
> which does spin_{,un}lock along with local_irq_{save,restore}.

Not lock_irq/unlock_irq, that doesn't save/restore but disables/enables
(that is doesn't save the previous state).

I'd rather have him use _irqsave/irqrestore, that is, keep the current
code in that function.

Ben.
