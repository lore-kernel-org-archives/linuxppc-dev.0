Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
Date: Sat, 20 Oct 2007 11:33:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: Device trees and audio codecs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm working on ALSA ASoC support for a codec chip on my mpc5200 based
target hardware. How should the codec be represented in the device
tree?

Under ASoC the device drivers for the codec chips are platform
independent.  In the current ASoC model there are three device
drivers: i2s (or spi, etc), the generic codec, and a platform specific
'fabric' driver.  Some codecs are linked to both i2c and i2s.

The fabric driver corresponds to the 'layout-id' in the Apple model.
It tells how to configure the generic codec driver for the specific
configuration needed by the actual platform hardware.

For development purposes I'm using an Efika as a target platform. It
is easy enough to load the i2s driver using the device tree. I can add
entries to the i2s node to trigger loading of the generic sta9766
codec driver. How do I trigger loading the Efika specific fabric
driver?

My target hardware has a codec that is linked to both i2s and i2c. How
should it be represented?

Apple has three entries. One for i2s, one for the codec, and one for
soundchip. What is the soundchip entry, does it correspond to real
hardware?

/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000:
name             "i2s-a"
device_type      "soundbus"
compatible       "i2sbus"
built-in
reg              00010000 00001000 00008000 00000100 00008100 00000100
interrupts       0000001e 00000001 00000001 00000000 00000002 00000000
interrupt-parent ff981a38
platform-headphone-mute ff9828a0
platform-amp-mute ff9829f8
platform-hw-reset ff982b48
platform-linein-detect ff982c98
platform-headphone-detect ff982e58
platform-get-enable ff97c3b0
platform-enable  ff97c3b0
platform-disable ff97c3b0
platform-get-clock-enable ff97c3b0
platform-clock-enable ff97c3b0
platform-clock-disable ff97c3b0
platform-get-sw-reset ff97c3b0
platform-clear-sw-reset ff97c3b0
platform-sw-reset ff97c3b0
platform-get-cell-enable ff97c3b0
platform-cell-enable ff97c3b0
platform-cell-disable ff97c3b0
linux,phandle    ff985b88

/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound:
name             "sound"
device_type      "soundchip"
compatible       "AOAbase"
built-in
layout-id        00000046 (70)
object-model-version 00000002
vendor-id        0000106b (4203)
platform-tas-codec-ref ff98cba8
linux,phandle    ff985d48

/proc/device-tree/pci@f2000000/mac-io@17/i2c@18000/i2c-bus@0/codec@6a:
name             "codec"
device_type      "codec"
compatible       "tas3004"
                 "codec"
                 ""
reg              0000006a (106)
built-in
platform-do-tas-codec-ref ff985d48 08000000 00000027
linux,phandle    ff98cba8


-- 
Jon Smirl
jonsmirl@gmail.com
