Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-ua0-x22b.google.com (mail-ua0-x22b.google.com
 [IPv6:2607:f8b0:400c:c08::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shHbf5HGpzDrLn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 03:41:50 +1000 (AEST)
Received: by mail-ua0-x22b.google.com with SMTP id 107so72454964uah.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 10:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
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
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Sep 2016 10:41:46 -0700
Message-ID: <CAKdAkRQhEdaP+z02DQ9nighSg_N8R+Dnkv7x3EkYc_YmO_jW4g@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: "Herbert, Marc" <marc.herbert@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, cocci@systeme.lip6.fr,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
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
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Roman Pen <r.peniaev@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2016 at 6:37 PM, Herbert, Marc <marc.herbert@intel.com> wro=
te:
> On 03/09/2016 11:10, Dmitry Torokhov wrote:
>> I was thinking if we kernel could post
>> "conditions" (maybe simple stings) that it waits for, and userspace
>> could unlock these "conditions". One of them might be "firmware
>> available".
>
> On idea offered by Josh Triplett that seems to overlap with this one
> is to have something similar to the (deprecated) userhelper with
> *per-blob* requests and notifications except for one major difference:
> userspace would not anymore be in charge of *providing* the blob but
> would instead only *signal* when a given blob becomes available and is
> either found or found missing. Then the kernel loads the blob _by
> itself_; unlike the userhelper. No new =E2=80=9Ccritical filesystem=E2=80=
=9D concept
> and a *per-blob basis*, allowing any variation of blob locations
> across any number of initramfs and filesystems.
>

Really, I do not quite understand why people have issues with usermode
helper/uevents. It used to work reasonably well (if you were using
request_firmware_nowait()), as the kernel would post the request and
then, when userspace was ready[^Hier], uevents would be processed and
firmware would be loaded. We had a timeout of 60(?) seconds by
default, but that would be adjusted as systems needed.

Unfortunately it all broke when udev started insisting [1] on
servicing some uevents in strict sequence, which resulted in boot
stalls. Maybe the ultimate answer is to write a firmware loading
daemon that would also listen to netlink events and do properly what
udev refused to be doing? The distribution would know when it is ready
to service firmware requests (and thus when to start this daemon), and
we would have the freedom of having drivers both built-in and as
modules and bulding firmware into kernel, intiramfs or keep on a
"real" fs available at later time.

Thanks.

--=20
Dmitry

[1] https://lwn.net/Articles/518942/
