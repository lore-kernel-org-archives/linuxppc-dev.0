Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTMcV2zm1zDrpT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 09:04:42 +1000 (AEST)
Date: Wed, 7 Sep 2016 01:04:31 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>,
 Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Slaby <jslaby@suse.com>, Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Richard Purdie <rpurdie@rpsys.net>, Jeff Mahoney <jeffm@suse.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Abhay_Salunke@dell.com,
 Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr,
 nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>,
 Kay Sievers <kay@vrfy.org>, David Howells <dhowells@redhat.com>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Message-ID: <20160906230431.GT3296@wotan.suse.de>
References: <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <20160906174630.GB15161@tuxbot>
 <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
 <20160906211117.GE15161@tuxbot>
 <CA+55aFyH8jbJQbmEhxxGd2RX3D8iBHuxTmPaBM6HC38FCX295g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFyH8jbJQbmEhxxGd2RX3D8iBHuxTmPaBM6HC38FCX295g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 02:50:51PM -0700, Linus Torvalds wrote:
> On Tue, Sep 6, 2016 at 2:11 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Tue 06 Sep 11:32 PDT 2016, Linus Torvalds wrote:
> >
> >> On Tue, Sep 6, 2016 at 10:46 AM, Bjorn Andersson
> >> Nobody has actually answered the "why don't we just tie the firmware
> >> and module together" question.
> >
> > The answer to this depends on the details of the suggestion; but
> > generally there's a much stronger bond between the kernel and the driver
> > than between the driver and the firmware in my cases.
> 
> I call BS.
> 
> Let me be very clear. I'm not applying that shit-for-brains stupid
> patch, and will not be pulling it unless somebody tricks me into it.

Great thanks. Please note that the only reason I proposed this was to
get the ball rolling in terms of finding a solution to the problem for why
some folks claim they *need* the firmware usermode helper. Granted, upstream
we only have 2 explicit users left, I'm told some out-of-tree users still
need and use the usermode helper.

They claim that without it there is the race between /lib/firmware being ready
and driver asking for the firmware. I was told there were quite a bit
of out-of-tree hacks to address this without using the usermode helper,
the goal of this patch was to create the discussion needed to a proper
resolution to this.

Given that upon inspection -- I've determined that even if you stuff the
firmware into initramfs you may still run into the race (the commit log of this
patch explains that) and that using initramfs was the alternative solution we
expected folks to use -- the only current deterministic sure way a driver can
depend on a firmware and avoid the race is to use CONFIG_EXTRA_FIRMWARE. This
is an issue.

> Because all these arguments make no sense at all.
> 
> If the driver doesn't work without the firmware, then anybody who
> distributes the driver binary without a firmware is just
> *fundamentally* doing something insane.

Some companies only redistribute firmware binaries to specific entities due to
avoid expanding to whom a patent grant is given to. That is, not every company
writing drivers or pushing out binary drivers is willing to dish out the
firmware as per the terms in linux-firmware.

> You may do it for *development* purposes, but doing so for actual *use* would
> be entirely pointless.

To be fair we haven't been explicit about our requirements for firmware_class
and expectations about what we expect for firmware for driver in Linux. This
has all been rather loose.

Furthermore the race issues we have found in firmware_class have only come about
through introspection, and I've been slowly documenting all this tribal knowledge.

> See my point? If a distribution is distributing the driver without the
> firmware, then what the hell is the point of such a thing?

Agreed.

> But even if you decide to do that for some odd reason, the patch is
> still just stupid. Instead of adding some crazy infrastructure for
> "now I've mounted everything", you could equally well just
> 
>  (a) make the driver fail the module load if it cannot find a firmware binary

Not sure if its clear but:

0) this is not just about firmware anymore
1) there is a race between using kernel_read_file_from_path() and
   having the filesystem that should be present on be ready;
2) Only *userspace* can know for sure what the real valid filesystem for
   files read from kernel_read_file_from_path() can be ready, so only userspace
   can tell the kernel if a read from kernel_read_file_from_path() is
   at a certain point in time valid.

>  (b) after user space has mounted everything, just do "insmod -a"
> again (or insmod just that driver).

I'm happy to document this as the resolution... I have a feeling some folks
will not like it. We also have built-in drivers to consider, what do we
advise for that? Keep in mind only CONFIG_EXTRA_FIRMWARE is deterministically
safe.

> See? The point is, this "generic" hacky interface is just stupid. It's
> not adding any value. If you add user space "I'm ready now" points
> anyway, you might as well make those points do the right thing and
> just load the module that is now loadable.

This is not about firmware anymore though, and we need to address built-in.

> We could mark such "late loading" modules explicitly if people want
> to, so that you can automate the whole thing about delaying the
> loading in user space.

Now *that* could actually help, for instance add another late
init call which would be called after initramfs and friends -- perhaps
way after prepare_namespace() -- by then we would ensure userspace has
all critical fs mounted. The problem though is we'd still need a way
for userspace to tell the kernel that all critical fs are mounted
as only userspace can know this for sure.

When is that done? How would the kernel know?

We do have PROBE_PREFER_ASYNCHRONOUS, but that does not provide any
guarantees over ready filesystems.

> At no point does it make sense to say "I have now mounted all the
> important filesystems". Maybe the firmware is extracted later by user
> space downloading it from the internet, and the module will then work
> only after that point"./
> 
> This whole "I have mounted important filesystems" is just pure and
> utter garbage. Stop pushing this shit.

Happy to do so, we do however need to document what we do expect users and
developers to do about this race for both drivers and built-in, keeping
in mind this is also for any users of kernel_read_file_from_path() as well.

  Luis
