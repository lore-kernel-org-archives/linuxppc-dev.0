Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42E8FB7D5C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 07:11:21 +1000 (EST)
Date: Tue, 27 Apr 2010 22:11:18 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
Message-ID: <20100427211118.GD15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<20100427205924.GC15083@opensource.wolfsonmicro.com>
	<4BD7511F.7090201@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BD7511F.7090201@freescale.com>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 04:03:27PM -0500, Timur Tabi wrote:

[Reflowing the text into 80 columns again]

> Mark Brown wrote:
> > It's entirely possible that if the board designer intended the verious
> > SSIs to be used in concert they've done something like cross wire the
> > clocks which creates a board-specific interrelationship that needs to be
> > dealt with.

> Fine, but I don't see how that can be handled with the current code.
> Each SSI is independent, and audio is streamed to it via DMA.  The
> current SSI driver would need to be completely rewritten in order to
> initiate both DMA operations simultaneously.  The clocking is the least
> of my problems.

I believe the usual technique is to start the DMA then clock the bus -
data doesn't flow over the bus until the clock appears and that appears
everywhere simultaneously.  Obviously some hardware really doesn't like
having the DMA blocked like that, but not all.
