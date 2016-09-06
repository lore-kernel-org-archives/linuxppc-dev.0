Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTLvx3k3vzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 08:33:01 +1000 (AEST)
Date: Wed, 7 Sep 2016 00:32:55 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
 Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Slaby <jslaby@suse.com>, Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 Kay Sievers <kay@vrfy.org>, David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20160906223255.GS3296@wotan.suse.de>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <20160906174630.GB15161@tuxbot>
 <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 11:32:05AM -0700, Linus Torvalds wrote:
> On Tue, Sep 6, 2016 at 10:46 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Linus, I reversed the order of your questions/answers to fit my answer
> > better.
> 
> Nobody has actually answered the "why don't we just tie the firmware

This is not about firmware anymore. The fact that we were reading files from
the filesystem in different ways called for a generic API, that was done by
Mimi with the new generic kernel_read_file_from_path(), the fact that there
were race concerns with firmware means such races are also in theory possible
outside of firmware.

> and module together" question.

In terms of the firmware, licensing is one reason I'm aware of. Another reason
is updates to firmware files may not implicate a driver update -- its pointless
to rebuild a kernel if all you need is a firmware update.

For both modules and built-in we already have the option to bundle firmware
into initramfs, and CONFIG_EXTRA_FIRMWARE, some folks do not want to use these.
Bjorn noted a few reasons why. Here's the full list of reasons I've heard why
folks shy away from these:

  o Licensing
  o You still want the ability to do updates
  o The size of the files can be huge (remoteproc is talking about 10 MiB files)

Do we want to bring the firmware closer together than what we allow for modules? If
so it may make sense to use a modpost command to try to bundle module and
firmware together, the build system could use the MODULE_FIRMWARE() for that.
It does mean you now have a build dependency for linux-firmware on the kernel.
Do we want that?

> Really. If the driver doesn't work without the firmware, then why the
> hell is it separated from it in the first place?

This I agree with, although you still have to consider you may want to enable
updates for firmware without a driver update.

  Luis
