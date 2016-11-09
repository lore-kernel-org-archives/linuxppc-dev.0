Return-Path: <luto@amacapital.net>
Received: from mail-ua0-x232.google.com (mail-ua0-x232.google.com
 [IPv6:2607:f8b0:400c:c08::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDNzZ6NPLzDvWv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 22:21:30 +1100 (AEDT)
Received: by mail-ua0-x232.google.com with SMTP id 20so170952468uak.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 03:21:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cdd43459-346f-c8e9-e8fc-25bd81e9f0ea@bmw-carit.de>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de> <20161108224726.GD13978@wotan.suse.de>
 <cdd43459-346f-c8e9-e8fc-25bd81e9f0ea@bmw-carit.de>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 9 Nov 2016 03:21:07 -0800
Message-ID: <CALCETrVtuiKaJ+z3hSLGYs3robuORJv+N5Z19t0XUzUNynqZDA@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jkosina@suse.cz>, Johannes Berg <johannes@sipsolutions.net>,
 Jouni Malinen <j@w1.fi>,
 Seth Forshee <seth.forshee@canonical.com>, Tom Gundersen <teg@jklm.no>,
 Kay Sievers <kay@vrfy.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Wagner <wagi@monom.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Herbert,
 Marc" <marc.herbert@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Rob Landley <rob@landley.net>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Wu Fengguang <fengguang.wu@intel.com>, Richard Purdie <rpurdie@rpsys.net>,
 Jeff Mahoney <jeffm@suse.com>, Jacek Anaszewski <j.anaszewski@samsung.com>,
 Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Triplett <josh@joshtriplett.org>, Harald Hoyer <harald@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 9, 2016 at 1:13 AM, Daniel Wagner
<daniel.wagner@bmw-carit.de> wrote:
> [CC: added Harald]
>
> As Harald pointed out over a beer yesterday evening, there is at least
> one more reason why UMH isn't obsolete. The ordering of the firmware loading
> might be of important. Say you want to greet the user with a splash screen
> really early on, the graphic card firmware should be loaded first. Also the
> automotive world has this fancy requirement that rear camera must be on the
> screen within 2 seconds. So controlling the firmware loading order is of
> importance (e.g. also do not overcommit the I/O bandwith not so important
> firmwares). A user space helper is able to prioritize the request
> accordingly the use case.

That seems like a valid problem, but I don't think that UMH adequately
solves it.  Sure, loading firmware in the right order avoids a >2sec
delay due to firmware loading, but what happens when you have a slow
USB device that *doesn't* need firmware plugged in to your car's shiny
USB port when you start the car?

It seems to me that this use case requires explicit control over
device probing and, if that gets added, you get your firmware ordering
for free (just probe the important devices first).

--Andy
