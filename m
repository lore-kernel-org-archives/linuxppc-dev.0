Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD4Fm5YXzzDt3R
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 09:47:40 +1100 (AEDT)
Date: Tue, 8 Nov 2016 23:47:26 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jkosina@suse.cz>,
 Johannes Berg <johannes@sipsolutions.net>, Jouni Malinen <j@w1.fi>,
 Seth Forshee <seth.forshee@canonical.com>,
 Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Daniel Wagner <wagi@monom.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 "Herbert, Marc" <marc.herbert@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Rob Landley <rob@landley.net>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
 Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Slaby <jslaby@suse.com>, Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161108224726.GD13978@wotan.suse.de>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161005194633.GE3296@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 05, 2016 at 09:46:33PM +0200, Luis R. Rodriguez wrote:
> On Wed, Oct 05, 2016 at 11:08:06AM -0700, Linus Torvalds wrote:
> > On Wed, Oct 5, 2016 at 11:00 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > On Tue, Sep 13, 2016 at 09:38:17PM -0500, Rob Landley wrote:
> > >
> > >> I did some shuffling around of those code to make initmpfs work, does
> > >> anybody know why initramfs extraction _before_ we initialize drivers
> > >> would be a bad thing?
> > >
> > > No, but it seems sensible to me, if its done before do_initcalls()
> > > that should resolve the race for initramfs users
> > 
> > initramfs should already be set up before drivers are.
> 
> Actually you are right, the issue would only be for old initrd, for initramfs
> we populate that via rootfs_initcall(populate_rootfs), so as long as drivers
> in question use an init level beyond rootfs's we're good there.
> 
> > Exactly what is it that has trouble right now?
> 
> It would seem then that the only current stated race possible should
> then be non-initramfs users.

Or:

a) initramfs users that include a driver but do not include the firmware
into initramfs

b) driver is built-in but firmware is not in initrafms (Johannes reports
   this causes driver failure on intel wireless for instance, and I guess
   you need to reload)

> One example if very large firmware for
> remote-proc, whereby an initramfs is just not practical or desirable.

This issue still stands. At Plumbers Johannes Berg did indicate to me
he had a simple elegant solution in mind. He suggested that since the
usermode helper was available, he had added support to be able to
differentiate async firmware request calls form sync requests, and that
userspace should not return an error *iff* the request made was async and
it can determine we're initramfs. The semantics issue is the same though,
is there a generic way to determine we're initramfs ? What if we move
multiple levels? Anyway -- provided we could figure this out, userspace
would simply yield and wait until the real rootfs is met. Upon pivot_root()
the assumption is all previous udev events pending would be re-triggered
and finally udev could finally confirm/deny if the firmware was present.
This would *also* allow you to stuff your firmware whever, however big
it was. This however relied on the userspace firmware loading support,
it turns out that (I think because of an incorrect negative backlash
back in the day over blaming this over booting issues due to the timeout
whereas the real issue was the kmod timeout was affecting our long
standing serial init()/probe()) the systemd userspace firmware laoding
support was removed from systemd udev in 2014 by Kay via commit
be2ea723b1d023b3d ("udev: remove userspace firmware loading support").

Systemd might *still* be able to provide a solution here, however I will
note Johannes was asking for *all* async firmware requests to always
rely on the kernel syfs UMH fallback -- this suggestion is against the
direction we've been taking to eventually compartamentalize the kernel UMH
code, so whatever we decide to do, lets please take a breather and seriously
address this properly *with* systemd folks.

A side race discussed at Plumbers worth mentioning given its related to the
UMH was inspired by Jiri's talk on the abuse of the freezer for kthreads --
and his suggestion to use freeze_super(). Currently the UMH lock is used
for the UMH but as I have noted in Daniel Wagner's recent patches to
give some love to this code and further compartamentalize the UMH --
the UMH lock was originally added to help avoid drivers use the firmware
API on resume, given the races. The firmware cache solution implemented by
Ming Lei years ago helped address this, whereby devm helpers are used
based on the requested firmware and prior to suspend we cache all required
firmware for drivers so that upon resume calls would work without the
effective race present. This mitigated the actual races / issues with
drivers, but they must not use the firmware API on suspend/resume. Since
this solution *kills* all pending UMH caller on suspend obviously this
means on suspend using request_firmware*() API and expecting it to work
is brutally dumb as we will eventually kill any pending requests. This
is a long winded way to say that if you rely on the UMH for firmware
you must figure out your own proactive firmware cache solution and
must definitely not request firmware on suspend. Two things then:

1) I've been brainstorming with Daniel how to use freeze_super() to
   replace the now invalid UMH lock -- its purpose only helps races
   on boot, for the fallback case to the UMH. But note most distributions
   disable forcing it always on, so these days we *only* rely on the UMH
   as a fallback if the driver explicitly requested it

2) Drivers relying on the UMH very likely have a broken cache solution
   if they are doing this on suspend

Whatever the outcome of this discussion is -- Johannes seemed to *want*
to further use the UMH by default on *all* async alls... even if the
driver did not explicitly requested it -- I'm concerned about this given
all the above and the existing flip/flop on systemd for it. Whatever
we try to dream up here, please consider all the above as well.

> > The gating issue for initramfs is that technically the filesystem
> > setup needs to be done, which means that it currently ends up being
> > populated _fairly_ late in the initcall series, but certainly before
> > drivers. But since initramfs really only needs very limited filesystem
> > functionality, I assume Rob had few problems with just moving it
> > earlier.
> > 
> > Still, what kind of ordering issues did people have? What is it that
> > needs to load files even before driver init? Some crazy subsystem?
> 
> No, I think this is just about non-initramfs users now,

And as Johannes pointed two above to cases.

> if we disregard
> old initrd users. Bjorn, Marc, correct me if I'm wrong, as I think its
> so far you both who have seemed to run into race issues and have then
> ended up trying to look for hacks to address this race or considered using
> the usermode helper (which we're trying to minimize users for). Daniel
> seems to note a lot of video drivers use firmware on probe as well so
> there's a potential issue for those users if they don't use initramfs.

  Luis
