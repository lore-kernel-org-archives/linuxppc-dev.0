Message-Id: <200012081601.QAA31117@hyperion.valhalla.net>
Date: Fri, 08 Dec 2000 15:36:18 +0000
Subject: Re: AW: Sound on an iBook?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Christof Petig <christof.petig@wtal.de>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        "Halfmann, Klaus" <khalfmann@libra.de>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christof Petig wrote:

>[...]
>
> The link is dead, but
> http://www.micronas.com/products/documentation/consumer/dac3550a/index.php
> works for me well.

thanks for the update.

> Thank you very much for this information!

OK.  I think my first reply may have gone astray (it never showed up here
anyway)...

This is what I (think) I know about the "problem".

1/  The output uses dmdma same as the other chips - so fixing up init() to
recognise the iBook and do the necessary register assignments from the OF
tree should be an OK solution (i.e. no more ugly than any other version of
the dmasound driver)... except for:

2/  There is *no* mixer abstraction - because the chip is driven through i2c
(like the sound control chip on the G3/beige - which I *have* played with -
unfortunately a different i2c bus).  Which is why you get whatever OF
leaves..

I suspect that 'freezing' has got nothing to do with the chip per se... but
probably more to do with invalid mixer abstraction code being called.

========

So you will need to:

Fix up the init code - and maybe the register map. although I suspect this
has been done in the hack to which Klaus referred.. don't know which hack
(it's not in mine ;-).

write a mixer abstraction modelled on the ones for awacs and burgundy.  A
little nasty 'cos the code has evolved into something with many arms... ;-)

also there are many bodges to represent the Apple hardware under OSS - which
doesn't really have the API for the resources...  I have an idea to address
this as well - but it will have to wait for a few more weeks.

I have a request...

when I get back on line with the dmasound driver (expect Jan 01) I want to
continue with a code tidy - basically partitioning the source so that one
chip set is dealt with in one file (leaving the common dbdma abstraction
aside).

There are many issues (not least of which is maintaining a common base
across the 68k stuff as well) to address in this split-up but I think it's
long overdue.

So, if you have a go (and think there *are* some bits of useful code in
Darwin)... it would help me if the daca-specific mixer abstraction was
clearly separated from the other stuff.  (better still in a separate source
file from the start ;-)

thanks,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
