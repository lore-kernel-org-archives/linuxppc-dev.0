Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKvgp5SCXzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 05:41:42 +1000 (AEST)
Date: Thu, 25 Aug 2016 21:41:33 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
 =?iso-8859-1?Q?J=F6rg_R=F6del?= <jroedel@suse.de>,
 Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, zohar@linux.vnet.ibm.com,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de,
 Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, jslaby@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>, cocci@systeme.lip6.fr,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Message-ID: <20160825194133.GC3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Summoning Felix for the embedded aspect on initramfs below.
Jörg might be interested in the async facilities you speak of as well.

On Thu, Aug 25, 2016 at 01:05:44PM +0200, Daniel Vetter wrote:
> On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > On Wed, Aug 24, 2016 at 08:55:55AM +0200, Daniel Vetter wrote:
> >> On Fri, Jun 17, 2016 at 12:54 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> > Thou shalt not make firmware calls early on init or probe.
> >
> > <-- snip -->
> >
> >> > There are 4 offenders at this time:
> >> >
> >> > mcgrof@ergon ~/linux-next (git::20160609)$ export COCCI=scripts/coccinelle/api/request_firmware.cocci
> >> > mcgrof@ergon ~/linux-next (git::20160609)$ make coccicheck MODE=report
> >> >
> >> > drivers/fmc/fmc-fakedev.c: ERROR: driver call request firmware call on its init routine on line 321.
> >> > drivers/fmc/fmc-write-eeprom.c: ERROR: driver call request firmware call on its probe routine on line 136.
> >> > drivers/tty/serial/rp2.c: ERROR: driver call request firmware call on its probe routine on line 796.
> >> > drivers/tty/serial/ucc_uart.c: ERROR: driver call request firmware call on its probe routine on line 1246.
> >>
> >> Plus all gpu drivers which need firmware. And yes we must load them at
> >> probe
> >
> > Do you have an upstream driver in mind that does this ? Is it on device
> > drier module probe or a DRM subsystem specific probe call of some sort ?
> 
> i915 is the one I care about for obvious reasons ;-) It's all from the
> pci device probe function, but nested really deeply.

The above SmPL grammar should capture well nested calls of calls within probe,
so curious why it didn't pick up i915. Let's see.

i915_pci_probe() --> i915_driver_load() -->
	i915_load_modeset_init() --> (drivers/gpu/drm/i915/i915_drv.c)
		a) intel_csr_ucode_init() (drivers/gpu/drm/i915/intel_csr.c)
		...
		b) intel_guc_init() (drivers/gpu/drm/i915/intel_guc_loader.c)

The two firmwares come from:

a) intel_csr_ucode_init() --> schedule_work(&dev_priv->csr.work);
	csr_load_work_fn() --> request_firmware()

b) intel_guc_init() --> guc_fw_fetch() request_firmware()

---

a) is not dealt with given the grammar does not include scheduled work,
however using work to offload loading firmware seems reasonable here.

b) This should have been picked up, but its not. Upon closer inspection
   the grammar currently expects the module init and probe to be on the
   same file. Loosening this:

diff --git a/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci b/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
index cf180c59e042..e19e6d3dfc0f 100644
--- a/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
+++ b/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
@@ -49,7 +49,7 @@ identifier init;
 
 module_init(init);
 
-@ has_probe depends on defines_module_init@
+@ has_probe @
 identifier drv_calls, drv_probe;
 type bus_driver;
 identifier probe_op =~ "(probe)";
@@ -59,7 +59,7 @@ bus_driver drv_calls = {
 	.probe_op = drv_probe,
 };
 
-@hascall depends on !after_start && defines_module_init@
+@hascall depends on !after_start @
 position p;
 @@
 

I get a lot more complaints but still -- i915 b) case is not yet covered:

