Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6DAEDDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:36:05 +1100 (EST)
Subject: Re: [PATCH 15/19] powerpc: htab routines for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120115.l0C1FPHJ002416@toshiba.co.jp>
References: <200701120115.l0C1FPHJ002416@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:36:29 +1100
Message-Id: <1169080589.4965.25.camel@localhost.localdomain>
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


> +
> +	dummy0 = beat_lpar_hpte_getword0(slot);
> +	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
> +		DBG_LOW("not found !\n");
> +		return -1;
> +	}
> +
> +	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
> +					&dummy1);
> +	if (lpar_rc != 0 || dummy0 == 0) {
> +		DBG_LOW("not found !\n");
> +		return -1;
> +	}
> +
> +	DBG_LOW("ok %lx %lx\n", dummy0, dummy1);
> +

I just noticed... isn't there a race condition if the HPTE gets evicted
between those two calls and/or replaced by another one ?

That would be generally harmless unless the one replacing it is bolted,
in which case you might override a bolted entry. Fortunately we don't
currently insert much bolted entries after boot, but I still see a
potential for trouble there.

The best solution here is to actually add a function to the hypervisor,
along the line of what I described in my document a while ago, which
atomically compares AVPN and replaces the PP and N bits if it didn't
change.

Another possible issue is that two processors or threads might
continuously evict each other that way I think.

Since the bug only affect your platform and might actually not trigger
at all in the current system since we don't play much with bolted
entries, I'm acking it, but you should look into fixing it.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
