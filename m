Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 May 2008 17:01:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Usedcrinfrastructure.
Message-ID: <20080508070128.GA22453@yookeroo.seuss>
References: <1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
	<fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
	<20080506061444.GB17798@yookeroo.seuss>
	<20080506174352.52C857D805C@mail62-va3.bigfish.com>
	<20080508015948.GG5156@yookeroo.seuss>
	<20080508044652.98467AA8064@mail133-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080508044652.98467AA8064@mail133-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 07, 2008 at 09:46:51PM -0700, Stephen Neuendorffer wrote:
> 
> The problem is that the tft driver currently in mainline assumes
> that the dcr control registers are accessed through mmio, and probes
> for a reg=<> property.  Since the device is actually a dcr device,
> it can be connected via mmio through a bride, or to the native dcr
> bus of the processor.  For the time being, I'd like to generate
> device trees compatible with either mechanism.

Ah, I think I see.  The current driver expects the device to be
represented as if it were an mmio device, not using the standard dcr
notation.  It can get away with this because the DCRs are
memory-mapped, in a way representable by 'ranges'.

> so, the problem is that the tree-parents of the tft node all have
> ranges, and if the dcr-parent of the node is a bridge, then it has a
> reg=<> property, But if the dcr-parent is also a tree-parent, then
> it has to have ranges; and a reg=<> property, which seems very
> strange, and not something I think is a good thing to do.

This I don't follow.

But I don't think it matters.  The representation suggested by Segher,
which has the DCR addressing redundantly described in 'reg' and
'dcr-reg' properties should work for you.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
