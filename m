Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47815DDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 00:37:25 +1100 (EST)
Date: Mon, 7 Jan 2008 13:37:17 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080107133716.GA6497@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<477BA974.8010308@freescale.com>
	<20080102172340.GA2007@sirena.org.uk>
	<477D280C.4000800@freescale.com>
	<20080103230004.GA18709@sirena.org.uk>
	<477EEEC5.9050603@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477EEEC5.9050603@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 08:43:17PM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> In other words, ...

> clock1 = <0, bb8000>
> clock2 = <1, 653230>
> clock23 = <0, ab2372>

Yes, something like that would cover it.  I'm not sure what is idiomatic
for the device tree.

> > and of course the ordering matters.  

> Ok, you got me there.  But then, isn't this just another example where the 
> device tree is incapable of describing a complex configuration, and so we need 
> a platform driver?

Yes, you could certainly do that - as you say, any device tree based
configuration would be optional so it's not a blocker if some things
aren't supported.

It'd be nice to have some idea of how to handle it should someone want
to do it but I wouldn't think it's essential.  The most common case
where specific ordering is required is that a PLL will need to have all
its inputs configured before the PLL is activated so it'd probably cover
a large proportion of cases to do that last.

> > Indeed.  Providing the device tree stuff doesn't get set in stone I'm
> > not sure we need to nail this down perfectly for ASoC v1 when we're
> > running into trouble working around it.

> I definitely agree with that.  I'll be the first to admit that this driver, 
> much like ASoC V1, is a prototype.

Yes, from an ASoC point of view the driver looks good as it is.  The
only discussion is about the PowerPC probing stuff.
