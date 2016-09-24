Return-Path: <marc.herbert@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgtC251smzDsqQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 11:37:32 +1000 (AEST)
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 cocci@systeme.lip6.fr, Jacek Anaszewski <j.anaszewski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski
 <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Michal Marek <mmarek@suse.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>,
 Daniel Vetter <daniel.v>
From: "Herbert, Marc" <marc.herbert@intel.com>
Message-ID: <2deae6da-dd43-7bff-e1fd-ffd26946b928@intel.com>
Date: Fri, 23 Sep 2016 18:37:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2016 11:10, Dmitry Torokhov wrote:
> I was thinking if we kernel could post
> "conditions" (maybe simple stings) that it waits for, and userspace
> could unlock these "conditions". One of them might be "firmware
> available".

On idea offered by Josh Triplett that seems to overlap with this one
is to have something similar to the (deprecated) userhelper with
*per-blob* requests and notifications except for one major difference:
userspace would not anymore be in charge of *providing* the blob but
would instead only *signal* when a given blob becomes available and is
either found or found missing. Then the kernel loads the blob _by
itself_; unlike the userhelper. No new “critical filesystem” concept
and a *per-blob basis*, allowing any variation of blob locations
across any number of initramfs and filesystems.

Could this one fly?
