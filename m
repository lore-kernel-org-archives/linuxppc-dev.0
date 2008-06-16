Return-Path: <ron_madrid@sbcglobal.net>
Received: from n3a.bullet.mail.ac4.yahoo.com (n3a.bullet.mail.ac4.yahoo.com
	[76.13.13.66]) by ozlabs.org (Postfix) with SMTP id 5CE96DE387
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 05:17:21 +1000 (EST)
Date: Mon, 16 Jun 2008 12:10:40 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4856B3B4.9020206@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <329782.75894.qm@web83515.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you for the help (again).  I've got my driver registering the isr on it's own now.  In the
end the problem was the dts and also not using irq_of_parse_and_map.

Ron
--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > I don't see a "dma" node in the mpc8377mds.dts (2.6.25).  I found one in mpc8610_hpcd.dts and
> > modeled it after that.
> 
> Try head-of-tree.
> 
> > 		dma@82a8 {
> > 			#address-cells = <1>;
> > 			#size-cells = <1>;
> > 			compatible = "fsl,elo-dma";
> > 			cell-index = <0>;
> > 			reg = <0x82a8 0x4>; /* DMA general status register */
> > 			ranges = <0x0 0x8100 0x200>;
> 
> Should also put the interrupts in the dma node itself, so that the 
> driver can register it once and use the shared status register (but 
> don't remove it from the individual channels).
> 
> -Scott
> 
