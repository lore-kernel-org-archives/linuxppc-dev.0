Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B221CDDF47
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 19:05:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4S95TmS017105
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 02:05:29 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4S95PkY029967
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 04:05:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: fsl booke MM vs. SMP questions
Date: Mon, 28 May 2007 17:05:25 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
In-Reply-To: <1179889736.32247.893.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

> You never "loose" IPIs in the sense that you always get at least 1
> interrupt for N IPIs and it's up to software to make sure not to lose
> any event. The linux kernel arch code usually handles that with a
> synchronous IPI mecanism.

Due to the synchronous IPI mechanism for TLB invalidatation, it is
very time exhausting, there are interrupt overhead and wait time for
sync.

I also noticed that tlb invalidation on the PowerPC 750 SMP system
is using the IPI mechanism, that is because the 750 can not broadcast
tlb invalidation ops.
=20
If the broadcast tlbivax instruction is more effective than the IPI
mechanism?

Did you evaluate the performance with the two different ways?

-d