./drivers/bluetooth/ath3k.c: ERROR: driver call request firmware call on its probe routine on line 546.
./drivers/bluetooth/bcm203x.c: ERROR: driver call request firmware call on its probe routine on line 193.
./drivers/bluetooth/bcm203x.c: ERROR: driver call request firmware call on its probe routine on line 218.
./drivers/bluetooth/bfusb.c: ERROR: driver call request firmware call on its probe routine on line 655.
./drivers/fmc/fmc-fakedev.c: ERROR: driver call request firmware call on its init routine on line 321.
./drivers/fmc/fmc-write-eeprom.c: ERROR: driver call request firmware call on its probe routine on line 136.
./drivers/tty/serial/ucc_uart.c: ERROR: driver call request firmware call on its probe routine on line 1246.
./sound/soc/codecs/wm2000.c: ERROR: driver call request firmware call on its probe routine on line 893.
./sound/soc/sh/siu_dai.c: ERROR: driver call request firmware call on its probe routine on line 747.
./drivers/net/wireless/intersil/orinoco/orinoco_usb.c: ERROR: driver call request firmware call on its probe routine on line 1661.
./sound/soc/intel/common/sst-acpi.c: ERROR: driver call request firmware call on its probe routine on line 161.
./drivers/input/touchscreen/goodix.c: ERROR: driver call request firmware call on its probe routine on line 744.
./drivers/media/usb/go7007/go7007-loader.c: ERROR: driver call request firmware call on its probe routine on line 78.
./drivers/media/usb/go7007/go7007-loader.c: ERROR: driver call request firmware call on its probe routine on line 93.
./drivers/tty/serial/rp2.c: ERROR: driver call request firmware call on its probe routine on line 796.
./drivers/usb/misc/isight_firmware.c: ERROR: driver call request firmware call on its probe routine on line 50.
./drivers/usb/serial/mxuport.c: ERROR: driver call request firmware call on its probe routine on line 1067.
./sound/pci/hda/hda_intel.c: ERROR: driver call request firmware call on its probe routine on line 2015.
./drivers/media/usb/s2255/s2255drv.c: ERROR: driver call request firmware call on its probe routine on line 2304.
./drivers/misc/lattice-ecp3-config.c: ERROR: driver call request firmware call on its probe routine on line 206.
./drivers/net/wireless/ath/carl9170/usb.c: ERROR: driver call request firmware call on its probe routine on line 1103.
./drivers/video/fbdev/metronomefb.c: ERROR: driver call request firmware call on its probe routine on line 681.

At a quick glance these check out though, and it was because I loosened
the requirement to not necessarily have module_init -- usb for instance has
module_usb_driver()...

I believe i915 is not picked up given the request for firmware comes in
on separate files than both the module_init *and* probe calls, that is,
its implemented in drivers/gpu/drm/i915/intel_csr.c. Tuning this a bit more
can take a bit of time, but the intent stands -- as such I think the
current grammar is justified and we should evolve it to catch more and
as it does we touch base again to see what the implications are -- clearly
this means way many more drivers are requesting firmware on probe than
expected.

> >> because people are generally pissed when they boot their machine
> >> and the screen goes black. On top of that a lot of people want their
> >> gpu drivers to be built-in, but can't ship the firmware blobs in the
> >> kernel image because gpl. Yep, there's a bit a contradiction there ...
> >
> > Can they use initramfs for this ?
> 
> Apparently that's also uncool with the embedded folks.

What's uncool with embedded folks? To use initramfs for firmware ?
If so can you explain why ?

> Tbh I don't
> know exactly why. Also I thought initramfs is available only after
> built-in drivers have finished loading, but maybe that changed.

Its still the same, we run through all init calls first (do_initcalls()
and finally the initramfs is processed via prepare_namespace()

do_basic_setup() {
	...
	driver_init();
	...
	do_initcalls();
	...
}

kernel_init_freeable() {
	...
	do_basic_setup();
	...
	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
		ramdisk_execute_command = NULL;
		prepare_namespace();
        }
}

Felix, are initramfs not kosher for embedded ? If so why not ? The question
here is where to stuff firmware if its needed early in boot and since
graphics folks want video turned on ASAP they often load firmware on probe
and due to licensing may not be able to use the built-in firmware facility.
Using initrafms is what would be expected for these cases then, if that's
not kosher what do you recommend ? Granted video may not be a concern for
embedded but since we're on topic figured we should square this away.

