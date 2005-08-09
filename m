Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Tue, 9 Aug 2005 16:47:32 +0200
References: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
	<3F1564F6-3732-403B-BA6B-BFAB28568AEE@freescale.com>
In-Reply-To: <3F1564F6-3732-403B-BA6B-BFAB28568AEE@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508091647.32925.arnd@arndb.de>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dinsdag 09 August 2005 16:12, Kumar Gala wrote:
> > Yes, and that is exactly what I do not want. =A0We are not going
> > to require OF implementations that do not need yaboot or similar
> > to pass a flattened device tree to the kernel, eh? =A0Also, there
> > is no reason why something like yaboot (with an OF still running
> > underneath) should have to care about anything device-tree related
> > at all; the OS can just as easily ask the OF itself.
>=20
> I was under the impression that ALL platforms regardless if the had a =A0
> OF firmware or not would be using a flattened device tree. =A0Any =A0
> conversion between an OF tree to a flatten tree would end up =A0
> happening in boot wrapper code going forward.

I think you are both right, just using different terminology. The=20
running kernel uses its own representation of the device tree, which
is neither the flattened stuff nor using the OF interfaces. The=20
conversion from OF to the flattened tree is done by the kernel itself.

      Apple OF  \
          SLOF   \
       pSeries    |-1- prom_init------,
          PIBS   /                     \
           ...  /                       \
                                         \
       other    -----------------------------2--unflatten_device_tree--3--
   boot loader                              /
                                           /
       iSeries  ----------- early_setup---`

All "regular" machines enter in the traditional prom_init path (1)=20
from Open Firmware. The embedded machines that are too memory constraint
to use SLOF have a flattened device tree in their boot loader and the
legacy iSeries boxes can fake the device tree in their iSeries_early_setup
function. The main entry point (2) is entered by all machines when the
flattened device tree is there and the kernel builds its tree representation
for run time (3).

	Arnd <><
