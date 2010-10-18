Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AC67B70D0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 03:42:22 +1100 (EST)
Received: from mail47-va3 (localhost.localdomain [127.0.0.1])	by
	mail47-va3-R.bigfish.com (Postfix) with ESMTP id 2E60A1318212	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 16:42:18 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.252])	by
	mail47-va3.bigfish.com (Postfix) with ESMTP id CEC0919B805A	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 16:42:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9IGgFEQ014316	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 09:42:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9IGgFKY011281	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 11:42:15 -0500 (CDT)
Date: Mon, 18 Oct 2010 11:42:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
Message-ID: <20101018114214.2e72a616@udp111988uds.am.freescale.net>
In-Reply-To: <4CBC080A.7030005@windriver.com>
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
	<4CBC080A.7030005@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 18 Oct 2010 16:40:42 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> Shawn Jin wrote:
> > Hi,
> > 
> > My target is a mpc875 based board and has FEC ethernet. The phy is
> > AM79C874. I have the following configuration for the network support.
> > 
> > CONFIG_PHYLIB=y
> > CONFIG_NET_ETHERNET=y
> > CONFIG_MII=y
> > CONFIG_FS_ENET=y
> > CONFIG_FS_ENET_HAS_FEC=y
> > CONFIG_FS_ENET_MDIO_FEC=y
> > 
> > However I found that the phy support (AM79C874) is actually in
> > drivers/net/fec.c which is compiled only when CONFIG_FEC=y. However
> 
> The phy driver should not be embedded into the NIC driver in theory.

Right, those are handled by drivers/net/phy/.

> I think you should include the phy driver, mdio-bitbang.c, which should be
> support AMD79C874.

On MPC8xx you want drivers/net/fs_enet/mii-fec.c.  This is just the
MDIO driver; it doesn't handle any particular PHY.  I don't know if
there is a driver specifically for AM79C874, though the generic PHY
support may be good enough.

-Scott
