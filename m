Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ2Dq2BXvzDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:30:33 +1100 (AEDT)
Message-ID: <1479202125.12007.24.camel@sipsolutions.net>
Subject: Re: [RFC] fs: add userspace critical mounts event support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Jouni
 Malinen <j@w1.fi>, Seth Forshee <seth.forshee@canonical.com>, Tom Gundersen
 <teg@jklm.no>,  Kay Sievers <kay@vrfy.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, Daniel Wagner <wagi@monom.org>, Daniel Wagner
 <daniel.wagner@bmw-carit.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Herbert, Marc" <marc.herbert@intel.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Rob Landley <rob@landley.net>, Mimi Zohar
 <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse
 <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Ming Lei
 <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal
 Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla
 <markivx@codeaurora.org>,  Stephen Boyd <stephen.boyd@linaro.org>, Mark
 Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,  Christian
 Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Josh Boyer <jwboyer@fedoraproject.org>,  Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jiri Slaby <jslaby@suse.com>, Andy Lutomirski
 <luto@amacapital.net>,  Wu Fengguang <fengguang.wu@intel.com>, Richard
 Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,  Jacek
 Anaszewski <j.anaszewski@samsung.com>, Abhay_Salunke@dell.com, Julia Lawall
 <Julia.Lawall@lip6.fr>,  Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
 David Howells <dhowells@redhat.com>,  Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>
Date: Tue, 15 Nov 2016 10:28:45 +0100
In-Reply-To: <20161108224726.GD13978@wotan.suse.de>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de>
 <20161108224726.GD13978@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 23:47 +0100, Luis R. Rodriguez wrote:

> This issue still stands. At Plumbers Johannes Berg did indicate to me
> he had a simple elegant solution in mind. He suggested that since the
> usermode helper was available, he had added support to be able to
> differentiate async firmware request calls form sync requests,

For reference:

commit e9045f9178f3e3445a3a5b85206f8681b3869562
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Mar 29 17:57:20 2010 +0200

    firmware class: export nowait to userspace

> it can determine we're initramfs. The semantics issue is the same
> though, is there a generic way to determine we're initramfs ? What if
> we move multiple levels? Anyway -- provided we could figure this out,
> userspace would simply yield and wait until the real rootfs is met. 

One way or another we have to have this kind of information somewhere.
I don't actually know how/where though.

> Upon pivot_root() the assumption is all previous udev events pending
> would be re-triggered and finally udev could finally confirm/deny if
> the firmware was present.

The retriggering is already the case, as far as I know, if only to load
modules that weren't part of initramfs.

> note Johannes was asking for *all* async firmware requests to always
> rely on the kernel syfs UMH fallback -- this suggestion is against
> the direction we've been taking to eventually compartamentalize the
> kernel UMH code, so whatever we decide to do, lets please take a
> breather and seriously address this properly *with* systemd folks.

I was saying that because that's the only way you can actually rely on
this functionality as a system integrator. If drivers have to opt in or
can opt out then you'll always end up chasing the drivers around.

My argument basically goes like this:

First, given good drivers (i.e. using request_firmware_nowait())
putting firmware even for a built-in driver into initramfs or not
should be a system integrator decision. If they don't need the device
that early, it should be possible for them to delay it. Or, perhaps, if
the firmware is too big, etc. I'm sure we can all come up with more
examples of why you'd want to do it one way or another.

Second, all of this can be solved in other ways by adding logic to the
kernel, like the rejected proposal to add a "rootfs available" bit
somewhere, that would cause async requests to behave similarly within
the kernel (don't return "not found" until they time out or this bit is
set, and retry loading when the bit gets set)

Third, having this in place can be more friendly to users who play with
kernel compilation, modules, etc. This is a fringe group in some ways,
but it is (was?) actually a relatively common complaint that drivers
built into the kernel wouldn't work - we'd always have to direct users
to do magic steps like rebuilding initramfs with the right options etc.

johannes
