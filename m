Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 7129C68748
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:15:00 +1100 (EST)
Date: Thu, 17 Nov 2005 16:14:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Updegraff <dave@cray.com>
Message-ID: <20051117161458.A8071@cox.net>
References: <437CFB43.4060400@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437CFB43.4060400@cray.com>;
	from dave@cray.com on Thu, Nov 17, 2005 at 03:50:59PM -0600
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: gianfar generic PHY assumptions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2005 at 03:50:59PM -0600, David Updegraff wrote:
> Hi.
> 
> This patch lets gianfar work on 83xx (or 85xx??) boards that have 
> Generic PHYs on them that do _NOT_ happen to have an IRQ line wired to 
> external_15.  Surely reasonable that if we can't ID the PHY that its 
> probably not irq-wired the Freescale-ADS "way"...
> 
> It was critical for us; perhaps usefull for others.

Aside from the fact that the patch doesn't apply against the
current kernel due to the change of gianfar to use the phy
layer...why wouldn't you just set the board_flags field
appropriately in your board port? If you don't use a phy interrupt
then don't set the flag claiming that you do.  stx_gp3.c doesn't
make use of the phy interrupt functionality, as an example.

I looked at an older kernel and I'm not sure where you see external
15 being used. It seems to be EXT5 on all the Fscale boards.

-Matt
