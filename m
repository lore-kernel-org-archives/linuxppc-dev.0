Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 3D8D7DE23A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 20:56:24 +1000 (EST)
Date: Thu, 17 Jul 2008 11:56:14 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: dinesh <dinesh.dua@coraltele.com>
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
Message-ID: <20080717105614.GC15333@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
	<1216274611.18207.6.camel@dinesh.dua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216274611.18207.6.camel@dinesh.dua>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Nobin Mathew <nobin.mathew@gmail.com>, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:

> What i want is that i have a buffer in driver code which is also handled
> by some other application i want that this buffer data is to be used for
> capture and playback  stream fills data to another buffer which i can
> passover to my other application.

Depending on what exactly you're doing here you may find that this is
best implemented in user space with an ALSA plugin rather than doing it
as part of a driver.  If you do want to do this in kernel space then the
parts of an ASoC driver which transfer audio data are just the same as
those for any other ALSA driver so things like sound/arm/aaci.c may
provide useful examples.
