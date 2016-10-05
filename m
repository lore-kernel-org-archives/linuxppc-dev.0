Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spbWh5TZYzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:00:15 +1100 (AEDT)
Date: Wed, 5 Oct 2016 02:00:08 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Herbert, Marc" <marc.herbert@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Ming Lei <ming.lei@canonical.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Roman Pen <r.peniaev@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Takashi Iwai <tiwai@suse.de>, Jeff Mahoney <jeffm@suse.com>,
 Hariprasad S <hariprasad@chelsio.com>, Benjamin Poirier <bpoirier@suse.de>,
 Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161005000008.GY3296@wotan.suse.de>
References: <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
 <CAKdAkRQhEdaP+z02DQ9nighSg_N8R+Dnkv7x3EkYc_YmO_jW4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAKdAkRQhEdaP+z02DQ9nighSg_N8R+Dnkv7x3EkYc_YmO_jW4g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 24, 2016 at 10:41:46AM -0700, Dmitry Torokhov wrote:
> On Fri, Sep 23, 2016 at 6:37 PM, Herbert, Marc <marc.herbert@intel.com> wrote:
> > On 03/09/2016 11:10, Dmitry Torokhov wrote:
> >> I was thinking if we kernel could post
> >> "conditions" (maybe simple stings) that it waits for, and userspace
> >> could unlock these "conditions". One of them might be "firmware
> >> available".
> >
> > On idea offered by Josh Triplett that seems to overlap with this one
> > is to have something similar to the (deprecated) userhelper with
> > *per-blob* requests and notifications except for one major difference:
> > userspace would not anymore be in charge of *providing* the blob but
> > would instead only *signal* when a given blob becomes available and is
> > either found or found missing. Then the kernel loads the blob _by
> > itself_; unlike the userhelper. No new “critical filesystem” concept
> > and a *per-blob basis*, allowing any variation of blob locations
> > across any number of initramfs and filesystems.
> >
> 
> Really, I do not quite understand why people have issues with usermode
> helper/uevents.

One reason is you'd have to implement your own cache for suspend/resume.

> It used to work reasonably well (if you were using
> request_firmware_nowait()), as the kernel would post the request and
> then, when userspace was ready[^Hier], uevents would be processed and
> firmware would be loaded. We had a timeout of 60(?) seconds by
> default, but that would be adjusted as systems needed.

The issue with the timeout was kernel developers *assumed* module init
and probe were detached, and saying 'thou shall not load firmware on
probe' seems actually like a more radical change than just saying
'thou shall load firmware on init'. I'll note that as it stands
its the right thing to complain about these users only because we
lack the semantics to ensure correctness if used on init or probe.
The timeout incurred huge latencies for optional firmwares, and
while we had a new API added to avoid the wait on optional firmware,
that obviously still leaved the races as possible. We now have async
probe which *does* enable some original misconceptions by kernel
developers, but by now other issues have also been found on the
usermode helper, the cache was one, another one was a recent discusion
over the user of the UMH lock with the assumption this was providing
a sort of safeguard on early boot use -- it does not, for the same
exact reasons why a UMH lock does not suffice to avoid all possible
rootfs races. For this later issue refer to a recent discussion in
review with Daniel Wagner's patches.

> Unfortunately it all broke when udev started insisting [1] on
> servicing some uevents in strict sequence, which resulted in boot
> stalls.

That was not the only issue... another implicit issue was that
you are reducing the number of possible supported number of
devices Linux supports per module by the timeout, it would
depend on the combine time it takes to both init and probe.
Some drivers are super complex and even if you *don't* have
firmware requirements and say burn the firmware onto a device
we found that *probe* alone was taking a long long time on some
device drivers -- check out cxgb4 driver, where one device actually
ends up loading about 4 subdevices underneath it. Yes that's a mess
and the driver needs a major rewrite to address this in a clean way
but that takes time. Its no trivial pursuit. The umh timeout then
would not be implicated anymore *but* since systemd implemented the
timeout in general for kmod loading it did mean system was limiting
them Linux drivers and how much devices a driver can support
depending on this timeout value. At SUSE we solved this by lifting
this timeout for kmod workers for now. A long term goal here, which
could help, is also to just detach init and probes, so we give to
system what it originally thought. Summary of this all is here:

http://www.do-not-panic.com/2015/12/linux-asynchronous-probe.html

I have some code that starts to enable some of this on systemd/kmod
but it still needs some more testing before I post.

> Maybe the ultimate answer is to write a firmware loading
> daemon that would also listen to netlink events and do properly what
> udev refused to be doing?

Meh, in the wireless subsystem we devised our own file loader,
check CRDA. That worked for us since we needed to optionally
enable digital RSA signed file checking, but long term our
experience is that this is pointless. So we're going to phase
that out in favor of using the firmware API for the file loading
of this file, and support then digital signatures on the firmware.

I am not sure how/why a firmware loading daemon would be a better
idea now. What Marc describes that Josh proposed with signals for
userspcae seems more aligned with what we likely need -- but note
that since we now use a shared common API for kernel reads from a
path via kernel_read_file_from_path() we'd probably want something
like a notifier for any kernel_read_file_from_path() user. The ability
for the kernel to register a generic userspace notifier seems worthy
of consideration, but I'd be surprised if we don't already have
something quite like this already?

> The distribution would know when it is ready
> to service firmware requests (and thus when to start this daemon), and
> we would have the freedom of having drivers both built-in and as
> modules and bulding firmware into kernel, intiramfs or keep on a
> "real" fs available at later time.

What difference would there be if we just used notifications to
guarantee to the kernel the file in question is now available?

  Luis
