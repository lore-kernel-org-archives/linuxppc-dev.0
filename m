Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C29BBB7D5F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 10:50:28 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur.tabi@gmail.com>
In-Reply-To: <j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 10:50:14 +1000
Message-ID: <1272502214.24542.133.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2010-04-28 at 15:35 -0500, Timur Tabi wrote:
> Second, how about this binding for the virtual sound node?  It would
> be a root-level node.
> 
>         sound-devices {
>                 sound0 {
>                         ssi = &ssi0;
>                         playback-dma = &dma00;
>                         capture-dma = &dma01;
>                         codec = &cs4270;
>                 }
>         }; 

Make sure you also have a "compatible" property to uniquely identify the
design. You could use the toplevel board one but I'd rather keep a
separate one here. I've seen case where the exact same base board may
have different sound components (because they are dautherboards for
example, but there's a few other cases). 

Cheers,
Ben.
