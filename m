Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F217FB70AF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 01:28:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/9] RapidIO,
	powerpc/85xx: modify RIO port-write interrupt handler
Date: Mon, 16 Aug 2010 08:27:34 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F94@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692B42.9050407@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-3-git-send-email-alexandre.bounine@idt.com>
	<4C692B42.9050407@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> > - Rearranged RIO port-write interrupt handling to perform message
buffering
> > as soon as possible.
>=20
> I don't understand this comment: you still schedule work to read the
> port-write queue; so how is this message buffering performed as soon
as
> possible?


Compared to the original code, I rearranged order of checking interrupt
status bits to check the queue status first. The 85xx PW controller is
capable to receive and keep only one PW message. Therefore, I copy it
into the driver's FIFO and re-enable HW Rx queue (it is called queue but
can accept only one entry) ASAP. I have a test setup that is capable
generate multiple PW messages and see many messages discarded by PW
controller
because of this single-entry HW queue.
=20
>=20
> > - Modified to disable port-write controller when clearing
Transaction Error (TE)
> > bit.
> >  	/* Schedule deferred processing if PW was received */
> > -	if (ipwsr & RIO_IPWSR_QFI) {
> > +	if ((ipwmr & RIO_IPWMR_QFIE) && (ipwsr & RIO_IPWSR_QFI)) {
>=20
> Why check the QFIE bit also?

Oops! Leftover from some testing. Will clean it up.

>=20
> > +pw_done:
> > +	if (epwisr & 0x80000000) {
>=20
> Magic value.


Agree. Will correct.
