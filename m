Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sRP2d3y8FzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Sep 2016 04:02:00 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id 2so6961825oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Sep 2016 11:02:00 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160903174939.GB32345@dtor-ws>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Sep 2016 11:01:58 -0700
Message-ID: <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 cocci@systeme.lip6.fr, Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>,
 Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Kevin Cernekee <cernekee@gmail.com>,
 Jeff Mahoney <jeffm@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Felix Fietkau <nbd@nbd.name>, David Howells <dhowells@redhat.com>,
 Vikram Mulukutla <markivx@codeaurora.org>, Alessandro Rubini <rubini@gnudd.com>,
 Tom Gundersen <teg@jklm.no>,
 Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
 Gilles.Muller@lip6.fr,
 linux-serial <linux-serial@vger.kernel.org>, Roman Pen <r.peniaev@gmail.com>,
 Kay Sievers <kay@vrfy.org>, Stephen Boyd <stephen.boyd@linaro.org>,
 nicolas.palix@imag.fr, "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Martinez <martinez@nsup.org>,
 Josh Boyer <jwboyer@fedoraproject.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 3, 2016 at 10:49 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Unfortunately module loading and availability of firmware is very
> loosely coupled.

The whole "let's add a new magical proc entry to say that all
filesystems are mounted" is all about the user space coupling them.

I'm just saying that if user space must know about when firmware is
ready to be loaded anyway, just do it rigth. Not with some hacky "you
can now do random things" flag. But by having user space actually say
"put this module together with this firmware".

If you just put the two pieces together, then the module "will just work".

And quite frankly, that sounds like a much better maintenance practice
anyway. If some module doesn't work without the firmware, then dammit,
the two *should* go together. Putting them in two different places
would be *INSANE*.

                    Linus
