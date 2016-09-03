Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sR2cS4T3qzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 14:11:35 +1000 (AEST)
Received: by mail-oi0-x236.google.com with SMTP id p186so152219030oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 21:11:35 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160903002014.GP3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Sep 2016 21:11:32 -0700
Message-ID: <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>,
 Roman Pen <r.peniaev@gmail.com>,
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
 cocci@systeme.lip6.fr, linux-serial@vger.kernel.org,
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

On Fri, Sep 2, 2016 at 5:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> Thoughts ?

I really think this is a horrible hack.

It's basically the kernel giving up, and relying on user space to give
a single flag, and it's broken nasty crap.  Worse, it's broken nasty
crap with a user interface, so we'll be stuck with it forever. Please
no.

What are the drivers that need this, and why can't those drivers just
be fixed to not do braindead things?

                    Linus
