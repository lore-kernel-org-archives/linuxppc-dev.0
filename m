Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQx1T06q9zDrht
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 09:59:24 +1000 (AEST)
Date: Sat, 3 Sep 2016 01:59:16 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <20160902235916.GO3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160825194133.GC3296@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2016 at 09:41:33PM +0200, Luis R. Rodriguez wrote:
> On Thu, Aug 25, 2016 at 01:05:44PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Some users want a fully running gfx stack 2s after power-on. There's
> > not even enough time to load an uefi or vga driver first. i915
> > directly initializes the gpu from power-on state on those.
> 
> I see.. thanks.
> 
> > >> I think what would work is loading the different subsystems of the
> > >> driver in parallel (we already do that largely)
> > >
> > > Init level stuff is actually pretty synchronous, and in fact both
> > > init and probe are called serially. There are a few subsystems which
> > > have been doing things a bit differently, but these are exceptions.
> > >
> > > When you say we already do this largely, can you describe a bit more
> > > precisely what you mean ?
> > 
> > Oh, this isn't subsystems as in linux device/driver model, but
> > different parts within the driver. We fire up a bunch of struct work
> > to get various bits done asynchronously.
> 
> Thanks for the clarification.

<-- snip -->

> > One of the proposals which would have worked for us died a while back:
> > 
> > https://lkml.org/lkml/2014/6/15/47
> 
> Interesting, the problem stated here, which comes from the fact (as clarified
> above) the rootfs comes up only *after* we run do_initcalls() as such there are
> possible theoretical races even with request_firmware_nowait() -- as such that
> justifies even more the SmPL grammar rule to include even request_firmware_nowait()
> on probe / init as this patch has.
> 
> Anyway yeah that patch has good intentions but its wrong for a slew of reasons.
> The problem is the same as discussed with Bjorn recently. The solution
> discussed is that since only userspace knows when the *real* rootfs is ready
> (because of slew of reasons) the best we can do is have an event issued by
> userspace to inform us of that.

OK I have something I think we can build upon for this. Will send RFC.

  Luis
