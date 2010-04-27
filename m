Return-Path: <lgirdwood@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id D1275B7D24
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 18:07:10 +1000 (EST)
Received: by wwb18 with SMTP id 18so1506731wwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 01:07:08 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1272350168.24542.6.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 09:07:04 +0100
Message-ID: <1272355624.3204.52.camel@odin>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 16:36 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2010-04-26 at 15:49 -0500, Timur Tabi wrote:
> > An upcoming change in the architecture of ALSA SoC (ASoC) will require the
> > MPC8610 HPCD's ASoC fabric driver to register as a standard platform driver.
> > Therefore, we need to call platform_device_register_simple() from the board's
> > platform code.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> 
> Gross. Loses the linkage to device-tree etc... which is useful for audio
> especially. You should at least make sure the device node follows for
> the target driver to be able to use it :-) I'd like you to sync with
> Grant work on that matter if you are going to convert of_devices into
> platform_devices.

Timur, please correct my device tree understanding form our IRC
conversation if I'm wrong here.

I think one of the difficulties encountered here is that the device tree
root for sound in this case is the SSI (Digital Audio Interface)
controller and not the sound card as in ASoC. So maybe the problem is
how do we represent an ASoC sound card in the device tree ?

The sound card within ASoC is a compound device that is made up of the
SSI, Codec and audio DMA engine components. The SSI/Codec/DMA components
do not have to be the sound cards child devices wrt the driver model but
do register with the ASoC core and are 'joined' with each other and the
sound card driver to form a working audio device.

Now I don't know the mechanics of adding an ASoC sound card to the
device tree, but the device tree should be able to define an ASoC sound
card and also represent the relationships between the sound card and the
SSI/Codec/DMA components. The components should also be represented in
the device tree. Parsing the device tree should probe() all the ASoC
components and sound card. The ASoC core would then instantiated them as
a sound device.  

Thanks

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
