Return-Path: <linus.ml.walleij@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB1FDB7126
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 08:24:40 +1100 (EST)
Received: by pxi20 with SMTP id 20so944260pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Feb 2011 13:24:38 -0800 (PST)
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Date: Sun, 13 Feb 2011 22:24:38 +0100
Message-ID: <AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: Meador Inge <meador_inge@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: openmcapi-dev@googlegroups.com, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/2/11 Meador Inge <meador_inge@mentor.com>:

>=A0This would entail the traditional
> generic/specific driver split:
>
> =A0 =A01. Hardware specific bits somewhere under '.../arch/*'. =A0Drivers
> =A0 =A0 =A0 for the MPIC message registers on Power and OMAP4 mailboxes, =
for
> =A0 =A0 =A0 example.

Having any drivers under arch/* is no good tradition IMO.
Better move the whole shebang down to drivers/mailbox so
that the subsystem maintainer get the complete overview
of her/his driver family.

> =A0 =A02. A higher level driver under '.../drivers/mailbox/*'. =A0That th=
e
> =A0 =A0 =A0 pieces in (1) would register with. =A0This piece would expose=
 the
> =A0 =A0 =A0 main kernel API.

Cool...

> =A0 =A03. Userspace interfaces for accessing the mailboxes. =A0A
> =A0 =A0 =A0 '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example=
.

What kind of business does userspace have with directly using
mailboxes? Enlighten me so I get it... in our system these are
used by protocols, such as net/caif/* thru drivers/net/caif/*, and
we have similar kernelspace functionality for Phonet.

CAIF and Phonet on the other hand, have custom openings
down to the thing that exists on the other end of the mailbox.
Most of these systems tend to talk some funny protocol that
is often better handled by the kernel than by any userspace.

So is this for the situation when you have no intermediate
protocol between your userpace and the other CPU's
subsystem? Or are you thinking about handling that
protocol in userspace? That is generally not such a good idea
for efficiency reasons.

Yoursm
Linus Walleij
