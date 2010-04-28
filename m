Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id DB179B7BEE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 06:36:03 +1000 (EST)
Received: by pxi18 with SMTP id 18so2733623pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 13:36:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1272362955.24542.24.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 28 Apr 2010 15:35:32 -0500
Message-ID: <j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 5:09 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Keep in mind that it's perfectly kosher to create nodes for "virtual"
> devices. IE. We could imagine a node for the "sound subsystem" that
> doesn't actually correspond to any physical device but contain the
> necessary properties that binds everything together. You could even have
> multiple of these if you have separate set of sound HW that aren't
> directly dependant.

First, I want to officially retract this patch.  I've talked with
Grant, and we've come up with a different approach to this problem.

Second, how about this binding for the virtual sound node?  It would
be a root-level node.

	sound-devices {
		sound0 {
			ssi = &ssi0;
			playback-dma = &dma00;
			capture-dma = &dma01;
			codec = &cs4270;
		}
	};

-- 
Timur Tabi
Linux kernel developer at Freescale
