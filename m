Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94AE3DDF95
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 01:55:33 +1000 (EST)
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1178207725.17201.33.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 03 May 2007 10:55:25 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 09:44, Kumar Gala wrote:
> On May 2, 2007, at 4:53 PM, Jon Loeliger wrote:
> 
> > From: Jason Jin <jason.jin@freescale.com>
> >
> > HD interface and AC97 interface share some pins and they are  
> > enabled at
> > the same time, In order to use AC97 interface, we need to disable  
> > the HD
> > interface first.
> >
> > Signed-off-by:Jason Jin<jason.jin@freescale.com>
> > Acked-by: Jon Loeliger <jdl@freescale.com>
> > ---
> >  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> Is the HD feature not used at all?  Is there a AC97 Driver CONFIG_  
> that makes sense to wrap that with?  Just wondering about the mutual  
> exclusion (and how to provide flexibility to the user).
> 
> - k


The ULI supports both the HD and AC97 interfaces, but the 8641
only supports the AC97 interface.  Thus we can straight disable
the HD and convert/configure the shared pins to be AC97.  Thus,
there is no real CONFIG_ need at all.  It's only AC97.  And then
ultimately, the presence of sound support is controlled by
the ALSA config options as per normal.

Thanks,
jdl
