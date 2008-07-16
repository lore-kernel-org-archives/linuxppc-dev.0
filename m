Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Thu, 17 Jul 2008 00:58:53 +0200
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<200807161646.02306.arnd@arndb.de>
	<20080716154646.GH24045@secretlab.ca>
In-Reply-To: <20080716154646.GH24045@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807170058.53599.arnd@arndb.de>
Cc: Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Grant Likely wrote:
>=20
> > Shouldn't it be enough to have a common compatible value in each
> > of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
> > specific type unless you need to do something special?
>=20
> This is bad for the same reason that "amcc,44x-<blah>" compatible values
> are bad in device nodes. =A0The definition of '*-44x-*' changes over time=
 as
> new parts are added. =A0Compatible values should always reflect an exact
> part number.

I agree in general, but I also think that all 44x boards should be
regarded as the same machine time, in the same way that all powermacs
are detected as compatible with "Power Macintosh" or "MacRISC", or
how all sorts of serial ports claim compatibility with i8250.

=46or classic SOCs like 4xx or 52xx, the SOC familiy more or less defines
the platform, and all the details about peripherals can be expressed
in the device tree elsewhere.

If one board is so different that you need a separate board setup
in the kernel, it should simply not claim compatibility with the
SOC platform.

	Arnd <><
