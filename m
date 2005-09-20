Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7926168308
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 05:14:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 20 Sep 2005 14:14:56 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859465@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <jeff@theptrgroup.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: wait_event and interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Jeff Angielski [mailto:jeff@theptrgroup.com]=20
> Sent: Tuesday, September 20, 2005 13:40
> On Tue, 2005-09-20 at 12:56 -0500, Rune Torgersen wrote:
>=20
> > Is there a better way of doing this?
>=20
> If you *must* share the variable between interrupt and non-interrupt
> context, you must mutex it in an interrupt safe way.  The use of
> spin_lock_irqsave() comes to mind for you read function.

The shared variable is an int, which should be atomic to access anyways.
Someone else told me to try to set the shared variable to volatile.

> But you are going to have other problems with this approach anyways
> since you "appear" to be assuming a one-to-one relationship=20
> between your
> interrupt handler and the read function.  Is that really true?
Yes. The read function starts the hardware, and the hardware responds
with an interrupt when it's done.
