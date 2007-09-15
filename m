Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 6BF30DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 22:23:22 +1000 (EST)
Date: Sat, 15 Sep 2007 14:22:18 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
Message-ID: <20070915122218.GB19857@nd47.coderock.org>
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
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

On 15/09/07 00:28 -0400, Jon Smirl wrote:
> On 9/14/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > This patch doesn't seem to working quite right on my hardware (Phytec
> > pcm030). At boot I get a long pause.
> 
> It also doesn't compile if  CONFIG_FEC_MPC52xx_MDIO is undefined.

Right, darn.
Try this one: http://coderock.org/tmp/fec-v3rc1/

Does it work without phy-handle in device tree, but
with this part being unconditional (fec.c):
 709 //        if (priv->has_phy)
 710                 rcntrl |= FEC_RCNTRL_MII_MODE;

This effectively disables phy part of the driver,
but still allows hardware to use PHY/MII.

I am puzzled by the symptoms you see.


	Domen

> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
