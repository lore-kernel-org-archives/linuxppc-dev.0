Return-Path: <scottwood@freescale.com>
Date: Thu, 31 Jul 2008 15:59:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Board level compatibility matching
Message-ID: <20080731205906.GB17718@ld0162-tx32.am.freescale.net>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 02:19:57PM -0600, Grant Likely wrote:
> - Add a property to the device tree that explicitly specifies the SoC
> that the board is based on.  Something like 'soc-model =
> "fsl,mpc5200b"' would be appropriate.

Shouldn't that go in the compatible property of the soc node?

> - Prioritize board ports in the arch/powerpc/platforms directory to
> identify level-1 machines support from the level-2 ones.  Make sure
> that level-1 stuff always gets probed before level-2 stuff within each
> SoC family.  In all likelyhood, this would probably just involve
> making sure that board specific machines get linked in before the
> catchall machine.

I don't think we're too far away from being able to have a catch-all that
isn't even soc-type-specific -- the main things that come to mind are
instantiating PCI controllers (should be easily fixed) and finding the
root IRQ controller (I suppose we could pick a random interrupt
controller and follow the interrupt tree to its root, though it'd be more
robust if it were explicitly identified in the device tree).

-Scott
