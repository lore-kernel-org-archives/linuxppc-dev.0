Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 200BC2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 06:50:00 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id t13so2428423lbd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 13:49:56 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <52000ACA.1010606@ovro.caltech.edu>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
Date: Mon, 5 Aug 2013 13:49:56 -0700
Message-ID: <CAN8Q1EcnT3We1X22pw4AQ28xmd2d-XB9nTzZ2KdVb=qOx4j7-Q@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 1:27 PM, David Hawkins <dwh@ovro.caltech.edu> wrote:
> 1. Have you checked the power supplies on the PCI board?
>
>    PCI boards can be powered from 3.3V or 5V, or both. I've had
>    old PCs that only supply one or the other rail, and various
>    evaluation boards that only supply 3.3V.
>
>    If you can put together a "working" x86 setup that detects the
>    board, then you could poke around and see what voltages exist
>    on some of the decoupling components, then plug it into your
>    real system, and see what voltages you measure there.

These are universal boards.  Our board does only support only 3V3 (and
is slotted as such).

> 2. Have you probed the PCI bus using a bus analyzer or scope?
>
>    If you have a PCI bus analyzer (or can find someone with one),
>    plug it in and see what happens at power-on (there should be
>    configuration cycles).
>
>    At a minimum, if you have a 'scope, see if the PCI configuration
>    space access handshakes are active during power-on.

Hmm...I do have one.  But I can't get both the analyzer and the card
in the system in at the same time.

> 3. Is debugging this PCI card worth your time?
>
>    Sometimes the "solution" involves tossing old hardware in
>    the trash.

Well, this is part of the ongoing work regarding the incoming PCI
memory corruption.  We are going down the path of abandoning the 82540
for our platform because we can't seem to track down the corruption.
So we are looking at other chipsets which we can purchase, which
include this National (now TI) chipset on the Netgear FA331.  If we
could find a PCI (_not_ PCIe) card to test with that seems to work...

Interestingly, I have an older 3com 3C905TXM exhibiting the same
behavior.  Both of these are older cards (they even came with drivers
on--gasp--floppies!).  Maybe the lack of a 5V supply is an issue...

Thanks,
Pete
