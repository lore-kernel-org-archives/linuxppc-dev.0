Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC88DDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 22:03:18 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4EC3Bgg025059
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 05:03:12 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m4EC39lJ029518
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 07:03:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Defer processing of interrupts when the CPU wakes from
	sleepmode
Date: Wed, 14 May 2008 20:03:09 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F168CF@zch01exm21.fsl.freescale.net>
In-Reply-To: <18474.27384.524310.787499@cargo.ozlabs.ibm.com>
References: <18474.27384.524310.787499@cargo.ozlabs.ibm.com>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<snip>

> This provides a way to defer processing of an interrupt that wakes the
> processor out of sleep mode.  On 32-bit platforms that use an
> interrupt to wake the processor, we have to have interrupts enabled in
> hardware at the point where we go to sleep, otherwise the processor
> will never wake up.  However, because interrupts are logically
> disabled at this point, we don't want to process the interrupt
> straight away.
>=20
> This is handled by setting the _TLF_SLEEPING flag.  When we get an
> interrupt and _TLF_SLEEPING is set, we firstly clear the MSR_EE
> (external interrupt enable) bit in the saved MSR value, and secondly
> we then return to the address in the link register, like we do for
> _TLF_NAPPING, but without actually handling the interrupt.
>=20
> Note that this is handled somewhat differently on powerbooks, so this
> new code will only be used on non-Apple machines.

Thanks Paul for this patch. The patch looks like very nice.
But the users have to be aware of the LINK register (LR) not corrupted.

So, does power management patch from Scott Wood need to respin?

BTW, why the fast_exception_return does *not* need clear the reservation
with stwcx.?

Thanks,
Dave
