Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11A1BDDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 04:35:30 +1000 (EST)
Date: Sun, 24 May 2009 19:35:15 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524183515.GC4525@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090524110854.GB4933@sirena.org.uk>
	<9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 0/9] mpc5200 audio rework for AC97
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 11:21:15AM -0400, Jon Smirl wrote:

> My AC97 driver is detecting the codec id and printing it before trying
> to access the codec driver. I can convert that to a load_module() call
> when the drivers are ready.

No, your AC97 driver shouldn't be doing any of this at all - it should
be leaving any enumeration of the hardware up to the machine driver and
the core.  In so far as it is standardised the process for probing AC97
is something that can be implemented in terms of the operations exported
by the DAI so it should be done in the core for all AC97 DAIs.  Where
standardised probing can't work it needs to be machine specific anyway.
