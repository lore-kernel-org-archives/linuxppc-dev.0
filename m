Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 9B6AEDDF09
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 02:30:35 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so259327yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 09:30:34 -0700 (PDT)
Date: Thu, 3 Jul 2008 10:30:00 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080703163000.GI2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020819sdb6f442q75dc7f10f9f605a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807020819sdb6f442q75dc7f10f9f605a5@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:19:18AM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +               /* Due to errata in the i2s mode; need to line up enabling
> >  +                * the transmitter with a transition on the frame sync
> >  +                * line */
> >  +
> >  +               spin_lock_irqsave(&psc_i2s->lock, flags);
> >  +               /* first make sure it is low */
> >  +               while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0);
> 
> Could this be moved to the front of the routine, to increase parallelism?
> 
> Once you detect the 0, it will be a fixed interval before the 1
> happens. Might as well overlap the computations.
> 

Good point.  I'll try this out and see if it remains stable.  If this
gets done wrong, then left and right channels will often get swapped.

g.
