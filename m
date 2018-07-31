Return-Path: <alastair@d-silva.org>
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com
 [167.160.173.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 41fsQS386XzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 20:01:04 +1000 (AEST)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Michael Ellerman'" <mpe@ellerman.id.au>,
 "'Murilo Opsfelder Araujo'" <muriloo@linux.ibm.com>,
 "'LEROY Christophe'" <christophe.leroy@c-s.fr>
Cc: <linux-kernel@vger.kernel.org>,
 "'Andrew Donnellan'" <andrew.donnellan@au1.ibm.com>,
 "'Balbir Singh'" <bsingharora@gmail.com>,
 "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
 "'Cyril Bur'" <cyrilbur@gmail.com>,
 "'Eric W . Biederman'" <ebiederm@xmission.com>,
 "'Joe Perches'" <joe@perches.com>, "'Michael Neuling'" <mikey@neuling.org>,
 "'Nicholas Piggin'" <npiggin@gmail.com>,
 "'Paul Mackerras'" <paulus@samba.org>,
 "'Simon Guo'" <wei.guo.simon@gmail.com>,
 "'Sukadev Bhattiprolu'" <sukadev@linux.vnet.ibm.com>,
 "'Tobin C . Harding'" <me@tobin.cc>, <linuxppc-dev@lists.ozlabs.org>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
 <20180730152838.GA23704@kermit-br-ibm-com>
 <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
 <20180730231738.GA20351@kermit-br-ibm-com>
 <87va8vhhsj.fsf@concordia.ellerman.id.au>
In-Reply-To: <87va8vhhsj.fsf@concordia.ellerman.id.au>
Subject: RE: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
Date: Tue, 31 Jul 2018 19:52:35 +1000
Message-ID: <072401d428b4$4c0f4340$e42dc9c0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Michael Ellerman <mpe@ellerman.id.au>
> Sent: Tuesday, 31 July 2018 7:32 PM
> To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>; LEROY Christophe
> <christophe.leroy@c-s.fr>
> Cc: linux-kernel@vger.kernel.org; Alastair D'Silva =
<alastair@d-silva.org>;
> Andrew Donnellan <andrew.donnellan@au1.ibm.com>; Balbir Singh
> <bsingharora@gmail.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; Cyril Bur <cyrilbur@gmail.com>; Eric W .
> Biederman <ebiederm@xmission.com>; Joe Perches <joe@perches.com>;
> Michael Neuling <mikey@neuling.org>; Nicholas Piggin
> <npiggin@gmail.com>; Paul Mackerras <paulus@samba.org>; Simon Guo
> <wei.guo.simon@gmail.com>; Sukadev Bhattiprolu
> <sukadev@linux.vnet.ibm.com>; Tobin C . Harding <me@tobin.cc>; =
linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in
> show_signal_msg()
>=20
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> > On Mon, Jul 30, 2018 at 06:30:47PM +0200, LEROY Christophe wrote:
> >> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit :
> >> > On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
> >> > > Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit :
> >> > >
> >> > > > Simplify the message format by using REG_FMT as the register
> >> > > > format.  This avoids having two different formats and avoids
> checking for MSR_64BIT.
> >> > >
> >> > > Are you sure it is what we want ?
> >> >
> >> > Yes.
> >> >
> >> > > Won't it change the behaviour for a 32 bits app running on a =
64bits
> kernel ?
> >> >
> >> > In fact, this changes how many zeroes are prefixed when =
displaying
> >> > the registers (%016lx vs. %08lx format).  For example, 32-bits
> >> > userspace, 64-bits kernel:
> >>
> >> Indeed that's what I suspected. What is the real benefit of this =
change ?
> >> Why not keep the current format for 32bits userspace ? All those
> >> leading zeroes are pointless to me.
> >
> > One of the benefits is simplifying the code by removing some checks.
> > Another is deduplicating almost identical format strings in favor of =
a unified
> one.
> >
> > After reading Joe's comment [1], %px seems to be the format we're
> looking for.
> > An extract from Documentation/core-api/printk-formats.rst:
> >
> >   "%px is functionally equivalent to %lx (or %lu). %px is preferred =
because it
> >   is more uniquely grep'able."
> >
> > So I guess we don't need to worry about the format (%016lx vs. =
%08lx),
> > let's just use %px, as per the guideline.
>=20
> I don't think I like %px.

Me neither, semantically, it's for pointers, and the data being =
displayed is not a pointer.

> It makes the format string cleaner, but it means we have to cast =
everything
> to void * which is ugly as heck.
>=20
> I actually don't think the leading zeroes are helpful at all in the =
signal
> message, ie. we should just use %lx there.
>=20
> They are useful in show_regs() because we want everything to line up.
>=20
> So I think I'll drop patch 3 and use 0x%lx in show_signal_msg(), =
meaning we
> end up with, eg:
>=20
>   [   73.414535] segv[3759]: segfault (11) at 0x0 nip 0x10000420 lr =
0xfe61854
> code 0x1 in segv[10000000+10000]
>   [   73.414641] segv[3759]: code: 4e800421 80010014 38210010 7c0803a6
> 4bffff30 9421ffd0 93e1002c 7c3f0b78
>   [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c 39400001
> <91490000> 39200000 7d234b78 397f0030

Or better yet, "%#lx" - the hash adds the appropriate prefix in the =
right case for the format.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece
