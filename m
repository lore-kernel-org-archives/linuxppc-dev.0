Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spcDn490JzDskd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:32:25 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id d132so1357033oib.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 17:32:25 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAB=NE6UXX+=nnJcOgO7NWudmDR3bESVO-mQrqG26Gpd4z71xqA@mail.gmail.com>
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
 <CA+55aFx=hzXhrHQO4-0Jnd1ML4dismQ8qggvSp0yccSRW6qH3A@mail.gmail.com>
 <CAB=NE6UXX+=nnJcOgO7NWudmDR3bESVO-mQrqG26Gpd4z71xqA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Oct 2016 17:32:22 -0700
Message-ID: <CA+55aFwzVL=gkQ3GnOs+K1OHor7tjwA=9uh-Jfwz8J3KyvJ=8A@mail.gmail.com>
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

On Tue, Oct 4, 2016 at 5:24 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> Note that the races are beyond firmware, so all
> kernel_read_file_from_path() users, as such re-using such old /sys/
> interafeces for firmware will not suffice to cover all ground now for
> the same race for other possible users.

Blah blah blah.

The reason I've hated this whole discussion is that it's full of
"let's re-architect everything", and then it has these horribly warty
interfaces. It's classic second-system syndrome.

Just do *one* thing, and do it well. Don't change anything else. Don't
force existign drivers to use new interfaces. Don't over-architect,
and don't do stupid interfaces.

If user-space mounts a new filesystem (or just unpacks files from a
tar-file that has firmware images in it, for chissake), that is not
some magical "critical mount event". The whole concept is just stupid.
Is it a "mount event" when the user downloads a new firmware image
from the internet?

HELL NO.

But what is equally stupid is to then dismiss simple models because
some totally unrelated "beyond firmware" issue.

Anything that is "beyond firmware" shouldn't even be discussed, for
chrissake! It has nothing what-so-ever to do with firmware loading. If
there ends up being some common helper functions, and shared code,
that *still* doesn't make it so.

Basic rules of thumb:

 (a) don't over-design

 (b) don't have stupid illogical interfaces

 (c) don't conflate different issues just because you think they may
have shared code.

 (4) be consistent. Don't make up new interfaces, and most certainly
do *NOT* dismiss something just because it's what we have done before.

That's it.

                Linus
