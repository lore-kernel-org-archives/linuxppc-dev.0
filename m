Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B0E@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'Pavel Bartusek'" <pba@sysgo.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: MDIO clock speed computation
Date: Mon, 22 Jul 2002 16:54:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> The MII clock is not derived from the core speed, but rather the
> system/bus clock speed.

Motorola documentation says the MDIO clock is a fraction of the system clock
frequency. I tought the system clock was the core clock, and the external
bus clock was divided using SCCR[EBDF]. Where is it told the system clock is
the bus clock?

> Up to this point, I don't believe there are
> any 8xx parts that are qualified to run beyond a 50 MHz CPU/bus
> speed, so the software is just fine.

The value of 82.5MHz was only a example to show the
erroneous computation. May be it was badly choosed, I admit.
You can also try with 47.5MHz (more realistic) and
see this yields to a MII clock of 2.64MHz.

> Also, the 2.5 MHz is a suggestion, I think all PHYs run much
> faster, you will have to check the data sheet.

I think this is a bad assumption. A PHY from National,
the DP83846A, specifies a MDIO clock of 2.5MHz (MAX).
A PHY of Intel, the LXT972A, as a maximum speed of 8MHz.

> The only thing that will happen if this speed is out of spec
> for either side is you will have problems configuring
> or detecting the PHY (the exchange of control/status messages).

The funniest thing is that the problem that Pavel reported today
seems to fix a problem that was submitted to me a couple of
weeks ago, and that I just begun to work on this morning!!!

My 860T is clocked at 49.152MHz, and the MII clock (with the
erroneous calculation) was output to 2.73MHz to my DP83846A PHY.

During FEC initialization, I have a couple of MDIO accesses
thightly serialized. Sometimes, the system was hanging, waiting
for an MDIO to complete. The answer was never received by the FEC.
With my BDI2000, I just set the MII_DATA register again to force
the read command to be resent, and the board continued to boot.

Changing the MII clock to 2.46MHz just seemed to fix the problem.
I successfully ran tests for more than an hour now...

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
