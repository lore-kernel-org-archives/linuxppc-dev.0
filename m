Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sq3fx3grLzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Oct 2016 05:08:09 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id o93so4487857oik.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Oct 2016 11:08:09 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20161005180017.GD3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Oct 2016 11:08:06 -0700
Message-ID: <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Rob Landley <rob@landley.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Slaby <jslaby@suse.com>, Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>, Richard Purdie <rpurdie@rpsys.net>,
 Jeff Mahoney <jeffm@suse.com>, Jacek Anaszewski <j.anaszewski@samsung.com>,
 Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr,
 Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 cocci@systeme.lip6.fr, linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 5, 2016 at 11:00 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Sep 13, 2016 at 09:38:17PM -0500, Rob Landley wrote:
>
>> I did some shuffling around of those code to make initmpfs work, does
>> anybody know why initramfs extraction _before_ we initialize drivers
>> would be a bad thing?
>
> No, but it seems sensible to me, if its done before do_initcalls()
> that should resolve the race for initramfs users

initramfs should already be set up before drivers are. Exactly what is
it that has trouble right now?

The gating issue for initramfs is that technically the filesystem
setup needs to be done, which means that it currently ends up being
populated _fairly_ late in the initcall series, but certainly before
drivers. But since initramfs really only needs very limited filesystem
functionality, I assume Rob had few problems with just moving it
earlier.

Still, what kind of ordering issues did people have? What is it that
needs to load files even before driver init? Some crazy subsystem?

                   Linus
