Message-ID: <3C6A25BC.7010704@elsoft.ch>
Date: Wed, 13 Feb 2002 09:37:16 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: Armin <akuster@pacbell.net>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: 405 MII-PHY communication problem (was: Re: PPC405gp enet Soft Reset)
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com> <3C63AE1A.7000907@pacbell.net> <20020208120140.B27732@ecam.san.rr.com> <3C67B119.4080702@elsoft.ch> <20020211164906.A1822@ecam.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

andrew may wrote:
> On Mon, Feb 11, 2002 at 12:55:05PM +0100, David Müller (ELSOFT AG) wrote:
>
>>Hi
>>
>>andrew may wrote:
>>
>>>Here is a log from ppcboot since it is easy to test this there without doing
>>>a kernel build. My phy is at address 0x1f.
>>>
>>>=> mii read 0x1 2
>>>07FF
>>>=> mii read 0x1 3
>>>read err 3
>>>a2: read: EMAC_STACR=0xffffc023, i=2
>>>Error reading from the PHY
>>>07FF
>>>
>>>
>>I'm seeing this error too on our boards. But i'm not certain, if it's a
>>problem of the MII controller in the 405 or a problem of the LXT971.
>>What revision of the 405 do you have? What clock frequency your 405 run at?
>>
>
> Well since I have no phy at address 1 I expect to get an error, but the problem
> is that I am not getting an error when the register number is even.
>
> The phy is at address 0x1f since it was easier for our hw guy to tie all the pins
> to the same thing rather than put it at low address.
>
> It is a RevE chip running at 266Mhz, the phy is an AMD Am79C874/ Altima AC101.
>
>

Our board is also a PPC405GP Rev E processor running @ 266MHz. Attached
to the MII port is an Intel LXT971ALE PHY chip @ address #1.

There i see the same error as you are describing (even-numbered PHY
registers give no error):

=> mii info
read err 3
a2: read: EMAC_STACR=0xffffc003, i=2
PHY 0x01: OUI = 0x04DE, Model = 0x0E, Rev = 0x02, 100baseT, FDX
read err 3
a2: read: EMAC_STACR=0xffffc043, i=2
read err 3
a2: read: EMAC_STACR=0xffffc063, i=2
read err 3
a2: read: EMAC_STACR=0xffffc083, i=2
read err 3
a2: read: EMAC_STACR=0xffffc0a3, i=2
read err 3

=> mii read 0 0
07FF
=> mii read 0 1
read err 3
a2: read: EMAC_STACR=0xffffc001, i=2
Error reading from the PHY
07FF
=> mii read 0 2
07FF
=> mii read 0 3
read err 3
a2: read: EMAC_STACR=0xffffc003, i=2
Error reading from the PHY
07FF
=> mii read 1 0
3100
=> mii read 1 1
7829
=> mii read 1 2
0013
=> mii read 1 3
78E2
=> mii read 2 0
07FF
=> mii read 2 1
read err 3
a2: read: EMAC_STACR=0xffffc041, i=2
Error reading from the PHY
07FF
=> mii read 2 2
07FF
=> mii read 2 3
read err 3
a2: read: EMAC_STACR=0xffffc043, i=2
Error reading from the PHY
07FF


On another custom board there is a PPC405GP Rev D processor running @
200MHz. Attached to the MII port is a Cirrus "Crystal LAN" CS8952 PHY
chip @ address #1.

With this configuration the MII controller sees a "ghost" PHY device at
adresse #0:

=> mii info
PHY 0x00: OUI = 0x0688, Model = 0x20, Rev = 0x05, 100baseT, FDX
PHY 0x01: OUI = 0x0688, Model = 0x20, Rev = 0x05, 100baseT, FDX
read err 3
a2: read: EMAC_STACR=0xffffc043, i=4
read err 3
a2: read: EMAC_STACR=0xffffc063, i=4
read err 3
a2: read: EMAC_STACR=0xffffc083, i=4
read err 3
a2: read: EMAC_STACR=0xffffc0a3, i=4
read err 3

=> mii read 0 0
3000
=> mii read 0 1
786D
=> mii read 0 2
001A
=> mii read 0 3
2205
=> mii read 1 0
3000
=> mii read 1 1
786D
=> mii read 1 2
001A
=> mii read 1 3
2205
=> mii read 2 0
read err 3
a2: read: EMAC_STACR=0xffffc040, i=4
Error reading from the PHY
2205
=> mii read 2 1
read err 3
a2: read: EMAC_STACR=0xffffc041, i=4
Error reading from the PHY
2205
=> mii read 2 2
read err 3
a2: read: EMAC_STACR=0xffffc042, i=4
Error reading from the PHY
2205
=> mii read 2 3
read err 3
a2: read: EMAC_STACR=0xffffc043, i=4
Error reading from the PHY
2205

My previously posted patch to fix the "even-numbered" problem will not
work in this case!


Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
