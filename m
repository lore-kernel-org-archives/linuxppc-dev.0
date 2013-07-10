Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 484F82C02AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 20:23:43 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373408783.8183.208@snotra>
Date: Wed, 10 Jul 2013 12:23:36 +0200
Message-Id: <386A14D3-0968-4FC5-B273-D5D510ADDAF3@suse.de>
References: <1373408783.8183.208@snotra>
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


On 10.07.2013, at 00:26, Scott Wood wrote:

> On 07/09/2013 05:00:26 PM, Alexander Graf wrote:
>> On 09.07.2013, at 23:54, Scott Wood wrote:
>> > On 07/09/2013 04:49:32 PM, Alexander Graf wrote:
>> >> Not sure I understand. What the timing stats do is that they =
measure the time between [exit ... entry], right? We'd do the same =
thing, just all in C code. That means we would become slightly less =
accurate, but gain dynamic enabling of the traces and get rid of all the =
timing stat asm code.
>> >
>> > Compile-time enabling bothers me less than a loss of accuracy (not =
just a small loss by moving into C code, but a potential for a large =
loss if we overflow the buffer)
>> Then don't overflow the buffer. Make it large enough.
>=20
> How large is that?  Does the tool recognize and report when overflow =
happens?
>=20
> How much will the overhead of running some python script on the host, =
consuming a large volume of data, affect the results?
>=20
>> IIRC ftrace improved recently to dynamically increase the buffer size =
too.
>> Steven, do I remember correctly here?
>=20
> Yay more complexity.
>=20
> So now we get to worry about possible memory allocations happening =
when we try to log something?  Or if there is a way to do an "atomic" =
log, we're back to the "buffer might be full" situation.
>=20
>> > and a dependency on a userspace tool
>> We already have that for kvm_stat. It's a simple python script - and =
you surely have python on your rootfs, no?
>> > (both in terms of the tool needing to be written, and in the hassle =
of ensuring that it's present in the root filesystem of whatever system =
I'm testing).  And the whole mechanism will be more complicated.
>> It'll also be more flexible at the same time. You could take the logs =
and actually check what's going on to debug issues that you're =
encountering for example.
>> We could even go as far as sharing the same tool with other =
architectures, so that we only have to learn how to debug things once.
>=20
> Have you encountered an actual need for this flexibility, or is it =
theoretical?

Yeah, first thing I did back then to actually debug kvm failures was to =
add trace points.

> Is there common infrastructure for dealing with measuring intervals =
and tracking statistics thereof, rather than just tracking points and =
letting userspace connect the dots (though it could still do that as an =
option)?  Even if it must be done in userspace, it doesn't seem like =
something that should be KVM-specific.

Would you like to have different ways of measuring mm subsystem =
overhead? I don't :). The same goes for KVM really. If we could converge =
towards a single user space interface to get exit timings, it'd make =
debugging a lot easier.

We already have this for the debugfs counters btw. And the timing =
framework does break kvm_stat today already, as it emits textual stats =
rather than numbers which all of the other debugfs stats do. But at =
least I can take the x86 kvm_stat tool and run it on ppc just fine to =
see exit stats.

>=20
>> > Lots of debug options are enabled at build time; why must this be =
different?
>> Because I think it's valuable as debug tool for cases where compile =
time switches are not the best way of debugging things. It's not a high =
profile thing to tackle for me tbh, but I don't really think working =
heavily on the timing stat thing is the correct path to walk along.
>=20
> Adding new exit types isn't "working heavily" on it.

No, but the fact that the first patch is a fix to add exit stats for =
exits that we missed out before doesn't give me a lot of confidence that =
lots of people use timing stats. And I am always very weary of #ifdef'ed =
code, as it blows up the test matrix heavily.


Alex
