Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE11A67B5B
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 16:32:34 +1000 (EST)
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200608190109.15129.arnd@arndb.de>
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222146.GI26889@austin.ibm.com>
	<200608190109.15129.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 16:31:49 +1000
Message-Id: <1156055509.5803.77.camel@localhost.localdomain>
Mime-Version: 1.0
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


> card->low_watermark->next->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
> mb();
> card->low_watermark->dmac_cmd_status &= ~SPIDER_NET_DESCR_TXDESFLG;
> card->low_watermark = card->low_watermark->next;
> 
> when we queue another frame for TX.

I would have expected those to be racy vs. the hardware... what if the
hardware is updating dmac_cmd_status just as your are trying to and the
bit out of it ?

Ben
