Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98BA7DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 18:53:07 +1100 (EST)
Date: Thu, 18 Jan 2007 16:52:37 +0900 (JST)
Message-Id: <200701180752.l0I7qcUX010248@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 15/19] powerpc: htab routines for Celleb
In-Reply-To: <1169080589.4965.25.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

Thank you for you comment.

> > +
> > +	dummy0 = beat_lpar_hpte_getword0(slot);
> > +	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
> > +	   DBG_LOW("not found !\n");
> > +			return -1;
> > +			}
> > +
> > +	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
> > +						 &dummy1);
> > +						 if (lpar_rc != 0 || dummy0 == 0) {
> > +						    DBG_LOW("not found !\n");
> > +								 return -1;
> > +								 }
> > +
> > +	DBG_LOW("ok %lx %lx\n", dummy0, dummy1);
> > +

> I just noticed... isn't there a race condition if the HPTE gets evicted
> between those two calls and/or replaced by another one ?

> That would be generally harmless unless the one replacing it is bolted,
> in which case you might override a bolted entry. Fortunately we don't
> currently insert much bolted entries after boot, but I still see a
> potential for trouble there.

> The best solution here is to actually add a function to the hypervisor,
> along the line of what I described in my document a while ago, which
> atomically compares AVPN and replaces the PP and N bits if it didn't
> change.
> 
> Another possible issue is that two processors or threads might
> continuously evict each other that way I think.
> 
> Since the bug only affect your platform and might actually not trigger
> at all in the current system since we don't play much with bolted
> entries, I'm acking it, but you should look into fixing it.

We understand your opinion and we should fix by locking all
table handlers by spinlock. We are now trying to add new functions
for our hypervisor to solve this problem, but we must support current
hypervisor, so we have to have a fix on current implementation.

Best regards,
Kou Ishizaki
