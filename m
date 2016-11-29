Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSy4q2nTbzDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:54:34 +1100 (AEDT)
Date: Tue, 29 Nov 2016 22:54:28 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jkosina@suse.cz>,
 Johannes Berg <johannes@sipsolutions.net>, Jouni Malinen <j@w1.fi>,
 Seth Forshee <seth.forshee@canonical.com>,
 Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Daniel Wagner <wagi@monom.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
 Jiri Slaby <jslaby@suse.com>, Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>, Harald Hoyer <harald@redhat.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161129215428.GK1402@wotan.suse.de>
References: <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de>
 <20161108224726.GD13978@wotan.suse.de>
 <cdd43459-346f-c8e9-e8fc-25bd81e9f0ea@bmw-carit.de>
 <CALCETrVtuiKaJ+z3hSLGYs3robuORJv+N5Z19t0XUzUNynqZDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrVtuiKaJ+z3hSLGYs3robuORJv+N5Z19t0XUzUNynqZDA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2016 at 03:21:07AM -0800, Andy Lutomirski wrote:
> On Wed, Nov 9, 2016 at 1:13 AM, Daniel Wagner
> <daniel.wagner@bmw-carit.de> wrote:
> > [CC: added Harald]
> >
> > As Harald pointed out over a beer yesterday evening, there is at least
> > one more reason why UMH isn't obsolete. The ordering of the firmware loading
> > might be of important. Say you want to greet the user with a splash screen
> > really early on, the graphic card firmware should be loaded first. Also the
> > automotive world has this fancy requirement that rear camera must be on the
> > screen within 2 seconds. So controlling the firmware loading order is of
> > importance (e.g. also do not overcommit the I/O bandwith not so important
> > firmwares). A user space helper is able to prioritize the request
> > accordingly the use case.
> 
> That seems like a valid problem, but I don't think that UMH adequately
> solves it.  Sure, loading firmware in the right order avoids a >2sec
> delay due to firmware loading, but what happens when you have a slow
> USB device that *doesn't* need firmware plugged in to your car's shiny
> USB port when you start the car?
> 
> It seems to me that this use case requires explicit control over
> device probing and, if that gets added, you get your firmware ordering
> for free (just probe the important devices first).

In theory this is correct, the problem comes with the flexibility we have
created with pivot_root() and friends (another is mount on /lib/firmware) which
enables system integrators to pick and choose the "real rootfs" to be a few
layers away from the first fs picked up by the kernel. In providing this
flexibility we did not envision nor have devised signals to enable a
deterministic lookup due to the requirements such lookups might have --
in this case the requirements are that direct fs is ready and kosher
all the paths possible for firmware are ready. As you can imagine first race is
not only an issue for firmware but a generic issue.

The generic race on the fs lookup requires a fs availability event, and
addressing fs suspend. I'll note that the race on init is addressed today
*only* by the firmware UMH (its UMH is kobject uevent and optionally a custom
binary) by using the UMH lock. During a cleanup by Daniel recently I
realized it was bogus to use the UMH of the UMH was not used, turns out
this would still expose the direct FS lookup to a race though. This
begs the question if the UMH lock either be removed / shared with the
other kernel UMHs or a generic solution provided for direct fs lookup
with some requirements specified.

This is all a mess so I've documented each component and issues / ideas
we've discussed so far separately, the firmware UMH (which we should
probably rebrand to firmware kobject uevent helper to avoid confusion)
[0], the real kernel usermode helper [1], the new common kernel file
loader [2]

[0] https://kernelnewbies.org/KernelProjects/firmware-class-enhancements
[1] https://kernelnewbies.org/KernelProjects/usermode-helper-enhancements
[2] https://kernelnewbies.org/KernelProjects/common-kernel-loader

  Luis
