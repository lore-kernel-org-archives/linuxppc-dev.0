Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B30051A0648
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 19:55:55 +1000 (EST)
Date: Thu, 7 Aug 2014 17:44:05 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Message-ID: <20140807094404.GB3088@MrMyself>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <20140807094527.GC17528@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140807094527.GC17528@sirena.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Li.Xiubo@freescale.com, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2014 at 10:45:27AM +0100, Mark Brown wrote:
> On Tue, Aug 05, 2014 at 03:32:05PM +0800, Nicolin Chen wrote:
> > From: Nicolin Chen <Guangyu.Chen@freescale.com>
> > 
> > SAI supports these operation modes:
> > 1) asynchronous mode
> >    Both Tx and Rx are set to be asynchronous.
> > 2) synchronous mode (Rx sync with Tx)
> >    Tx is set to be asynchronous, Rx is set to be synchronous.
> > 3) synchronous mode (Tx sync with Rx)
> >    Rx is set to be asynchronous, Tx is set to be synchronous.
> > 4) synchronous mode (Tx/Rx sync with another SAI's Tx)
> > 5) synchronous mode (Tx/Rx sync with another SAI's Rx)
> 
> This seems to conflict with something else on my branch - not checked
> what.  Can you take a look please?

Ah...there is another patch that should haven been merged into for-next
is currently missing on the remote branch.

This one:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/079689.html
 
> > +Note:
> > +- If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
> > +  default synchronous mode (sync Rx with Tx) will be used, which means both
> > +  transimitter and receiver will send and receive data by following clocks
> > +  of transimitter.
> > +- fsl,sai-asynchronous will be ignored if fsl,sai-synchronous-rx property is
> > +  already present.
> 
> Might be worth printing an error here.

Hmm...Do I need to send a v2?

Thank you
Nicolin
