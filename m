Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8F0CDE108
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 20:51:47 +1000 (EST)
Date: Mon, 25 May 2009 11:51:40 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio DMA code
Message-ID: <20090525105140.GF18290@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
	<9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
	<200905250956.28206.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200905250956.28206.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 09:56:27AM +0200, Juergen Beisert wrote:

> Do you know this (from our website)?

> "The AC97 mixer needs a hardware patch to make it wake up from power down 
> mode. Download here the instruction how to do so."

> http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/TN-015e_1.pdf

This modification should not be required - a warm reset should be enough
to bring the AC97 link up.  The current ASoC driver for the WM9712 will
do this automatically - the expectation for non-ASoC systems is that the
warm reset will always be issued.

That said, I'd be surprised if it were the same problem given that
iterating cold resets appears to resolve whatever the issues is.
