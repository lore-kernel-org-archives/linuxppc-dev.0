Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sq3V10T2QzDrPK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Oct 2016 05:00:24 +1100 (AEDT)
Date: Wed, 5 Oct 2016 20:00:17 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Rob Landley <rob@landley.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de,
 Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, jslaby@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>, rpurdie@rpsys.net,
 Jeff Mahoney <jeffm@suse.com>, j.anaszewski@samsung.com,
 Abhay_Salunke@dell.com, Julia Lawall <Julia.Lawall@lip6.fr>,
 Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
 Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>, cocci@systeme.lip6.fr,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161005180017.GD3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2016 at 09:38:17PM -0500, Rob Landley wrote:
> On 09/02/2016 07:20 PM, Luis R. Rodriguez wrote:
> > kernel_read_file_from_path() can try to read a file from
> > the system's filesystem. This is typically done for firmware
> > for instance, which lives in /lib/firmware. One issue with
> > this is that the kernel cannot know for sure when the real
> > final /lib/firmare/ is ready, and even if you use initramfs
> > drivers are currently initialized *first* prior to the initramfs
> > kicking off.
> 
> Why?

do_initcalls() is called prior to prepare_namespace(), other than that
we have no strict rules over where the real rootfs should be, and since
we have pivot_root() its up to userspace to decide when/how the real
rootfs goes. This and the fact that its also up to userspace to design
what files to place in initramfs of further rootfs -- only userspace
will know for sure when all firmware for all drivers is really ready.

> > During init we run through all init calls first
> > (do_initcalls()) and finally the initramfs is processed via
> > prepare_namespace():
> 
> What's the downside of moving initramfs cpio extraction earlier in the boot?

That would help users of initrafms, some folks seem to not want to use
initramfs, one of such users are that of the large firmwares for remote-proc
(Documentation/remoteproc.txt), we're talking about over 200 MiB for some
firmware for example.

> I did some shuffling around of those code to make initmpfs work, does
> anybody know why initramfs extraction _before_ we initialize drivers
> would be a bad thing?

No, but it seems sensible to me, if its done before do_initcalls()
that should resolve the race for initramfs users but -- so long
as the drivers that need firmware early are dumped into initramfs.
We have no assurances/warnings for this, but we can add such things
if we want them. This would not resolve the race for non-initramfs
users / pivot_root() changes.

  Luis
