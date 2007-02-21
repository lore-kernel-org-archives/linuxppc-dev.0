Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Feb 2007 11:35:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [0/14] Ebony support, 2nd spin
Message-ID: <20070221003558.GJ10231@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
	<200702201516.25160.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200702201516.25160.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 03:16:24PM +0100, Arnd Bergmann wrote:
> On Tuesday 20 February 2007 15:05, Josh Boyer wrote:
> > Which probably has something to do with the of_serial driver being used
> > now.  Just an FYI.
> 
> If you want to use of_serial together with serial console, you need
> to make sure that the detection logic in arch/powerpc/kernel/legacy_serial.c
> finds the port. It currently finds the serial port on axon, but that
> requires that the bus it's on is of type "opb" and the device itself
> is listed as "stdout" and has type "serial" and is compatible with
> "ns16750" (note: the others look for "ns16550" here).

Err.. no.  On my system legacy_serial doesn't touch the ports, but I'm
getting console output via of_serial just fine.  The console is
initialized rather later than would be ideal, but it works.

I know that BenH has expressed the strong preference that
legacy_serial should be reverted to only handling legacy ISA ports,
not SoC and other hardwired ports.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
