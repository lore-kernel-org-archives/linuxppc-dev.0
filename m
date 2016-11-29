Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSxjV0xRSzDvtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:37:50 +1100 (AEDT)
Date: Tue, 29 Nov 2016 22:37:39 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Tom Gundersen <teg@jklm.no>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jkosina@suse.cz>, Jouni Malinen <j@w1.fi>,
 Seth Forshee <seth.forshee@canonical.com>, Kay Sievers <kay@vrfy.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Daniel Wagner <wagi@monom.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Abhay Salunke <Abhay_Salunke@dell.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161129213739.GJ1402@wotan.suse.de>
References: <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de>
 <20161108224726.GD13978@wotan.suse.de>
 <1479202125.12007.24.camel@sipsolutions.net>
 <CAG-2HqVf=YQk2iLFhpsKFZd3HZTG6XG7xY6B4YeX5-bFrwMJFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG-2HqVf=YQk2iLFhpsKFZd3HZTG6XG7xY6B4YeX5-bFrwMJFA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2016 at 10:10:56PM +0100, Tom Gundersen wrote:
> On Tue, Nov 15, 2016 at 10:28 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > My argument basically goes like this:
> >
> > First, given good drivers (i.e. using request_firmware_nowait())
> > putting firmware even for a built-in driver into initramfs or not
> > should be a system integrator decision. If they don't need the device
> > that early, it should be possible for them to delay it. Or, perhaps, if
> > the firmware is too big, etc. I'm sure we can all come up with more
> > examples of why you'd want to do it one way or another.
> 
> This is how I understood the the situation, but I never quite bought
> it. What is wrong with the kernel saying "you must put your module and
> your firmware together"? Sure, people may want to do things
> differently, but what is the real blocker?

0) Firmware upgrades are possible
1) Some firmware is optional
2) Firmware licenses may often not be GPLv2 compatible
3) Some firmwares may be stupid large (remote-proc) as such
   neither built-in firmware nor using the firmware in initramfs
   is reasonable.

But note that Johannes' main point was that today only a few
properly constructed drivers use async fw request, and furthermore
given the lack of a deterministic final rootfs signal his proposal
was to address the lack of semantics available between kernel and
userspcae available for this with a firmware kobject uevent fallback
helper. This fallback kobject uevent helper would not reply firmly against
files not found until it knows all rootfs firmware paths are ready.

> Fundamentally, it seems to me that if a module needs firmware, it
> makes no sense to make the module available before the firmware. I'm
> probably missing something though :)

You are right but just consider all the above.

  Luis
