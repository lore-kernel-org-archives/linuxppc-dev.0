Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spbpP0t8FzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:13:01 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id h186so10488946oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 17:13:01 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20161005000008.GY3296@wotan.suse.de>
References: <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
 <CAKdAkRQhEdaP+z02DQ9nighSg_N8R+Dnkv7x3EkYc_YmO_jW4g@mail.gmail.com>
 <20161005000008.GY3296@wotan.suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Oct 2016 17:12:58 -0700
Message-ID: <CA+55aFx=hzXhrHQO4-0Jnd1ML4dismQ8qggvSp0yccSRW6qH3A@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Herbert,
 Marc" <marc.herbert@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Roman Pen <r.peniaev@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Takashi Iwai <tiwai@suse.de>,
 Jeff Mahoney <jeffm@suse.com>,
 Hariprasad S <hariprasad@chelsio.com>, Benjamin Poirier <bpoirier@suse.de>,
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

On Tue, Oct 4, 2016 at 5:00 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> I am not sure how/why a firmware loading daemon would be a better
> idea now. What Marc describes that Josh proposed with signals for
> userspcae seems more aligned with what we likely need

Quite frankly, I doubt you want a signal.

You will want to have some way to specify where the firmware files
are. Right now we have "fw_path[]" which is hardcoded except for the
first entry that can be set as a module parameter. But you'd probably
want to expand on that, which implies some /sys or /proc interface.

And once you do that, wouldn't it make more sense to just make the
"update the firmware path /proc/sys/kernel/fw_path file" make things
re-search for firmware?

In other words, the interface has to be something *sensible*. Not some
idiotic ad-hoc "send a signal" (of which that stupid original patch
was just a very odd example).

                      Linus
