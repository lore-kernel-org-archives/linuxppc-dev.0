Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 883ADDDEDB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:42:37 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1LChwUx5939238
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:43:58 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L0k3bG106792
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:46:03 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L0gXOo026268
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:42:34 +1100
Date: Wed, 21 Feb 2007 11:33:58 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [0/14] Ebony support, 2nd spin
Message-ID: <20070221003358.GI10231@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
	<200702201516.25160.arnd@arndb.de>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171983806.24204.79.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 09:03:26AM -0600, Josh Boyer wrote:
> On Tue, 2007-02-20 at 08:46 -0600, Josh Boyer wrote:
> > On Tue, 2007-02-20 at 15:16 +0100, Arnd Bergmann wrote:
> > > On Tuesday 20 February 2007 15:05, Josh Boyer wrote:
> > > > Which probably has something to do with the of_serial driver being used
> > > > now.  Just an FYI.
> > > 
> > > If you want to use of_serial together with serial console, you need
> > > to make sure that the detection logic in arch/powerpc/kernel/legacy_serial.c
> > > finds the port. It currently finds the serial port on axon, but that
> > > requires that the bus it's on is of type "opb" and the device itself
> > > is listed as "stdout" and has type "serial" and is compatible with
> > > "ns16750" (note: the others look for "ns16550" here).
> > 
> > The ebony dts has the ports as ns16550.  That is required for the
> > bootwrapper to find the port to use for it's output at the moment.
> 
> And the ebony dts also has the a bus type of "ibm,opb" as well.
> 
> I hacked legacy_serial.c to look for ns16550 compatible devices with a
> parent OPB node of type "ibm,opb" and I got serial output on the Ebony
> board even with of_serial turned off.

No, the idea is that Ebony *should not* be using legacy_serial.  It
uses of_serial instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
