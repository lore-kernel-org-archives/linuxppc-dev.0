From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aurel Wisse <aurel_wisse@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	yddev <yellowdog-devel@lists.terrasoftsolutions.com>
Subject: Re: Sungem with iMac Rev-B
Date: Mon, 29 Apr 2002 15:26:37 +0200
Message-Id: <20020429132638.29518@smtp.adsl.oleane.com>
In-Reply-To: <20020429004945.83544.qmail@web14804.mail.yahoo.com>
References: <20020429004945.83544.qmail@web14804.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Crossposted yellowdog-devel/linuxppc-devel, sorry but
>this is last ditch...
>
>I have read several comments about the sungem driver
>being preferred to the bmac(+) driver.
>
>Going through the sourcecode of the sungem, I am not
>sure however that it will work with older hardware
>like the iMac Rev-B's Uni-North and the LXT970.

No, you mismatched bmac and gmac. The sungem driver obsoletes
the gmac one, not the bmac one.

The bmac driver currently don't have PHY control. This could
eventually be added, since I beleive we actually know how to
tap the PHY registers when available. Though this need some
work and I have no hardware to test on, so I'd rather see
someone who has do the job ;)

What we need is to add some proper PHY polling infrastructure
to the bmac driver (shouldn't be a big issue), then find out
the list of known PHYs used on Macs (I beleive the darwin source
code would be helpful here) and see how each of them can be
configured. If they aren't too crappy, the register setting for
enabling 10/100, half/full and autoneg are standard.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