> > Also just curious -- as with other subsystems, is it possible to load
> > a generic driver first, say vesa, and then a more enhanced one later ?
> > I am not saying this is ideal or am I suggesting this, I'd just like
> > to know the feasibility of this.
> 
> Some users want a fully running gfx stack 2s after power-on. There's
> not even enough time to load an uefi or vga driver first. i915
> directly initializes the gpu from power-on state on those.

I see.. thanks.

> >> I think what would work is loading the different subsystems of the
> >> driver in parallel (we already do that largely)
> >
> > Init level stuff is actually pretty synchronous, and in fact both
> > init and probe are called serially. There are a few subsystems which
> > have been doing things a bit differently, but these are exceptions.
> >
> > When you say we already do this largely, can you describe a bit more
> > precisely what you mean ?
> 
> Oh, this isn't subsystems as in linux device/driver model, but
> different parts within the driver. We fire up a bunch of struct work
> to get various bits done asynchronously.

Thanks for the clarification.

> >>, and then if one
> >> firmware blob isn't there yet simply stall that async worker until it
> >> shows up.
> >
> > Is this an existing framework or do you mean if we add something
> > generic to do this async loading of subsystems ?
> 
> normal workers, and flush_work and friends to sync up. We have some
> really fancy ideas for essentially async init tasks that can declare
> their depencies systemd-unit file style, but that's only in the
> prototype stage.

Great, another solution. More reason to talk at KS/Plumbers to see
exactly what each different pipe dream is coming up with.

> We need this (eventually) since handling the ordering
> correctly is getting unwieldy. But again just struct work launched
> from the main pci probe function.

You mean its a struct work based solution ?

> >> But the answers I've gotten thus far from request_firmware()
> >> folks (well at least Greg) is don't do that ...
> >
> > Well in this patch set I'm adding myself as a MAINTAINER and I've
> > been extending the firmware API recently to help with a few new
> > features I want, I've been wanting to hear more feedback from
> > other's needs and I had actually not gotten much -- except
> > only recently with the usermode helper and reasons why some
> > folks thought they could not use direct firmware loading from
> > the fs. I'm keen to hear or more use cases and needs specially if
> > they have to do with improving boot time and asynchronous boot.
> >
> >> Is that problem still somewhere on the radar?
> >
> > Not mine.
> >
> >> Atm there's various
> >> wait_for_rootfs hacks out there floating in vendor/product trees.
> >
> > This one I've heard about recently, and I suggested two possible
> > solutions, with a preference to a simply notification of when
> > rootfs is available from userspace.
> >
> >> "Avoid at all costs" sounds like upstream prefers to not care about
> >> android/cros in those case (yes I know most arm socs don't need
> >> firmware, which would make it a problem fo just be a subset of all
> >> devices).
> >
> > In my days of dealing with Android I learned most folks did not frankly
> > care too much about upstream-first model. That means things were reactive.
> > That's a business mind set and that's fine. However for upstream we want
> > what is best and to discuss. I haven't seen proposals so, so long as
> > we just hear of "hacks" that some folks do in vendor/product trees,
> > what can we do ?
> 
> One of the proposals which would have worked for us died a while back:
> 
> https://lkml.org/lkml/2014/6/15/47

Interesting, the problem stated here, which comes from the fact (as clarified
above) the rootfs comes up only *after* we run do_initcalls() as such there are
possible theoretical races even with request_firmware_nowait() -- as such that
justifies even more the SmPL grammar rule to include even request_firmware_nowait()
on probe / init as this patch has.

Anyway yeah that patch has good intentions but its wrong for a slew of reasons.
The problem is the same as discussed with Bjorn recently. The solution
discussed is that since only userspace knows when the *real* rootfs is ready
(because of slew of reasons) the best we can do is have an event issued by
userspace to inform us of that.

> That's essentially what I'd like to have.

You're not alone.

> [cut discussion about async probe]
> 
> > So .. I agree, let's avoid the hacks. Patches welcomed.
> 
> Hm, this is a definite change of tack - back when I discussed this
> with Greg about 2 ks ago it sounded like "don't do this". The only
> thing we need is some way to wait for rootfs before we do the
> request_firmware. Everything else we handle already in the kernel.

OK so lets just get this userspace event done, and we're set.

  Luis
