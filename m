Date: Fri, 8 Feb 2002 12:01:40 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405gp enet Soft Reset
Message-ID: <20020208120140.B27732@ecam.san.rr.com>
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com> <3C63AE1A.7000907@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C63AE1A.7000907@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 08, 2002 at 10:53:14AM +0000, Armin wrote:
> Andrew & Stefan,
>
> The softrest could probably be removed from the _init.  its dup'd in _open.

Here is another problem I have with find_phy, that it seems that mii reads to
reg 2 of a non-existent address does not return an error but a read to reg 3
does.

Here is a log from ppcboot since it is easy to test this there without doing
a kernel build. My phy is at address 0x1f.

=> mii read 0x1 2
07FF
=> mii read 0x1 3
read err 3
a2: read: EMAC_STACR=0xffffc023, i=2
Error reading from the PHY
07FF


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
