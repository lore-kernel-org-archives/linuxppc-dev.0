Return-Path: <bjorn.andersson@linaro.org>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTLqD1fmrzDrpN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 08:28:55 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id 128so3237028pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 15:28:55 -0700 (PDT)
Date: Tue, 6 Sep 2016 15:28:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Ming Lei <ming.lei@canonical.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kevin Cernekee <cernekee@gmail.com>, Jeff Mahoney <jeffm@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Felix Fietkau <nbd@nbd.name>,
 David Howells <dhowells@redhat.com>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Alessandro Rubini <rubini@gnudd.com>, Tom Gundersen <teg@jklm.no>,
 Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
 Gilles.Muller@lip6.fr, linux-serial <linux-serial@vger.kernel.org>,
 Roman Pen <r.peniaev@gmail.com>, Kay Sievers <kay@vrfy.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, nicolas.palix@imag.fr,
 "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Martinez <martinez@nsup.org>,
 Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20160906222847.GF15161@tuxbot>
References: <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <20160906215204.GR3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160906215204.GR3296@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 06 Sep 14:52 PDT 2016, Luis R. Rodriguez wrote:

> We already have MODULE_FIRMWARE(), we could have MODULE_FIRMWARE_REQ() or
> something like it to help annotate the the driver was only functional with the
> firmware, punt things to kmod to deal with the requirements.

That implies that a single driver will only use a single version of the
firmware. There are cases where we want a single driver to load firmware
depending on e.g. hardware revisions, or previous firmware version and
there are cases where we want to load firmware based on requested
use-cases.

Regards,
Bjorn
