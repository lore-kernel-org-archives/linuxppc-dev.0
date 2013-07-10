Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0C1B02C016A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 08:47:15 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373480698.8183.218@snotra>
Date: Thu, 11 Jul 2013 00:47:08 +0200
Message-Id: <FC02BF06-5C20-4AE2-97ED-105EFE9E0D34@suse.de>
References: <1373480698.8183.218@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 10.07.2013, at 20:24, Scott Wood wrote:

> On 07/10/2013 05:23:36 AM, Alexander Graf wrote:
>> On 10.07.2013, at 00:26, Scott Wood wrote:
>> > On 07/09/2013 05:00:26 PM, Alexander Graf wrote:
>> >> It'll also be more flexible at the same time. You could take the =
logs and actually check what's going on to debug issues that you're =
encountering for example.
>> >> We could even go as far as sharing the same tool with other =
architectures, so that we only have to learn how to debug things once.
>> >
>> > Have you encountered an actual need for this flexibility, or is it =
theoretical?
>> Yeah, first thing I did back then to actually debug kvm failures was =
to add trace points.
>=20
> I meant specifically for handling exit timings this way.

No, but I did encounter the need for debugging exits. And the only thing =
we would need to get exit timing stats once we already have trace points =
for exit types would be to have trace points for guest entry and maybe =
type specific events to indicate what the exit is about as well.

>=20
>> > Is there common infrastructure for dealing with measuring intervals =
and tracking statistics thereof, rather than just tracking points and =
letting userspace connect the dots (though it could still do that as an =
option)?  Even if it must be done in userspace, it doesn't seem like =
something that should be KVM-specific.
>> Would you like to have different ways of measuring mm subsystem =
overhead? I don't :). The same goes for KVM really. If we could converge =
towards a single user space interface to get exit timings, it'd make =
debugging a lot easier.
>=20
> I agree -- that's why I said it doesn't seem like something that =
should be KVM-specific.  But that's orthogonal to whether it's done in =
kernel space or user space.  The ability to get begin/end events from =
userspace would be nice when it is specifically requested, but it would =
also be nice if the kernel could track some basic statistics so we =
wouldn't have to ship so much data around to arrive at the same result.
>=20
> At the very least, I'd like such a tool/infrastructure to exist before =
we start complaining about doing minor maintenance of the current =
mechanism.

I admit that I don't fully understand qemu/scripts/kvm/kvm_stat, but it =
seems to me as if it already does pretty much what we want. It sets up a =
filter to only get events and their time stamps through.

It does use normal exit trace points on x86 to replace the old debugfs =
based stat counters. And it seems to work reasonably well for that.

>=20
>> We already have this for the debugfs counters btw. And the timing =
framework does break kvm_stat today already, as it emits textual stats =
rather than numbers which all of the other debugfs stats do. But at =
least I can take the x86 kvm_stat tool and run it on ppc just fine to =
see exit stats.
>=20
> We already have what?  The last two sentences seem contradictory -- =
can you or can't you use kvm_stat as is?  I'm not familiar with =
kvm_stat.

Kvm_stat back in the day used debugfs to give you an idea on what exit =
event happens most often. That mechanism got replaced by trace points =
later which the current kvm_stat uses.

I still have a copy of the old kvm_stat that I always use to get a first =
feeling for what goes wrong if something goes wrong. The original code =
couldn't deal with the fact that we have a debugfs file that contains =
text though. I patched it locally. It also works just fine if you simply =
disable timing stats, since then you won't have the text file.

> What does x86 KVM expose in debugfs?

The same thing it always exposed - exit stats. I am fairly sure Avi =
wanted to completely deprecate that interface in favor of the trace =
point based approach, but I don't think he ever got around to it.


Alex
