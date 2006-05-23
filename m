Return-Path: <hollis@penguinppc.org>
Received: from pop-satin.atl.sa.earthlink.net (pop-satin.atl.sa.earthlink.net
	[207.69.195.63]) by ozlabs.org (Postfix) with ESMTP id AE775679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 13:12:13 +1000 (EST)
Date: Mon, 22 May 2006 22:11:38 -0500
From: Hollis Blanchard <hollis@penguinppc.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060522221138.683790c2@diesel>
In-Reply-To: <1147860564.14395.6.camel@johannes>
References: <1147860564.14395.6.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 May 2006 12:09:24 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> Currently snd-aoa is known to work on the following machines:
> * PowerBook5,8
> * PowerBook5,7
> * PowerMac8,1
> * PowerMac8,2
> * 17" October 2005 PowerBook (don't know the number)
> * PowerMac11,2
> * PowerBook6,8
> and my
> * PowerBook5,6
> 
> People with those machines are encouraged to use and stress-test it,
> it also provides much better hardware support than snd-powermac, for
> example it can actually reprogram the hardware if you have a 48KHz
> file instead of having to digitally downsample it to 44.1KHz like
> required with snd-powermac in most cases.

The "auto-loading" stuff doesn't seem to be working for me on my
PowerMac11,2, with a fresh git clone as of right now. What is the base
module that should load all the others? After a "make install", I still
had to modprobe almost everything by hand (`find ./snd-aoa -name \*.ko`
in the source directory to get a list).

When the driver finally did completely load, I saw this in dmesg:
snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is on it
snd-aoa-codec-tas: created and attached tas instance
snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is on it
snd-aoa-codec-tas: created and attached tas instance
snd: Unknown layout ID 0x44
i2sbus: mapped i2s control registers
i2sbus: control register contents:
i2sbus:    fcr0 = 0x8000056
i2sbus:    cell_control = 0x5b43831a
i2sbus:    fcr2 = 0xe7008000
i2sbus:    fcr3 = 0x72009607
i2sbus:    clock_control = 0x0
i2sbus: found i2s controller
snd-aoa-fabric-layout: found bus with layout 68 (using)
snd-aoa: fabric didn't like codec tas
snd-aoa: fabric didn't like codec tas
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
snd-aoa: fabric didn't like codec onyx
snd-aoa-codec-onyx: created and attached onyx instance
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: can use this codec
snd-aoa-codec-onyx: attached to onyx codec via i2c
snd-aoa-codec-onyx: created and attached onyx instance
serial format: 0x41190000
dws: 0x2000200
i2sbus: found i2s controller
snd-aoa-fabric-layout: found bus with layout 69 (using)
snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
snd-aoa: fabric didn't like codec onyx
snd-aoa: fabric didn't like codec tas
snd-aoa: fabric didn't like codec tas
serial format: 0x41100000
dws: 0x0
all codec info:
        formats = 0x808
        rates = 0x7fe

For the record, there are two "layout-id" properties in my device tree,
as discussed in this patch:
http://patchwork.ozlabs.org/linuxppc/patch?id=4867

Ultimately, snd_aoa_codec_onyx seems to be the happy module. Only the
headphone jack was enabled; I had to use GNOME's "Volume Control" panel
applet to enable speakers or line out (both of which work).

However, volume control doesn't work at all, for both line-out and
headphone jacks. Should it?

Also, it would be helpful if the git tree were better publicized
somewhere (e.g. http://johannes.sipsolutions.net/). I had to dig through a LOT of mails to find the source.
	mkdir snd-aoa
	cd snd-aoa/
	git clone http://johannes.sipsolutions.net/snd-aoa.git/ 
	cd snd-aoa/ 
	make

-Hollis

P.S. Thanks for working on this Johannes!
