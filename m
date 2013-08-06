Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 06B982C0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 12:01:24 +1000 (EST)
Message-ID: <520058E0.8080304@ovro.caltech.edu>
Date: Mon, 05 Aug 2013 19:01:04 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
In-Reply-To: <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
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

> On Mon, Aug 5, 2013 at 4:07 PM, Peter LaDow <petela@gocougs.wsu.edu> wrote:
>> However, replacing the 82540 based card with either a 3com 3C905TXM or
>> the Netgear FA331, there is no response on the 0x10 IDSEL line.  Thus
>> it appears these cards are NOT responding to configuration reads.  I
>> think I have to break out the scope and probe around for the 5V/3V.  I
>> wouldn't think that the supplies are the issue since these are
>> universal cards, and as I understand it either 3V3 _or_ 5V can be
>> present, so these should work fine.  Yet they aren't responding to PCI
>> configuration cycles.

It depends on what you define "Universal PCI" as :)

My definition is that the board works with either 5V or 3.3V PCI
signals. However, that definition does not tell you where the device
draws power from.

I suspect the lack of either the 5V or 3.3V power rail to the card
might be the problem.

Did you probe the PCI edge connect to see what supplies were present?

> A few more notes.  I tried a variety of other cards, such as a PCI
> modem (WinMode, ack), a WinTV card, and a PCI based 802.11 card.  All
> of them enumerate perfectly.

These could all be 3.3V cards ...

> Perhaps it is a BIOS option ROM like you suggested earlier.  The
> 3c90xC reference manual I found
> (http://people.freebsd.org/~wpaul/3Com/3c90xc.pdf) mentions an option
> ROM (and there is an Atmel part stuffed).  I can't find any technical
> information on the FA331 (yet), so I don't know about it.
>
> But regardless, wouldn't enumeration have to occur before any option
> ROM could even be used?

I've never had a card with an option ROM, so can't comment. I'd have
to look at the PCI spec. If you want me to look, let me know.

Cheers,
Dave
