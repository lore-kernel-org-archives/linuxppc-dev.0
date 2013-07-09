Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CAB72C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 08:26:33 +1000 (EST)
Date: Tue, 9 Jul 2013 17:26:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <B31BC4F4-39E8-479D-B5AB-2D7F870E7A6C@suse.de> (from
 agraf@suse.de on Tue Jul  9 17:00:26 2013)
Message-ID: <1373408783.8183.208@snotra>
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

On 07/09/2013 05:00:26 PM, Alexander Graf wrote:
>=20
> On 09.07.2013, at 23:54, Scott Wood wrote:
>=20
> > On 07/09/2013 04:49:32 PM, Alexander Graf wrote:
> >> Not sure I understand. What the timing stats do is that they =20
> measure the time between [exit ... entry], right? We'd do the same =20
> thing, just all in C code. That means we would become slightly less =20
> accurate, but gain dynamic enabling of the traces and get rid of all =20
> the timing stat asm code.
> >
> > Compile-time enabling bothers me less than a loss of accuracy (not =20
> just a small loss by moving into C code, but a potential for a large =20
> loss if we overflow the buffer)
>=20
> Then don't overflow the buffer. Make it large enough.

How large is that?  Does the tool recognize and report when overflow =20
happens?

How much will the overhead of running some python script on the host, =20
consuming a large volume of data, affect the results?

> IIRC ftrace improved recently to dynamically increase the buffer size =20
> too.
>=20
> Steven, do I remember correctly here?

Yay more complexity.

So now we get to worry about possible memory allocations happening when =20
we try to log something?  Or if there is a way to do an "atomic" log, =20
we're back to the "buffer might be full" situation.

> > and a dependency on a userspace tool
>=20
> We already have that for kvm_stat. It's a simple python script - and =20
> you surely have python on your rootfs, no?
>=20
> > (both in terms of the tool needing to be written, and in the hassle =20
> of ensuring that it's present in the root filesystem of whatever =20
> system I'm testing).  And the whole mechanism will be more =20
> complicated.
>=20
> It'll also be more flexible at the same time. You could take the logs =20
> and actually check what's going on to debug issues that you're =20
> encountering for example.
>=20
> We could even go as far as sharing the same tool with other =20
> architectures, so that we only have to learn how to debug things once.

Have you encountered an actual need for this flexibility, or is it =20
theoretical?

Is there common infrastructure for dealing with measuring intervals and =20
tracking statistics thereof, rather than just tracking points and =20
letting userspace connect the dots (though it could still do that as an =20
option)?  Even if it must be done in userspace, it doesn't seem like =20
something that should be KVM-specific.

> > Lots of debug options are enabled at build time; why must this be =20
> different?
>=20
> Because I think it's valuable as debug tool for cases where compile =20
> time switches are not the best way of debugging things. It's not a =20
> high profile thing to tackle for me tbh, but I don't really think =20
> working heavily on the timing stat thing is the correct path to walk =20
> along.

Adding new exit types isn't "working heavily" on it.

-Scott=
