Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sq30z4KTmzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Oct 2016 04:38:42 +1100 (AEDT)
Date: Wed, 5 Oct 2016 19:38:35 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Herbert, Marc" <marc.herbert@intel.com>,
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
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Roman Pen <r.peniaev@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Takashi Iwai <tiwai@suse.de>, Jeff Mahoney <jeffm@suse.com>,
 Hariprasad S <hariprasad@chelsio.com>, Benjamin Poirier <bpoirier@suse.de>,
 Josh Triplett <josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20161005173835.GC3296@wotan.suse.de>
References: <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
 <CAKdAkRQhEdaP+z02DQ9nighSg_N8R+Dnkv7x3EkYc_YmO_jW4g@mail.gmail.com>
 <20161005000008.GY3296@wotan.suse.de>
 <CA+55aFx=hzXhrHQO4-0Jnd1ML4dismQ8qggvSp0yccSRW6qH3A@mail.gmail.com>
 <CAB=NE6UXX+=nnJcOgO7NWudmDR3bESVO-mQrqG26Gpd4z71xqA@mail.gmail.com>
 <CA+55aFwzVL=gkQ3GnOs+K1OHor7tjwA=9uh-Jfwz8J3KyvJ=8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwzVL=gkQ3GnOs+K1OHor7tjwA=9uh-Jfwz8J3KyvJ=8A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 04, 2016 at 05:32:22PM -0700, Linus Torvalds wrote:
> On Tue, Oct 4, 2016 at 5:24 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >
> > Note that the races are beyond firmware, so all
> > kernel_read_file_from_path() users, as such re-using such old /sys/
> > interafeces for firmware will not suffice to cover all ground now for
> > the same race for other possible users.
> 
> Blah blah blah.
> 
> The reason I've hated this whole discussion is that it's full of
> "let's re-architect everything", and then it has these horribly warty
> interfaces.

To be clear, kernel_read_file_from_path() was an agreed upon strategy
about 1 year ago at the Linux Security summit as we found different
kernel implementations for the same exact task, reading files from
the filesystem -- my point here was simply that acknowledging that the
race on early init and driver's init / probe for firmware is implicating
that the race is *also* possible for the other kernel-read-from-fs points.
Its not clear to me what your grudge here is other than the proposal
for a solution in this patch is not what we want.

> It's classic second-system syndrome.
> 
> Just do *one* thing, and do it well. Don't change anything else. Don't
> force existign drivers to use new interfaces. Don't over-architect,
> and don't do stupid interfaces.

If there is a race for the other users and we want to avoid wrapping
a solution for it to the other callers without doing any vetting for
correctness then so be it, but to disregard completely seems error-prone.
I accept that thinking about such other users may complicate a solution
for firmware and if you prefer we just separate the race solution for
both that's fine.

> If user-space mounts a new filesystem (or just unpacks files from a
> tar-file that has firmware images in it, for chissake), that is not
> some magical "critical mount event". The whole concept is just stupid.
> Is it a "mount event" when the user downloads a new firmware image
> from the internet?
> 
> HELL NO.

We've gotten passed that the original implementation proposed is not what we
want, let's move on.

> But what is equally stupid is to then dismiss simple models because
> some totally unrelated "beyond firmware" issue.

I have not heard back from the other stakeholders using
kernel_read_file_from_path() and possible races for them. You seem to suggest
to ignore those possible theoretical races in the name of a simple solution for
firmware. Fine.

> Anything that is "beyond firmware" shouldn't even be discussed, for
> chrissake! It has nothing what-so-ever to do with firmware loading. If
> there ends up being some common helper functions, and shared code,
> that *still* doesn't make it so.

My point was to raise the flag of the possible races on the other call sites
where we read files directly from the kernel, that's all, if we agree we really
don't care for that fine.

> Basic rules of thumb:
> 
>  (a) don't over-design
> 
>  (b) don't have stupid illogical interfaces
> 
>  (c) don't conflate different issues just because you think they may
> have shared code.
> 
>  (4) be consistent. Don't make up new interfaces, and most certainly
> do *NOT* dismiss something just because it's what we have done before.
> 
> That's it.

OK..

  Luis
