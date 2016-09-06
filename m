Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTKzL02LPzDrpb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 07:50:53 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id v82so10459176oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 14:50:53 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160906211117.GE15161@tuxbot>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <20160906174630.GB15161@tuxbot>
 <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
 <20160906211117.GE15161@tuxbot>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Sep 2016 14:50:51 -0700
Message-ID: <CA+55aFyH8jbJQbmEhxxGd2RX3D8iBHuxTmPaBM6HC38FCX295g@mail.gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
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

On Tue, Sep 6, 2016 at 2:11 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 06 Sep 11:32 PDT 2016, Linus Torvalds wrote:
>
>> On Tue, Sep 6, 2016 at 10:46 AM, Bjorn Andersson
>> Nobody has actually answered the "why don't we just tie the firmware
>> and module together" question.
>
> The answer to this depends on the details of the suggestion; but
> generally there's a much stronger bond between the kernel and the driver
> than between the driver and the firmware in my cases.

I call BS.

Let me be very clear. I'm not applying that shit-for-brains stupid
patch, and will not be pulling it unless somebody tricks me into it.

Because all these arguments make no sense at all.

If the driver doesn't work without the firmware, then anybody who
distributes the driver binary without a firmware is just
*fundamentally* doing something insane. You may do it for
*development* purposes, but doing so for actual *use* would be
entirely pointless.

See my point? If a distribution is distributing the driver without the
firmware, then what the hell is the point of such a thing?

But even if you decide to do that for some odd reason, the patch is
still just stupid. Instead of adding some crazy infrastructure for
"now I've mounted everything", you could equally well just

 (a) make the driver fail the module load if it cannot find a firmware binary

 (b) after user space has mounted everything, just do "insmod -a"
again (or insmod just that driver).

See? The point is, this "generic" hacky interface is just stupid. It's
not adding any value. If you add user space "I'm ready now" points
anyway, you might as well make those points do the right thing and
just load the module that is now loadable.

We could mark such "late loading" modules explicitly if people want
to, so that you can automate the whole thing about delaying the
loading in user space.

At no point does it make sense to say "I have now mounted all the
important filesystems". Maybe the firmware is extracted later by user
space downloading it from the internet, and the module will then work
only after that point"./

This whole "I have mounted important filesystems" is just pure and
utter garbage. Stop pushing this shit.

                 Linus
