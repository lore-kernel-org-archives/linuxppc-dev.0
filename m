Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.238])
	by ozlabs.org (Postfix) with ESMTP id 03727DE22A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:23:41 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2348248qbc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:23:40 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:23:17 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com, timur@freescale.com
Subject: Re: [PATCH v3 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080722212316.GC12412@secretlab.ca>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065358.7306.9412.stgit@trillian.secretlab.ca>
	<20080722100951.GB2572@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722100951.GB2572@rakim.wolfsonmicro.main>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 11:09:52AM +0100, Mark Brown wrote:
> On Tue, Jul 22, 2008 at 12:53:58AM -0600, Grant Likely wrote:
> 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> There's a few issues that were raised on the previous review cycle that
> still need to be addressed but they should be fixable in incremental
> patches (and easier to review that way):
> 
> > +static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
> 
> > +		spin_lock_irqsave(&psc_i2s->lock, flags);
> > +		/* first make sure it is low */
> > +		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0)
> > +			;
> > +		/* then wait for the transition to high */
> > +		while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) == 0)
> > +			;
> 
> These loops should really have some sort of time limit on them,
> otherwise they'll lock hard if the expected events don't happen.  Given
> that in slave mode they're synchronising with an externally generated
> clock this is something that might happen in practice and should produce
> better diagnostics.

Yes, I hope to rework these two lines entirely.  I'm not happy with the
current implementation either.

> > +	default:
> > +		dev_dbg(psc_i2s->dev, "invalid command\n");
> > +		return -EINVAL;
> > +	}
> 
> I'd really expect to see the other possible triggers handled, even if
> the appropriate action is to silently ignore them, rather than having
> them generate an error message.

Okay, I'll do that.

g.
