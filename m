Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5302BDDF95
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 08:01:05 +1100 (EST)
Date: Wed, 4 Mar 2009 15:00:55 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
Message-ID: <20090304210055.GA3694@loki.buserror.net>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
	<20090219184410.GB4180@ld0162-tx32.am.freescale.net>
	<547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
	<547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 25, 2009 at 06:09:32PM +1100, Daniel Ng wrote:
> On Fri, Feb 20, 2009 at 4:01 PM, Daniel Ng <daniel.ng1234@gmail.com> wrote:
> >
> > Now, I'm seeing these boot messages:
> >
> > f0010d40:00 not found
> > eth0: Could not attach to PHY
> > IP-Config: Failed to open eth0
> > IP-Config: Device `eth0' not found.
> >
> > Previous mailing list discussions suggest that I use the correct PHY,
> > which I am sure about because my 8272-based board only has the one PHY
> > ie. PHY0 with reg = <0x0>.
> >
> > Note the relevant parts of my Device Tree below. Currently, our PHY
> > attributes eg. 'auto-negotiate' are not changeable, so we aren't
> > actually using MDC+MDIO even the MDC+MDIO lines exist.

Your device tree is telling the kernel that you *are* using those lines.  If
they're not connected the way the device tree describes them as being
connected, you'll have to replace it with something that accurately
describes your hardware.

> > Also, the PHY interrupt line is not wired up. Hence the PHY0 interrupts
> > field is <0 8> (or should it be removed altogether?).

If your PHY interrupt is not connected, then you must remove the
"interrupts" property altogether.  "0" is a potentially valid interrupt
number.

-Scott
