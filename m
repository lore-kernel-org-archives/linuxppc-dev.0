Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 1C4E3DDF08
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 07:26:15 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so500380anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Apr 2008 14:26:12 -0700 (PDT)
Message-ID: <fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
Date: Tue, 8 Apr 2008 15:26:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: Question on mpc52xx_common.c
In-Reply-To: <20080408194517.GX13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com> <200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 8, 2008 at 1:45 PM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
> On Tue, Apr 08, 2008 at 08:52:55AM -0600, Grant Likely wrote:
>  > It may be ideal, but I don't think it is realistic.  I'm now of the
>  > firm opinion that device trees and firmware are *never* perfect.
>  > Especially when the definition of perfect is a moving target.
>
>  Well observed; isn't this the prove of the assumption that the whole
>  device tree idea is not working? It is *always* inconsistent and it is
>  *maintenance hell* because out-of-tree ports do *always* breakt because
>  of string inconsistencies. We have just ported a 8260 board from 2.6.22
>  to 2.6.25 and it is almost 100% oftree porting. And you do not even have
>  a single point of a parser, because all this string parsing is
>  completely scattered all over the tree.

I disagree and that is not my point.  My point is that perfection is
neither obtainable or necessary.  Many of the recently established
embedded guidelines are not "perfect" because they are counter to a
few of the OF recommended practices.  However, they are consistent
within themselves, they work, and once established they are not going
to change.  imperfect != bad.  I brought up a new 5200 board this week
which required zero kernel changes.  All I needed was a new dt to
describe the board.

Now, if out-of-tree ports continue to break then we've got a problem
that needs to be fixed.  Once a binding is established (which usually
takes a few kernel releases) it should be very stable and even if the
definition of ideal is changed, backwards compatibility must be
maintained.

>  The ARM method of using just a device number is so much easier ...

Only if the assumption is made that very little data needs to be
shared between the kernel and the firmware.  The moment you try to do
something more complex you either have the nightmare of bd_info or you
use a structured data format (like the device tree)

On another node, there are platforms where a device number is
unworkable.  For example, for Linux on an FPGA like the Xilinx Virtex,
there would need to be a new platform number every time the FPGA
bitstream was updated because it is effectively an entirely different
platform.

Finally, using a device number means you need to encode into the
kernel the exact layout of every platform it supports.  That adds up
to a lot of code in a real hurry; even if most of it is just
boilerplate instantiations.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
