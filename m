Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 141851A00F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 14:30:44 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: bit fields && data tearing
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1410231392.2028.15.camel@jarvis.lan>
Date: Mon, 8 Sep 2014 21:30:22 -0700
Message-Id: <DD9D3F53-E3FF-4C13-B419-1200E934C530@zytor.com>
References: <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
 <1409883098.5078.14.camel@jarvis.lan> <5409243C.4080704@hurleysoftware.com>
 <20140905040645.GO5001@linux.vnet.ibm.com>
 <1410066442.12512.13.camel@jarvis.lan>
 <20140907162146.GK5001@linux.vnet.ibm.com>
 <1410116687.2027.19.camel@jarvis.lan> <540CC305.8010407@hurleysoftware.com>
 <1410155407.2027.29.camel@jarvis.lan> <540E3BFF.7080307@hurleysoftware.com>
 <1410231392.2028.15.camel@jarvis.lan>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a short member for proper alignment and one will probably pop out.

Sent from my tablet, pardon any formatting problems.

> On Sep 8, 2014, at 19:56, James Bottomley <James.Bottomley@HansenPartnersh=
ip.com> wrote:
>=20
>> On Mon, 2014-09-08 at 19:30 -0400, Peter Hurley wrote:
>> On 09/08/2014 01:50 AM, James Bottomley wrote:
>>>> Two things: I think that gcc has given up on combining adjacent writes,=

>>>> perhaps because unaligned writes on some arches are prohibitive, so
>>>> whatever minor optimization was believed to be gained was quickly lost,=

>>>> multi-fold. (Although this might not be the reason since one would
>>>> expect that gcc would know the alignment of the promoted store).
>>>=20
>>> Um, gcc assumes architecturally correct alignment; that's why it pads
>>> structures.  Only when accessing packed structures will it use the
>>> lowest unit load/store.
>>>=20
>>> if you have a struct { char a, char b }; and load first a then b with a
>>> constant gcc will obligingly optimise to a short store.
>>=20
>> Um, please re-look at the test above. The exact test you describe is
>> coded above and compiled with gcc 4.6.3 cross-compiler for parisc using
>> the kernel compiler options.
>>=20
>> In the generated code, please note the _absence_ of a combined write
>> to two adjacent byte stores.
>=20
> So one version of gcc doesn't do it.  Others do because I've been
> surprised seeing it in assembly.
>=20
>>>> But additionally, even if gcc combines adjacent writes _that are part
>>>> of the program flow_ then I believe the situation is no worse than
>>>> would otherwise exist.
>>>>=20
>>>> For instance, given the following:
>>>>=20
>>>> struct x {
>>>>    spinlock_t lock;
>>>>    long a;
>>>>    byte b;
>>>>    byte c;
>>>> };
>>>>=20
>>>> void locked_store_b(struct x *p)
>>>> {
>>>>    spin_lock(&p->lock);
>>>>    p->b =3D 1;
>>>>    spin_unlock(&p->lock);
>>>>    p->c =3D 2;
>>>> }
>>>>=20
>>>> Granted, the author probably expects ordered writes of
>>>>    STORE B
>>>>    STORE C
>>>> but that's not guaranteed because there is no memory barrier
>>>> ordering B before C.
>>>=20
>>> Yes, there is: loads and stores may not migrate into or out of critical
>>> sections.
>>=20
>> That's a common misconception.
>>=20
>> The processor is free to re-order this to:
>>=20
>>    STORE C
>>    STORE B
>>    UNLOCK
>>=20
>> That's because the unlock() only guarantees that:
>>=20
>> Stores before the unlock in program order are guaranteed to complete
>> before the unlock completes. Stores after the unlock _may_ complete
>> before the unlock completes.
>>=20
>> My point was that even if compiler barriers had the same semantics
>> as memory barriers, the situation would be no worse. That is, code
>> that is sensitive to memory barriers (like the example I gave above)
>> would merely have the same fragility with one-way compiler barriers
>> (with respect to the compiler combining writes).
>>=20
>> That's what I meant by "no worse than would otherwise exist".
>=20
> Actually, that's not correct.  This is actually deja vu with me on the
> other side of the argument.  When we first did spinlocks on PA, I argued
> as you did: lock only a barrier for code after and unlock for code
> before.  The failing case is that you can have a critical section which
> performs an atomically required operation and a following unit which
> depends on it being performed.  If you begin the following unit before
> the atomic requirement, you may end up losing.  It turns out this kind
> of pattern is inherent in a lot of mail box device drivers: you need to
> set up the mailbox atomically then poke it.  Setup is usually atomic,
> deciding which mailbox to prime and actually poking it is in the
> following unit.  Priming often involves an I/O bus transaction and if
> you poke before priming, you get a misfire.
>=20
>>>> I see no problem with gcc write-combining in the absence of
>>>> memory barriers (as long as alignment is still respected,
>>>> ie., the size-promoted write is still naturally aligned). The
>>>> combined write is still atomic.
>>>=20
>>> Actual alignment is pretty irrelevant.  That's why all architectures
>>> which require alignment also have to implement misaligned traps ... this=

>>> is a fundamental requirement of the networking code, for instance.
>>>=20
>>> The main problem is gcc thinking there's a misalignment (or a packed
>>> structure).  That causes splitting of loads and stores and that destroys=

>>> atomicity.
>>=20
>> Yeah, the extra requirement I added is basically nonsense, since the
>> only issue is what instructions the compiler is emitting. So if compiler
>> thinks the alignment is natural and combines the writes -- ok. If the
>> compiler thinks the alignment is off and doesn't combine the writes --
>> also ok.
>=20
> Yes, I think I can agree that the only real problem is gcc thinking the
> store or load needs splitting.
>=20
> James
>=20
>=20
