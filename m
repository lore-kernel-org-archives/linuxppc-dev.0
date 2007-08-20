Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id A95C5DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 23:17:06 +1000 (EST)
Date: Mon, 20 Aug 2007 15:13:46 +0200
From: Domen Puncer <domen@coderock.org>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20070820131346.GA2406@nd47.coderock.org>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070818100643.GA31233@nd47.coderock.org>
	<46C8643B.7010104@genesi-usa.com>
	<20070820083137.GJ13994@moe.telargo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20070820083137.GJ13994@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/08/07 10:31 +0200, Domen Puncer wrote:
> On 19/08/07 16:39 +0100, Matt Sealey wrote:
> > Domen,
> > 
> > Do it in a Forth script, or in nvramrc (after probe-all). Don't clutter
> > Linux with more fixups. The Efika PHY isn't going to change to something
> > else and it's a bog standard no-frills MII PHY anyway.
> 
> Fine with me, but I'm worried people won't update nvramrc.
> 
...
> But I have a problem with it, possibly due to my not-knowledge of Forth.
> Compatible keep getting set to:
> 	compatible            "/builtin/etherne"

I missed the encode-string.

Matt, can you please add attached Forth script to Efika updates.


	Domen

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=smart_firmware_phy

s" /builtin" find-device

new-device
	1 encode-int s" #address-cells" property
	0 encode-int s" #size-cells" property
	s" mdio" 2dup device-name device-type
	s" mpc5200b-fec-phy" encode-string s" compatible" property
	0xf0003000 0x400 reg

	0x2 encode-int
	0x5 encode-int
	0x3 encode-int
	encode+ encode+
	s" interrupts" property

	new-device
		s" ethernet-phy" 2dup device-name device-type
		0x10 encode-int s" reg" property

		my-self		\ save our phandle to stack
		ihandle>phandle
	finish-device
finish-device

s" /builtin/ethernet" find-device
	encode-int		\ phy's phandle
	s" phy-handle" property
device-end

--YiEDa0DAkWCtVeE4--
