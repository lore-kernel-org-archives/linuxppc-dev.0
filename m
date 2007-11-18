Return-Path: <matt@genesi-usa.com>
Message-ID: <4740C0E3.5080704@genesi-usa.com>
Date: Sun, 18 Nov 2007 22:46:59 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
In-Reply-To: <9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> 
> The codec-fabric node was just being used to trigger the loading of
> the platform specific driver.

Just remember one thing.

1) the term "fabric" when coined for audio drivers is a new, ALSA SoC
specific term. It isn't relevant for anything but ALSA SoC drivers.

2) this device tree stuff will end up in more than Linux device trees

3) you're going to piss off Open Firmware developers by specifying
very Linux-specific features in a device tree the same way Apple
pissed off Linux developers by encoding MacOS X-specific features in
the device tree.

Audio driver control like this has to be very specific for a good
reason; you can do it a billion ways to Sunday. I'd suggest basically
that if you must control a device in a way that needs to be defined by
a device which can change address (either dynamically on boot or by
board design change - per revision, for example, or with a change of
controller) then simply use the device tree to report this address
so that you can have the same basic fabric driver (all in Linux) which
can handle minor modifications of your board design.

If you require the codec to be subservient to some "fabric" then I
suggest you make a "sound" node with a compatible entry which is
defined as something specific to your board (digispeaker,audio) and
let your driver pick that up and then switch on the model (rather like
Apple's layout-id) of that device to pick out the specifics of that
fabric. If it needs an audio codec (ac97 or i2s) and a control
interface (i2c or spi) then it knows which ones it is looking for
based on the model.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
