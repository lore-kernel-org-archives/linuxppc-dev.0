Return-Path: <rob@landley.net>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYm1v2hTNzDsF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 12:38:26 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id x192so305221itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 19:38:26 -0700 (PDT)
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar
 <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Ming Lei <ming.lei@canonical.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de,
 Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, jslaby@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Wu Fengguang
 <fengguang.wu@intel.com>, rpurdie@rpsys.net, Jeff Mahoney <jeffm@suse.com>,
 j.anaszewski@samsung.com, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 Kay Sievers <kay@vrfy.org>, David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>, cocci@systeme.lip6.fr,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Rob Landley <rob@landley.net>
Message-ID: <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
Date: Tue, 13 Sep 2016 21:38:17 -0500
MIME-Version: 1.0
In-Reply-To: <20160903002014.GP3296@wotan.suse.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/2016 07:20 PM, Luis R. Rodriguez wrote:
> kernel_read_file_from_path() can try to read a file from
> the system's filesystem. This is typically done for firmware
> for instance, which lives in /lib/firmware. One issue with
> this is that the kernel cannot know for sure when the real
> final /lib/firmare/ is ready, and even if you use initramfs
> drivers are currently initialized *first* prior to the initramfs
> kicking off.

Why?

> During init we run through all init calls first
> (do_initcalls()) and finally the initramfs is processed via
> prepare_namespace():

What's the downside of moving initramfs cpio extraction earlier in the boot?

I did some shuffling around of those code to make initmpfs work, does
anybody know why initramfs extraction _before_ we initialize drivers
would be a bad thing? (The cpio is in memory, either linked into the
kernel or from the bootloader. No drivers are needed to extract it,
that's sort of the point.)

The only things I can think of are memory churn (large contiguous
physical page allocations), or if a driver somehow got us access to more
physical memory?

Rob
