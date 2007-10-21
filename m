Return-Path: <timur@freescale.com>
Message-ID: <471B550F.3090907@freescale.com>
Date: Sun, 21 Oct 2007 08:33:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Device trees and audio codecs
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
In-Reply-To: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> I'm working on ALSA ASoC support for a codec chip on my mpc5200 based
> target hardware. How should the codec be represented in the device
> tree?

I'm also working on an ASoC driver, but for the 8610.  I have a similar problem.

> Under ASoC the device drivers for the codec chips are platform
> independent.  In the current ASoC model there are three device
> drivers: i2s (or spi, etc), the generic codec, and a platform specific
> 'fabric' driver.  Some codecs are linked to both i2c and i2s.

Annoying, isn't it? :-)

You can use phandles to cross-reference nodes.  I suggest putting the codec 
node under the i2s node (and containing I2S-specific information), and then 
putting another codec node under the i2c node (this is a new layout proposed 
by Scott Wood), and use a phandle to let the i2s-codec node point to the 
i2c-codec node.

> The fabric driver corresponds to the 'layout-id' in the Apple model.
> It tells how to configure the generic codec driver for the specific
> configuration needed by the actual platform hardware.
> 
> For development purposes I'm using an Efika as a target platform. It
> is easy enough to load the i2s driver using the device tree. I can add
> entries to the i2s node to trigger loading of the generic sta9766
> codec driver. How do I trigger loading the Efika specific fabric
> driver?

You don't need a device tree entry to trigger loading a driver.  You can just 
load the driver and initialize it in its __init function.

However, in this case, you might want to do what I'm doing -- putting a probe 
function in the fabric driver for the i2s device (which gets its own node 
under the SOC node), and then in that probe function search for all the other 
nodes that you need.

> My target hardware has a codec that is linked to both i2s and i2c. How
> should it be represented?
> 
> Apple has three entries. One for i2s, one for the codec, and one for
> soundchip. What is the soundchip entry, does it correspond to real
> hardware?

Since the Apple audio drivers are not ASoC drivers, I suggest we don't pay 
attention to what they do.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
