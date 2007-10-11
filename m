Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC: Fix find_legacy_serial_ports on OPB.
Date: Thu, 11 Oct 2007 19:09:39 +0200
References: <20071011152609.GA10320@ru.mvista.com>
	<200710111750.41852.arnd@arndb.de>
	<1192118028.5534.123.camel@localhost.localdomain>
In-Reply-To: <1192118028.5534.123.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710111909.39927.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 October 2007, Josh Boyer wrote:
> Wait, no. =A0We already had this discussion months ago when David was
> working on the original Ebony port. =A0It was declared that legacy_serial
> is not how serial should be done on 4xx and the serial_of driver was
> supposed to be used instead.
>=20
> Have we changed our stance on that? =A0If not, then perhaps KGDB should be
> fixed to work with serial_of.

I guess I'm fine with a patch that removes the OPB probing from
legacy_serial, but as long as it's there it should work on all
platforms.

Note that of_serial and legacy_serial are not exclusive, as of_serial
will simply take over all ports that have previously been registered
by the legacy code. Probing them early has the advantage that you
can see many printk messages earlier when the of_serial initialization
has not been called yet.

	Arnd <><
