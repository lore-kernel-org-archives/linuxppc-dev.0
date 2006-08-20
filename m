Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id C8F0667B94
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 20:03:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Date: Sun, 20 Aug 2006 12:03:14 +0200
References: <20060818220700.GG26889@austin.ibm.com>
	<200608190109.15129.arnd@arndb.de>
	<1156055509.5803.77.camel@localhost.localdomain>
In-Reply-To: <1156055509.5803.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200608201203.15645.arnd@arndb.de>
Cc: akpm@osdl.org, netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	ens Osterkamp <Jens.Osterkamp@de.ibm.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 20 August 2006 08:31, Benjamin Herrenschmidt wrote:
> > card->low_watermark->next->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
> > mb();
> > card->low_watermark->dmac_cmd_status &= ~SPIDER_NET_DESCR_TXDESFLG;
> > card->low_watermark = card->low_watermark->next;
> > 
> > when we queue another frame for TX.
> 
> I would have expected those to be racy vs. the hardware... what if the
> hardware is updating dmac_cmd_status just as your are trying to and the
> bit out of it ?

Right, that doesn't work. It is the only bit we use in that byte though,
so maybe it can be done with a single byte write.

	Arnd <><
