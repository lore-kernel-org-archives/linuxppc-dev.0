Message-ID: <3BC3B729.EFE00901@mvista.com>
Date: Tue, 09 Oct 2001 22:49:13 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Odd behaviour with 860P and LXT970
References: <638AA0336D7ED411928700D0B7B0D75BB32349@aimail.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Gessner, Matt" wrote:

> ..... It's the switching
> rates that causes the problem.

Take an o'scope and look at the clocks from the PHY to the FEC.  The
PHY is responsible for providing the data clocks, and there is nothing
from "our" side that is clock speed related (except the MDIO clock, which
isn't the concern here).  The only thing we have to know in the driver is
full/half duplex and reconfigure the FEC if necessary.

It almost sounds like the PHY didn't negotiate or determine the clock speed
correctly.  I tend to take the simple approach and always let the PHY
autonegotiate.  That is, I don't tell it with commands to use a particular
link speed, just read what it found.  The PHY command interface in the FEC
driver seems to be growing more complex and forcing modes of operation, when
I never did that in the original driver.

That's about all I can think of at this hour.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
