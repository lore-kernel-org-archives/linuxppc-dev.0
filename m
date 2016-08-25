Return-Path: <daniel.vetter@ffwll.ch>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKhDb3ny5zDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:05:47 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id d65so5517495ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 04:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160824203901.GT3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 25 Aug 2016 13:05:44 +0200
Message-ID: <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, zohar@linux.vnet.ibm.com,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de,
 Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, jslaby@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>, rpurdie@rpsys.net,
 j.anaszewski@samsung.com,
 Abhay_Salunke@dell.com, Julia Lawall <Julia.Lawall@lip6.fr>,
 Gilles.Muller@lip6.fr, nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 cocci@systeme.lip6.fr,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Wed, Aug 24, 2016 at 08:55:55AM +0200, Daniel Vetter wrote:
>> On Fri, Jun 17, 2016 at 12:54 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > Thou shalt not make firmware calls early on init or probe.
>
> <-- snip -->
>
>> > There are 4 offenders at this time:
>> >
>> > mcgrof@ergon ~/linux-next (git::20160609)$ export COCCI=scripts/coccinelle/api/request_firmware.cocci
>> > mcgrof@ergon ~/linux-next (git::20160609)$ make coccicheck MODE=report
>> >
>> > drivers/fmc/fmc-fakedev.c: ERROR: driver call request firmware call on its init routine on line 321.
>> > drivers/fmc/fmc-write-eeprom.c: ERROR: driver call request firmware call on its probe routine on line 136.
>> > drivers/tty/serial/rp2.c: ERROR: driver call request firmware call on its probe routine on line 796.
>> > drivers/tty/serial/ucc_uart.c: ERROR: driver call request firmware call on its probe routine on line 1246.
>>
>> Plus all gpu drivers which need firmware. And yes we must load them at
>> probe
>
> Do you have an upstream driver in mind that does this ? Is it on device
> drier module probe or a DRM subsystem specific probe call of some sort ?

i915 is the one I care about for obvious reasons ;-) It's all from the
pci device probe function, but nested really deeply.

>> because people are generally pissed when they boot their machine
>> and the screen goes black. On top of that a lot of people want their
>> gpu drivers to be built-in, but can't ship the firmware blobs in the
>> kernel image because gpl. Yep, there's a bit a contradiction there ...
>
> Can they use initramfs for this ?

Apparently that's also uncool with the embedded folks. Tbh I don't
know exactly why. Also I thought initramfs is available only after
built-in drivers have finished loading, but maybe that changed.

> Also just curious -- as with other subsystems, is it possible to load
> a generic driver first, say vesa, and then a more enhanced one later ?
> I am not saying this is ideal or am I suggesting this, I'd just like
> to know the feasibility of this.

Some users want a fully running gfx stack 2s after power-on. There's
not even enough time to load an uefi or vga driver first. i915
directly initializes the gpu from power-on state on those.

>> I think what would work is loading the different subsystems of the
>> driver in parallel (we already do that largely)
>
> Init level stuff is actually pretty synchronous, and in fact both
> init and probe are called serially. There are a few subsystems which
> have been doing things a bit differently, but these are exceptions.
>
> When you say we already do this largely, can you describe a bit more
> precisely what you mean ?

Oh, this isn't subsystems as in linux device/driver model, but
different parts within the driver. We fire up a bunch of struct work
to get various bits done asynchronously.

>>, and then if one
>> firmware blob isn't there yet simply stall that async worker until it
>> shows up.
>
> Is this an existing framework or do you mean if we add something
> generic to do this async loading of subsystems ?

normal workers, and flush_work and friends to sync up. We have some
really fancy ideas for essentially async init tasks that can declare
their depencies systemd-unit file style, but that's only in the
prototype stage. We need this (eventually) since handling the ordering
correctly is getting unwieldy. But again just struct work launched
from the main pci probe function.

>> But the answers I've gotten thus far from request_firmware()
>> folks (well at least Greg) is don't do that ...
>
> Well in this patch set I'm adding myself as a MAINTAINER and I've
> been extending the firmware API recently to help with a few new
> features I want, I've been wanting to hear more feedback from
> other's needs and I had actually not gotten much -- except
> only recently with the usermode helper and reasons why some
> folks thought they could not use direct firmware loading from
> the fs. I'm keen to hear or more use cases and needs specially if
> they have to do with improving boot time and asynchronous boot.
>
>> Is that problem still somewhere on the radar?
>
> Not mine.
>
>> Atm there's various
>> wait_for_rootfs hacks out there floating in vendor/product trees.
>
> This one I've heard about recently, and I suggested two possible
> solutions, with a preference to a simply notification of when
> rootfs is available from userspace.
>
>> "Avoid at all costs" sounds like upstream prefers to not care about
>> android/cros in those case (yes I know most arm socs don't need
>> firmware, which would make it a problem fo just be a subset of all
>> devices).
>
> In my days of dealing with Android I learned most folks did not frankly
> care too much about upstream-first model. That means things were reactive.
> That's a business mind set and that's fine. However for upstream we want
> what is best and to discuss. I haven't seen proposals so, so long as
> we just hear of "hacks" that some folks do in vendor/product trees,
> what can we do ?

One of the proposals which would have worked for us died a while back:

https://lkml.org/lkml/2014/6/15/47

That's essentially what I'd like to have.

[cut discussion about async probe]

> So .. I agree, let's avoid the hacks. Patches welcomed.

Hm, this is a definite change of tack - back when I discussed this
with Greg about 2 ks ago it sounded like "don't do this". The only
thing we need is some way to wait for rootfs before we do the
request_firmware. Everything else we handle already in the kernel.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
