Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 846B467CEC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 16:27:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7N7kKii020381
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 01:46:20 -0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7N6RWVj029499
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 01:27:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Wed, 23 Aug 2006 14:27:30 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E5CF@zch01exm23.fsl.freescale.net>
In-Reply-To: <526188FB-0FE5-40BA-AB21-EB491BB24911@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Aug 22, 2006, at 9:20 PM, Zang Roy-r61911 wrote:
>=20
> > The patch passes the UPIO_TSI flag to general 8259 serial driver
> >
> > Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
>=20
> Maybe, I'm missing something, but why do we need this?  Why=20
> doesn't iotype =3D=3D UPIO_MEM work for the TSI?
>=20
> - kumar
>=20

Tsi108 serial port has some difference from the standard 8250 port.
 I add UPIO_TSI in general 8250 serial driver to handle IIR and IER
register=20
in serial_in and serial_out.

(1) the reason to rewrite serial_in:

    TSI108 rev Z1 version ERRATA.  Reading the UART's Interrupt
    Identification Register (IIR) clears the Transmit Holding Register
    Empty (THRE) and Transmit buffer Empty (TEMP) interrupts even if
they
    are not enabled in the Interrupt Enable Register (IER).  This leads
to
    loss of the interrupts.  Interrupts are not cleared when reading
UART
    registers as 32-bit word.

(2) the reason to rewrite serial_out:

    Check for UART_IER_UUE bit in the autoconfig routine.  This section
    of autoconfig is excluded for Tsi108/109 because bits 7 and 6 are
    reserved for internal use.  They are R/W bits.  In addition to
    incorrect identification, changing these bits (from 00) will make
    Tsi108/109 UART non-functional.

I need to pass UPIO_TSI flag to the 8250 driver when the tsi108 bridge
serial port is used.
