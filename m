Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.228])
	by ozlabs.org (Postfix) with ESMTP id 735D2DE3D4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 07:09:50 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so834366qbd.39
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:09:49 -0700 (PDT)
Date: Thu, 31 Jul 2008 15:09:46 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Board level compatibility matching
Message-ID: <20080731210946.GC29834@secretlab.ca>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080731205906.GB17718@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080731205906.GB17718@ld0162-tx32.am.freescale.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 03:59:06PM -0500, Scott Wood wrote:
> On Thu, Jul 31, 2008 at 02:19:57PM -0600, Grant Likely wrote:
> > - Add a property to the device tree that explicitly specifies the SoC
> > that the board is based on.  Something like 'soc-model =
> > "fsl,mpc5200b"' would be appropriate.
> 
> Shouldn't that go in the compatible property of the soc node?

Not all SoC's (in particular 4xx SoCs) use an soc node.  Some of them
instead just describe the internal busses on the SoC.

> > - Prioritize board ports in the arch/powerpc/platforms directory to
> > identify level-1 machines support from the level-2 ones.  Make sure
> > that level-1 stuff always gets probed before level-2 stuff within each
> > SoC family.  In all likelyhood, this would probably just involve
> > making sure that board specific machines get linked in before the
> > catchall machine.
> 
> I don't think we're too far away from being able to have a catch-all that
> isn't even soc-type-specific -- the main things that come to mind are
> instantiating PCI controllers (should be easily fixed) and finding the
> root IRQ controller (I suppose we could pick a random interrupt
> controller and follow the interrupt tree to its root, though it'd be more
> robust if it were explicitly identified in the device tree).

Perhaps a root-interrupt-controller property?

g.
