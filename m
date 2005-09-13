Return-Path: <nd@bplan-gmbh.de>
Received: from smtp11.wanadoo.fr (smtp11.wanadoo.fr [193.252.22.31])
	by ozlabs.org (Postfix) with ESMTP id E9BB268259
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Sep 2005 19:40:48 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1104.wanadoo.fr (SMTP Server) with ESMTP id AF25E1C000B4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Sep 2005 11:40:45 +0200 (CEST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
Date: 13 Sep 2005 11:35:31 +0100
In-Reply-To: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
Message-Id: <20050913094045.301A31C00087@mwinf1104.wanadoo.fr>
Cc: Sven Luther <sl@bplan-gmbh.de>
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello !

I was wondering what is the status of the mv eth driver?

> The main changes (AFAIR):
> * Workaround for the TCP/UDP hw checksum
Should be included in my opinion. It gives a serious boost on TX.

> * Use hardware for statistics
Dunno if it should be commited. I don't think you would gain more than 0.1%
;-)

> * Define and use SRAM (for pegasos II archp/ppc/chrp_pegasos_eth.c)
Should be include IMO. It only applies for the Pegasos II

> * Able to use max burst size from/to DDR (serious transfer boost)
see notes below.

> * Option can be selected through the menu (drivers/net/Kconfig)
Should be removed/ignored as discussed previously

> * ...

> some testing...

> By the way, I noticed that page_address() sometimes returns NULL when
> using highmem (with a lot of mem).

Implementating MAXBURST...
Using kmap/kunmap instead of page_address (which is the right way do to, as
far as I understood), is a bit more complex.
Indeed, kunmap() can't be called from an interrupt.
However, this would have been very simple to kunmap() the page from there.

It would be possible to put every pages to kunmap into
a list (list_add() would be inside the interrupt) and to kunmap() the whole
list at another moment.

This would probably mean to extend pkt_info/eth_tx_desc.
also, I wonder what would happen if a page is:

- kmap() into xmit
- then put in the list into the interuupt
- kmap again into xmit
- and kunmap() afterwards...

Is there any other way to get the bus address of a page ?
The first thing, if we want to keep 'max burst size' should be to disable
it
if high mem is enable. At least, it would be stable.

Bye
-- 
Nicolas DET
MorphOS & Linux developer
