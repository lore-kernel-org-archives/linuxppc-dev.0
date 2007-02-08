Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 626D8DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 07:28:08 +1100 (EST)
Date: Thu, 8 Feb 2007 21:28:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Celleb: improve htab lock
Message-ID: <20070208202802.GA2579@lst.de>
References: <200702080618.l186InGM014774@toshiba.co.jp>
	<200702080751.45278.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702080751.45278.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2007 at 07:51:44AM +0100, Arnd Bergmann wrote:
> On Thursday 08 February 2007 07:18, Ishizaki Kou wrote:
> > s);
> > +???????local_irq_save(flags);
> > +???????spin_lock(&beat_htab_lock);
> > ????????dummy1 = beat_lpar_hpte_getword0(slot);
> > ?
> > ????????if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
> > ????????????????DBG_LOW("not found !\n");
> > -???????????????spin_unlock_irqrestore(&beat_htab_lock, flags);
> > +???????????????spin_unlock(&beat_htab_lock);
> > +???????????????local_irq_restore(flags);
> > ????????????????return;
> > ????????}
> > ?
> > ????????lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
> > ????????????????&dummy1, &dummy2);
> > -???????spin_unlock_irqrestore(&beat_htab_lock, flags);
> > +???????spin_unlock(&beat_htab_lock);
> > +???????local_irq_restore(flags);
> 
> The function normally used here would be spin_lock_irq()/spin_unlock_irq(),
> which does spin_{,un}lock along with local_irq_{save,restore}.

But I think the issue here is that we don't want to disable irqs because
we want to protect against IRQ context, but rather because the
hypervisor expects it.  Using the separate routines makes this a little
cleaner.  Then again a comment explaining why we do it in addition to
the separate routines would be even better.  And if this is really the
case doing the disabling inside the spinlock might be more explanative
and reduces the irq disabling time.  Also if we're sure that this is
always called from process context and with irqs enabled we should
be using local_irq_disable/local_irq_enable and avoid saving the
flags word.
