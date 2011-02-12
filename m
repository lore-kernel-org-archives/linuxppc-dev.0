Return-Path: <sunder.svit@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0473B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 17:28:04 +1100 (EST)
Received: by fxm5 with SMTP id 5so3547854fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 22:28:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Date: Sat, 12 Feb 2011 11:58:00 +0530
Message-ID: <AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Sundar <sunder.svit@gmail.com>
To: Meador Inge <meador_inge@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sat, Feb 12, 2011 at 2:49 AM, Meador Inge <meador_inge@mentor.com> wrote=
:
>
> =A0 =A01. Hardware specific bits somewhere under '.../arch/*'. =A0Drivers
> =A0 =A0 =A0 for the MPIC message registers on Power and OMAP4 mailboxes, =
for
> =A0 =A0 =A0 example.

Yes; this can help.

> =A0 =A02. A higher level driver under '.../drivers/mailbox/*'. =A0That th=
e
> =A0 =A0 =A0 pieces in (1) would register with. =A0This piece would expose=
 the
> =A0 =A0 =A0 main kernel API.

A lot of mailboxes are too platform specific with regards to the communicat=
ion
with the main CPU and probably it depends on the mailbox too; you can
find polling and
interrupt supported mailbox support at times on the same platform.
APIs should probably be
generic enough to be able to operate in any context.

> Now I have the following questions:
>
> =A0 =A01. Do others see value in this?

At least I would like this; I wanted to generalize such mailbox IPCs
right from the
day when I was working on one, but coudnt really work on that.

> =A0 =A02. Does something like this already exist?

Not generic as you say; but apart from the OMAP platforms,
you could refer to arch/arm/mach-ux500/prcmu for a mailbox based
IPC on the U8500 platform.

> =A0 =A03. Is someone else already working on this?

Not sure of that too :), but I am CCing Linus W, the maintainer
of U8500 if he thinks it is a good idea to come up with a mailbox IPC
framework

Cheers!
--=20
---------
The views expressed in this email are personal and do not necessarily
echo my employers.
