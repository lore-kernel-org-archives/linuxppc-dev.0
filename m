Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9E665DDF60
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:08:41 +1000 (EST)
Date: Thu, 3 May 2007 11:10:00 -0500
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Message-ID: <20070503161000.GA31881@lixom.net>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178207725.17201.33.camel@ld0161-tx32>
From: olof@lixom.net (Olof Johansson)
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 10:55:25AM -0500, Jon Loeliger wrote:
> On Thu, 2007-05-03 at 09:44, Kumar Gala wrote:
> > On May 2, 2007, at 4:53 PM, Jon Loeliger wrote:
> > 
> > > From: Jason Jin <jason.jin@freescale.com>
> > >
> > > HD interface and AC97 interface share some pins and they are  
> > > enabled at
> > > the same time, In order to use AC97 interface, we need to disable  
> > > the HD
> > > interface first.
> > >
> > > Signed-off-by:Jason Jin<jason.jin@freescale.com>
> > > Acked-by: Jon Loeliger <jdl@freescale.com>
> > > ---
> > >  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > Is the HD feature not used at all?  Is there a AC97 Driver CONFIG_  
> > that makes sense to wrap that with?  Just wondering about the mutual  
> > exclusion (and how to provide flexibility to the user).
> > 
> > - k
> 
> 
> The ULI supports both the HD and AC97 interfaces, but the 8641
> only supports the AC97 interface.  Thus we can straight disable
> the HD and convert/configure the shared pins to be AC97.  Thus,
> there is no real CONFIG_ need at all.  It's only AC97.  And then
> ultimately, the presence of sound support is controlled by
> the ALSA config options as per normal.

This sounds like something that firmware should take care of, not
hardcoded in the board code.  Seems like the device is just a PCI device
that doesn't have a device tree entry.

Why not do this in u-boot instead?


-Olof
