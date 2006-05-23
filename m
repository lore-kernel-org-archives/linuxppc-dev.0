Return-Path: <hollis@penguinppc.org>
Received: from pop-scotia.atl.sa.earthlink.net
	(pop-scotia.atl.sa.earthlink.net [207.69.195.65])
	by ozlabs.org (Postfix) with ESMTP id E7B5567B17
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 00:47:29 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Hollis Blanchard <hollis@penguinppc.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148387282.25971.8.camel@johannes>
References: <1147860564.14395.6.camel@johannes>
	<20060522221138.683790c2@diesel>  <1148387282.25971.8.camel@johannes>
Content-Type: text/plain
Date: Tue, 23 May 2006 09:46:57 -0500
Message-Id: <1148395617.3434.0.camel@diesel>
Mime-Version: 1.0
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

On Tue, 23 May 2006 14:27:52 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> --44731b52_16deb9ec_c30
> 
> gpg: Signature made Tue 23 May 2006 07:27:49 AM CDT using RSA key ID
> 227A1158 gpg: Can't check signature: public key not found
> 
> --44731b52_16deb9ec_c30
> 
> On Mon, 2006-05-22 at 22:11 -0500, Hollis Blanchard wrote:
> 
> > The "auto-loading" stuff doesn't seem to be working for me on my
> > PowerMac11,2, with a fresh git clone as of right now. What is the
> > base module that should load all the others? After a "make
> > install", I still had to modprobe almost everything by hand
> > (`find ./snd-aoa -name \*.ko` in the source directory to get a
> > list).
> 
> Odd. i2sbus should pull in all other required modules, and should
> itself load automatically at boot due to having a modalias that
> matches the of:... modalias the mac-io bus device for the i2s stuff
> has.

Yeah, I'm not sure how I was supposed to know that i2sbus was the magic
module. That seems to be working now. Again, from PowerMac11,2:
i2sbus: mapped i2s control registers
i2sbus: control register contents:
i2sbus:    fcr0 = 0x8000056
i2sbus:    cell_control = 0x5b43b71a
i2sbus:    fcr2 = 0xe7008000
i2sbus:    fcr3 = 0x7200d607
i2sbus:    clock_control = 0x0
i2sbus: found i2s controller
serial format: 0x41190000
dws: 0x2000200
i2sbus: found i2s controller
serial format: 0x41100000
dws: 0x0
...
snd-aoa-fabric-layout: found bus with layout 68 (using)
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
snd-aoa: fabric didn't like codec onyx
snd-aoa-codec-onyx: created and attached onyx instance
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: can use this codec
snd-aoa-codec-onyx: attached to onyx codec via i2c
snd-aoa-codec-onyx: created and attached onyx instance
snd-aoa-fabric-layout: found bus with layout 69 (using)
snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
snd-aoa: fabric didn't like codec onyx

> > snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is
> > on it snd-aoa-codec-tas: created and attached tas instance
> > snd-aoa-codec-tas: found keywest-i2c-bus, checking if tas chip is
> > on it snd-aoa-codec-tas: created and attached tas instance
> 
> Uh. That one I need to check, there is no tas codec on your machine.

This is probably just because I loaded all the modules I could find.

> > snd: Unknown layout ID 0x44
> 
> That looks like you have snd-powermac loaded too. Or not? I don't
> think I have anything that prints "snd:" as the prefix but I might be
> wrong.

Yes, it looks like snd-powermac was loading as well, thanks to
modules.conf. I've removed that now.

> > For the record, there are two "layout-id" properties in my device
> > tree, as discussed in this patch:
> > http://patchwork.ozlabs.org/linuxppc/patch?id=3D4867
> 
> Note that the patch is mine :)

I noted that. Since most of the archived mails aren't overly helpful, I
was trying to be complete.

> > Ultimately, snd_aoa_codec_onyx seems to be the happy module. Only
> > the headphone jack was enabled; I had to use GNOME's "Volume
> > Control" panel applet to enable speakers or line out (both of which
> > work).
> >=20
> > However, volume control doesn't work at all, for both line-out and
> > headphone jacks. Should it?
> 
> Yes, it should. I think the bug is that the tas module thinks it can
> attach a codec here. Can you try *not* loading that module and see if
> it works better then? I'll try to see if I can make the tas module not
> attach on those machines, but as long as you don't load it manually
> all should be fine.

Volume control does indeed work when the tas module isn't loaded.

> > Also, it would be helpful if the git tree were better publicized
> > somewhere (e.g. http://johannes.sipsolutions.net/). I had to dig
> > through =
> a LOT of mails to find the source.
> 
> Sorry. I linked it up on http://johannes.sipsolutions.net/Projects/
> and will add a few more details later.

Could you also add a sample modules.conf? For example, users should be
told to remove snd-powermac. Here's what I have ATM, on an FC5 system:
alias snd-card-0 i2sbus
remove snd-card-0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1
|| : ; }; /sbin/modprobe -r --ignore-remove snd-powermac

Thanks again!

-Hollis
