Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/cell/axon-msi: retry on missing interrupt
Date: Fri, 21 Nov 2008 15:35:42 +0100
References: <200811171710.24521.arnd@arndb.de>
	<1227228636.7948.15.camel@localhost>
In-Reply-To: <1227228636.7948.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811211535.42987.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	GBIRAN@il.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 November 2008, Michael Ellerman wrote:
> By incrementing the offset we're dropping the irq. Would it be better to
> just return, and hope that the next time we come in the MSI will have
> landed in the fifo and then we can deliver it? It might be late, really
> late I guess, but that might be better then dropping it altogether.

If this happens, I'd rather treat it as an obvious failure case and make
the device driver hang rather than trying to fix up in case another MSI
comes in. The 100 microseconds should cover any case of really really
late, and if we don't get a valid interrupt here (e.g. because a card
still sends an interrupt after the device driver has unmapped the virq)
looking again at the same position would mean we don't move on to the
next valid one (or have to make the error case more complex).

Also, skipping an invalid interrupt is consistent with what we do right
now. Remember that we can't reliably tell the difference between
'invalid interrupt' and 'no interrupt at all'.

	Arnd <><
