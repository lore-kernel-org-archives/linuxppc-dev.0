Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 601C7140097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 13:36:12 +1100 (EST)
Date: Thu, 27 Mar 2014 10:29:36 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Add isr to deal with error
 flag
Message-ID: <20140327022934.GA16197@MrMyself>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E958E@AcuExch.aculab.com>
 <20140327011424.GB30768@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140327011424.GB30768@sirena.org.uk>
Cc: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2014 at 01:14:24AM +0000, Mark Brown wrote:
> On Wed, Mar 26, 2014 at 11:59:53AM +0000, David Laight wrote:
> > From: Nicolin Chen
> 
> > > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> 
> > Assuming these are 'write to clear' bits, you might want
> > to make the write (above) and all the traces (below)
> > conditional on the value being non-zero.
> 
> The trace is already conditional?  I'd also expect to see the driver
> only acknowledging sources it knows about and only reporting that the
> interrupt was handled if it saw one of them - right now all interrupts
> are unconditionally acknowleged.

Will revise it based on the comments from both of you.

Thank you.


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
