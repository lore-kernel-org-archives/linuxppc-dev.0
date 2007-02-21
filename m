Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [0/14] Ebony support, 2nd spin
Date: Wed, 21 Feb 2007 10:06:58 +0100
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201516.25160.arnd@arndb.de>
	<20070221003558.GJ10231@localhost.localdomain>
In-Reply-To: <20070221003558.GJ10231@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702211006.58565.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 February 2007 01:35, David Gibson wrote:
> Err.. no. =A0On my system legacy_serial doesn't touch the ports, but I'm
> getting console output via of_serial just fine. =A0The console is
> initialized rather later than would be ideal, but it works.
>=20
> I know that BenH has expressed the strong preference that
> legacy_serial should be reverted to only handling legacy ISA ports,
> not SoC and other hardwired ports.

Ok, my impression on this was that of_serial is the right solution
in general, but it often gets initialized too late to debug some
of the interesting parts of the boot sequence.

Unless we take handling of soc serial ports completely out of
legacy_serial, I think it should handle ebony just like the other
boards.

Because of the way the serial layer works, it does exactly the
right thing if you have both drivers enabled, i.e. it starts
out using the first port when legacy_serial detects it, but later
of_serial finds it as well, and wires up all the logic to connect
both the serial ports to the right device tree nodes.

	Arnd <><
