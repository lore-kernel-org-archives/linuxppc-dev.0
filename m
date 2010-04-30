Return-Path: <timur.tabi@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 8040CB7D2F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 07:47:28 +1000 (EST)
Received: by pvh11 with SMTP id 11so114983pvh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 14:47:27 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1272381611.11000.39.camel@odin>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 30 Apr 2010 16:46:57 -0500
Message-ID: <t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Liam Girdwood <lrg@slimlogic.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 10:20 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote=
:

>> Another problem is that ASoC won't let me probe the DMA channels
>> independently. =A0That is, I cannot tell ASoC that I have a playback DMA
>> and a capture DMA. =A0ASoC does not recognize two DMA devices for a
>> single SSI. =A0If you can fix that, then I can turn the DMA driver into
>> an OF driver.
>>
>
> Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
> can only do one direction (either Playback or Capture). So I'm thinking
> we create two DAI link entries for your sound card (one for playback and
> the other for capture) and they both use the same SSI device but each
> would have it's own DMA device.
>
> This would result in two separate pcm devices being exported to
> userspace i.e one for playback only and the other for capture only. I
> think this is also a more accurate representation of your hardware too
> (since we have different DMA devices for each pcm stream direction).

Ok, I'm trying to do this now, and I'm running into problems.

So here's the device list:

One machine
One SSI
Two DMA channels
One codec

So I create two dai_links in the machine driver.  Each dai_link has
two DAIs in it.  The DAIs are identical, except for the platform_drv
field.  The platform_drv in the first DAI points to the first DMA
channel, and the platform_drv of the second DAI points to the second
DMA channel.

When I boot Linux, I get this:

asoc: cs4270 <-> /soc@e0000000/ssi@16000 mapping ok
sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270=
'

so it looks like when asoc is processing the dai_link, it tries to
create a sysfs device for the codec twice.

How do I avoid this?

--=20
Timur Tabi
Linux kernel developer at Freescale
