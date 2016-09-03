Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sR2pD6pByzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 14:20:04 +1000 (AEST)
Received: by mail-ua0-x22d.google.com with SMTP id q42so135604471uaq.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 21:20:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 2 Sep 2016 21:20:01 -0700
Message-ID: <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
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
 Hauke Mehrtens <hauke@hauke-m.de>,
 Josh Boyer <jwboyer@fedoraproject.org>, Jiri Slaby <jslaby@suse.com>,
 Andy Lutomirski <luto@amacapital.net>, Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 cocci@systeme.lip6.fr, linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 2, 2016 at 9:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Sep 2, 2016 at 5:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>>
>> Thoughts ?
>
> I really think this is a horrible hack.
>
> It's basically the kernel giving up, and relying on user space to give
> a single flag, and it's broken nasty crap.  Worse, it's broken nasty
> crap with a user interface, so we'll be stuck with it forever. Please
> no.

I agree that interface is bad, but I do believe we need something like this...

>
> What are the drivers that need this, and why can't those drivers just
> be fixed to not do braindead things?

Like what? Some devices do need to have firmware loaded so we know
their capabilities, so we really can't push the firmware loading into
"open". If your touch controller for some reason decided to crap over
it's nvram and comes in bootloader mode it is nice for it to slurp in
config data or firmware so use does not have to trigger update
manually. And while the controller is in bootloader mode we can't
create input device because we do not know what capabilities to
declare.

These devices we want to probe asynchronously and simply tell firmware
loader to wait for firmware to become available. The problem we do not
know when to give up, since we do not know where the firmware might
be. But userspace knows and can tel us.

Thanks.

-- 
Dmitry
