To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fix for autonegotiation of ppc 40x ethernet driver
References: <m3brss87p4.fsf@gandalf.peppercon.de>
	<1065602490.30751.84.camel@gaston>
From: Ronald Wahl <rwa@peppercon.com>
Date: Wed, 08 Oct 2003 10:51:36 +0200
In-Reply-To: <1065602490.30751.84.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 08 Oct 2003 10:41:31 +0200")
Message-ID: <m365j0863r.fsf@gandalf.peppercon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 08 Oct 2003 10:41:31 +0200, Benjamin Herrenschmidt wrote:

> On Wed, 2003-10-08 at 10:17, Ronald Wahl wrote:
>> Hello,
>>
>> I have found a bug in the ethernet driver for the PPC 40x. The problem
>> is that the driver doesn't deal correctly if a user wants a limited
>> advertising range (via ethtool interface) - lets say 10Mbps/Halfduplex
>> and 10MBps/Fullduplex. The link always enters 100MBps/Fullduplex mode if
>> the link partner supports it. This is an incorrect behavior. I appended
>> a fix for this (against 2.4.22+ of the linuxppc 3.4 devel tree). It
>> would be nice if this change could be reviewed and incorporated into the
>> official code. If any questions arise - just ask...

> Hi !

> There may well be a bug in the code, but I'm not sure this is
> the proper fix. When setting up a forced mode, I'm not sure it's

I wont force a single mode. I want to limit the advertising to a
limited _range_. So autonegotiation is still enabled - just with a
limited range. The forcing of a mode (i.e. disabling autonegotiation)
is working already without this patch.

> worth playing with advertise at all in fact... Just having the
> link up shall be enough if aneg is disabled, we could ignore
> LPA/ADVERTISE completely. Or maybe just read back BMCR from
> read_link...

- ron

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
