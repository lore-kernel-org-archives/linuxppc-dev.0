Return-Path: <teg@jklm.no>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSx6y4G0GzDvtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:11:19 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id x186so7728692vkd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 13:11:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479202125.12007.24.camel@sipsolutions.net>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de> <20161108224726.GD13978@wotan.suse.de>
 <1479202125.12007.24.camel@sipsolutions.net>
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 29 Nov 2016 22:10:56 +0100
Message-ID: <CAG-2HqVf=YQk2iLFhpsKFZd3HZTG6XG7xY6B4YeX5-bFrwMJFA@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jkosina@suse.cz>, Jouni Malinen <j@w1.fi>,
 Seth Forshee <seth.forshee@canonical.com>,
 Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Daniel Wagner <wagi@monom.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>,
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
 Andy Lutomirski <luto@amacapital.net>, Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Abhay Salunke <Abhay_Salunke@dell.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Nov 15, 2016 at 10:28 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> My argument basically goes like this:
>
> First, given good drivers (i.e. using request_firmware_nowait())
> putting firmware even for a built-in driver into initramfs or not
> should be a system integrator decision. If they don't need the device
> that early, it should be possible for them to delay it. Or, perhaps, if
> the firmware is too big, etc. I'm sure we can all come up with more
> examples of why you'd want to do it one way or another.

This is how I understood the the situation, but I never quite bought
it. What is wrong with the kernel saying "you must put your module and
your firmware together"? Sure, people may want to do things
differently, but what is the real blocker?

Fundamentally, it seems to me that if a module needs firmware, it
makes no sense to make the module available before the firmware. I'm
probably missing something though :)

Cheers,

Tom
