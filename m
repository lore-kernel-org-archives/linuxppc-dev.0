Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 177FA2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 07:08:35 +1000 (EST)
Message-ID: <5200143F.9010307@ovro.caltech.edu>
Date: Mon, 05 Aug 2013 14:08:15 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EcnT3We1X22pw4AQ28xmd2d-XB9nTzZ2KdVb=qOx4j7-Q@mail.gmail.com>
In-Reply-To: <CAN8Q1EcnT3We1X22pw4AQ28xmd2d-XB9nTzZ2KdVb=qOx4j7-Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pete,

>> 1. Have you checked the power supplies on the PCI board?
>>
>>     PCI boards can be powered from 3.3V or 5V, or both. I've had
>>     old PCs that only supply one or the other rail, and various
>>     evaluation boards that only supply 3.3V.
>>
>>     If you can put together a "working" x86 setup that detects the
>>     board, then you could poke around and see what voltages exist
>>     on some of the decoupling components, then plug it into your
>>     real system, and see what voltages you measure there.
>
> These are universal boards.  Our board does only support only 3V3 (and
> is slotted as such).

Ok.

>> 2. Have you probed the PCI bus using a bus analyzer or scope?
>>
>>     If you have a PCI bus analyzer (or can find someone with one),
>>     plug it in and see what happens at power-on (there should be
>>     configuration cycles).
>>
>>     At a minimum, if you have a 'scope, see if the PCI configuration
>>     space access handshakes are active during power-on.
>
> Hmm...I do have one.  But I can't get both the analyzer and the card
> in the system in at the same time.

My analyzer has an extender card that you first plug in, and then
plug the board into that ... any chance someone in your organization
has one of those cards? Alternatively, confirm the board works in
a machine that has more than one slot, and if it does not, use the
analyzer to see what is happening.

>> 3. Is debugging this PCI card worth your time?
>>
>>     Sometimes the "solution" involves tossing old hardware in
>>     the trash.
>
> Well, this is part of the ongoing work regarding the incoming PCI
> memory corruption.

Ok, I recall seeing that thread.

> We are going down the path of abandoning the 82540
> for our platform because we can't seem to track down the corruption.
> So we are looking at other chipsets which we can purchase, which
> include this National (now TI) chipset on the Netgear FA331.  If we
> could find a PCI (_not_ PCIe) card to test with that seems to work...
>
> Interestingly, I have an older 3com 3C905TXM exhibiting the same
> behavior.  Both of these are older cards (they even came with drivers
> on--gasp--floppies!).  Maybe the lack of a 5V supply is an issue...

If you're looking for a PCI target that you can completely control,
then if you have an "FPGA guy" in your company, perhaps he can
dig up a low-cost PCI card that you can configure as a PCI master
to emulate the functions of a network card.

Actually, before going down that route, I would get a PCI extender
that you can use to trace the traffic with your board. Does the
network card use 33MHz or 66MHz?

Cheers,
Dave
