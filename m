Return-Path: <jason@lakedaemon.net>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3D32F2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 03:24:11 +1000 (EST)
Date: Thu, 23 May 2013 13:23:39 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for
 Kirkwood SoCs
Message-ID: <20130523172339.GQ31290@titan.lakedaemon.net>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130523171112.GB31281@obsidianresearch.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Lennert Buytenhek <buytenh@wantstofly.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 23, 2013 at 11:11:12AM -0600, Jason Gunthorpe wrote:
> On Thu, May 23, 2013 at 12:01:11PM -0400, Jason Cooper wrote:
> > > > +	/* Kirkwood resets some registers on gated clocks. Especially
> > > > +	 * CLK125_BYPASS_EN must be cleared but is not available on
> > > > +	 * all other SoCs/System Controllers using this driver.
> > > > +	 */
> > > > +	if (of_machine_is_compatible("marvell,kirkwood"))
> > > > +		wrlp(mp, PORT_SERIAL_CONTROL1,
> > > > +		     rdlp(mp, PORT_SERIAL_CONTROL1) & ~CLK125_BYPASS_EN);
> > > 
> > > of_machine_is_compatible seems heavy handed, I would expect this to be
> > > based on the compatible string of the ethernet node itself, not the
> > > machine??
> > 
> > Is there a model number variation between IP that needs this and IP that
> > doesn't?  If not, I'm fine with of_machine_is_compatible().
> 
> Well the name 'mv643xx' is a family of system controller SOC's
> from ages ago, it seems reasonble to continue the trend and label the
> IP variations with the SOC name:
> 
>  compatible = "marvell,kirwood,ethernet", "marvell,mv643xx_eth"

Shouldn't it rather be

	compatible = "marvell,kirkwood-eth", "marvell,orion-eth";

I'm inclined to go with of_machine_is_compatible() since the only
concrete difference we know is that the tweak is needed on kirkwood and
nowhere else.

If we had an errata, or a datasheet saying specifically flavor X needs
this and none other does, then we could trigger on the ethernet node
compatible string or a boolean in the node.  But we don't have that...

thx,

Jason.
