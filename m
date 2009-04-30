Return-Path: <kyle@moffetthome.net>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 40BD6DDFBA
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 01:33:33 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1044202yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 08:33:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904300811u41e94972offfd75520636bb02@mail.gmail.com>
References: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
	<625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
	<f73f7ab80904201710m57472291yf7ff86760977b8e8@mail.gmail.com>
	<1240388476.17445.10.camel@pasglop>
	<f73f7ab80904300804j1f847b70ha0fe3cda07249110@mail.gmail.com>
	<fa686aa40904300811u41e94972offfd75520636bb02@mail.gmail.com>
Date: Thu, 30 Apr 2009 11:33:31 -0400
Message-ID: <f73f7ab80904300833w69025c2fjdefbe9f2eef323f1@mail.gmail.com>
Subject: Re: Porting the ibm_newemac driver to use phylib (and other PHY/MAC
	questions)
From: Kyle Moffett <kyle@moffetthome.net>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 11:11 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Just a heads up Kyle; there are changes queued in the netdev tree
> which add OF helpers for MDIO bus drivers and MAC drivers. =C2=A0See here=
:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-next-2.6.git;a=3Dco=
mmit;h=3D8bc487d150b939e69830c39322df4ee486efe381
>
> and here is an example of a driver change:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-next-2.6.git;a=3Dco=
mmit;h=3D1dd2d06c0459a2f1bffc56765e3cc57427818867

Hmm, very interesting!  Thanks!  Although I'm not sure that those OF
helpers are entirely usable for the emac driver at the moment, as the
device trees for the existing boards simply don't have PHYs present in
them.  Most of the ibm_newemac board device-trees just have one of:
"phy-address =3D <4>", "phy-mask =3D <0xffff0000>", or nothing at all (for
autodetection).  I will probably need to leave in support for the old
PHY mask parsing to preserve backwards compatibility.

My main concern at the moment is cleaning up the driver's general PHY
handling.  I got started on this whole mess when I was trying to write
some hackish PHY drivers for a weird custom board I've got here.  I
couldn't figure out why the hell all my PHY register changes in the
phy_ops->init function kept getting cleared, until I noticed 2 things:
 The emac_reset_phy() function gets called occasionally and does not
call the ->init() function again afterwards.  The
genmii_setup_forced() function (in the EMAC driver) unconditionally
ORs the BCMR_RESET flag into the MII_BCMR register.  Both of those
meant that any early setup I did for my PHY was getting completely
cleared on a regular basis, with no decent way for me to patch it back
up again.

Cheers,
Kyle Moffett
