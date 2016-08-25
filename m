Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKwfr2YYlzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:25:56 +1000 (AEST)
Date: Thu, 25 Aug 2016 22:25:49 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>,
 =?iso-8859-1?Q?J=F6rg_R=F6del?= <jroedel@suse.de>,
 Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Ming Lei <ming.lei@canonical.com>,
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
Message-ID: <20160825202549.GF3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2016 at 10:10:52PM +0200, Daniel Vetter wrote:
> Cutting down since a lot of this is probably better discussed at
> ks/lpc. Aside, if you want to check out Chris Wilson's work on our new
> depency handling, it's called kfence.
> 
> https://lkml.org/lkml/2016/7/17/37

Thanks more reading.. :)

> On Thu, Aug 25, 2016 at 9:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> > So .. I agree, let's avoid the hacks. Patches welcomed.
> >>
> >> Hm, this is a definite change of tack - back when I discussed this
> >> with Greg about 2 ks ago it sounded like "don't do this". The only
> >> thing we need is some way to wait for rootfs before we do the
> >> request_firmware. Everything else we handle already in the kernel.
> >
> > OK so lets just get this userspace event done, and we're set.
> 
> Ah great. As long as that special wait-for-rootfs-pls firmware request
> is still allowed, i915&gfx folks will be happy. We will call it from
> probe though ;-) but all from our own workers.

We should strive for this to be transparent to drivers, ie, this safeguard of
looking for firmware should be something handled by the kernel as otherwise
we're just forcing a race condition given the review in the last thread.

  Luis
