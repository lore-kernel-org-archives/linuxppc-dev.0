Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: radeonfb.c flakiness
Date: Mon, 18 Feb 2002 15:55:53 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
References: <4BAF45B8-23D3-11D6-B713-0003938E434C@ivey.uwo.ca> <20020217215121.3523@smtp.wanadoo.fr>
In-Reply-To: <20020217215121.3523@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20020218205555.OVAC2625.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben and Ani,
>
> Try removing the bit of code in my radeonfb.c that blast various
> registers like MC_FB_LOCATION within a #ifdef CONFIG_ALL_PPC
> in radeon_pci_register().
>
> I suspect the sequence for changing those isn't good, the chip may
> need some additional reset or delays.

Tried that no help.  I have now figured out that the only way to make the
DFP startup properly is to zap the parameter ram (one chime's worth) and
then it will actually startup.  If I don't do that and I have been running
MacOSX then no matter what I do or try it does right after the yaboot
prompt I see a flash and then everything stays blank.

Perhaps Mac OSX driver is writing something to nvram or is moving the
memory mapping for the card's interfaces.  Either way without that single
pram zap, the screen simply goes dead and stays dead.

I am willing to try and debug this further by dumping addesses and things
from the device tree under both Linux and MacOSX to try and figure out
what has changed, if either of you think it would help.

Just let me know what you want me to try.

Thanks,

Kevin

> >I can't understnad why the screen simply goes blank immediately after
> >the kernel starts to boot.
> >
> >Ben, you mentioned something about playig with the memory mapping of
> > the card.  I see code that does something along those lines in the
> > radeonfb.c for screens that have dual heads.
> >
> >Do you have any ideas I should test to see if they impact the random
> >startup blank screen issue (btw the kernel boots fine and I can blindly
> >login and shutdown).  Changing VTs from 1 to 2 or 3 has no impact.
> >
> >Ideas welcome.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
