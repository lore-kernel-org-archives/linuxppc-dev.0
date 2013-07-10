Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8DCC2C02CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 04:25:15 +1000 (EST)
Date: Wed, 10 Jul 2013 13:24:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <386A14D3-0968-4FC5-B273-D5D510ADDAF3@suse.de> (from
 agraf@suse.de on Wed Jul 10 05:23:36 2013)
Message-ID: <1373480698.8183.218@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 05:23:36 AM, Alexander Graf wrote:
>=20
> On 10.07.2013, at 00:26, Scott Wood wrote:
>=20
> > On 07/09/2013 05:00:26 PM, Alexander Graf wrote:
> >> It'll also be more flexible at the same time. You could take the =20
> logs and actually check what's going on to debug issues that you're =20
> encountering for example.
> >> We could even go as far as sharing the same tool with other =20
> architectures, so that we only have to learn how to debug things once.
> >
> > Have you encountered an actual need for this flexibility, or is it =20
> theoretical?
>=20
> Yeah, first thing I did back then to actually debug kvm failures was =20
> to add trace points.

I meant specifically for handling exit timings this way.

> > Is there common infrastructure for dealing with measuring intervals =20
> and tracking statistics thereof, rather than just tracking points and =20
> letting userspace connect the dots (though it could still do that as =20
> an option)?  Even if it must be done in userspace, it doesn't seem =20
> like something that should be KVM-specific.
>=20
> Would you like to have different ways of measuring mm subsystem =20
> overhead? I don't :). The same goes for KVM really. If we could =20
> converge towards a single user space interface to get exit timings, =20
> it'd make debugging a lot easier.

I agree -- that's why I said it doesn't seem like something that should =20
be KVM-specific.  But that's orthogonal to whether it's done in kernel =20
space or user space.  The ability to get begin/end events from =20
userspace would be nice when it is specifically requested, but it would =20
also be nice if the kernel could track some basic statistics so we =20
wouldn't have to ship so much data around to arrive at the same result.

At the very least, I'd like such a tool/infrastructure to exist before =20
we start complaining about doing minor maintenance of the current =20
mechanism.

> We already have this for the debugfs counters btw. And the timing =20
> framework does break kvm_stat today already, as it emits textual =20
> stats rather than numbers which all of the other debugfs stats do. =20
> But at least I can take the x86 kvm_stat tool and run it on ppc just =20
> fine to see exit stats.

We already have what?  The last two sentences seem contradictory -- can =20
you or can't you use kvm_stat as is?  I'm not familiar with kvm_stat.

What does x86 KVM expose in debugfs?

> >> > Lots of debug options are enabled at build time; why must this =20
> be different?
> >> Because I think it's valuable as debug tool for cases where =20
> compile time switches are not the best way of debugging things. It's =20
> not a high profile thing to tackle for me tbh, but I don't really =20
> think working heavily on the timing stat thing is the correct path to =20
> walk along.
> >
> > Adding new exit types isn't "working heavily" on it.
>=20
> No, but the fact that the first patch is a fix to add exit stats for =20
> exits that we missed out before doesn't give me a lot of confidence =20
> that lots of people use timing stats. And I am always very weary of =20
> #ifdef'ed code, as it blows up the test matrix heavily.

I used it quite a lot when I was doing KVM performance work.  It's just =20
been a while since I last did that.

-Scott=
