Return-Path: <hughd@google.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJzSv3VgrzDqd5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 02:28:47 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id j1so304963365oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:28:47 -0700 (PDT)
Date: Tue, 31 May 2016 09:28:37 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
In-Reply-To: <1464647262.3078.219.camel@kernel.crashing.org>
Message-ID: <alpine.LSU.2.11.1605310902480.7816@eggly.anvils>
References: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
 <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
 <1464647262.3078.219.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-887917893-1464712124=:7816"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-887917893-1464712124=:7816
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 May 2016, Benjamin Herrenschmidt wrote:
> On Mon, 2016-05-30 at 09:39 -0700, Hugh Dickins wrote:
> > I don't mean to be churlish, and subtract from your triumph in tracking
> > this down (assuming you have), but that commit log... okay, it's intend=
ed
> > for powerpc mmu experts, not me, but if it hasn't already gone into git=
,
> > then a rewrite could be very helpful.
>=20
> Something along these lines:
>=20
> The powerpc hash table has a R (Referenced) and C (Changed) bits that
> somewhat correspond to Linux _PAGE_DIRTY and _PAGE_ACCESSED. However we
> don't currently use them.
>=20
> Moreover, we also require them to never be updated by HW. This is due
> to an optimization we have in the hash eviction code, which would be
> racy vs. a hardware update as the HW updates are done non-atomically.
>=20
> Thus it's critical that valid hash PTEs always have R set and writeable
> ones have C set. We do this by hashing a non-dirty linux PTE as read-only=
 and always setting _PAGE_ACCESSED (and thus R) when hashing anything else =
in. Any attempt by Linux at clearing those bits also removes the correspond=
ing hash entry.
>=20
> The old commit <.....> fixed an issue where we would miss setting C in
> the specific case where a Linux PTE was upgraded from read only to
> read-write (and appropriately made dirty). The hash code would realize
> the hash PTE is already present and would use a different path than the
> normal insertion path for updating a hash entry in-place. That path
> unfortunately didn't update "C".
>=20
> That commit however got a bit over zealous and also forced C on any
> entry including those that aren't writeable. That was unnecessary.
>=20
> In commit=C2=A089ff725051d1, when converting to C, we mangled that up:
>=20
> =C2=A0- We kept the useless part of <....> setting C always instead of
> only when _PAGE_DIRTY is set
>=20
> =C2=A0- We never set R thus letting the HW do the racy updates.
>=20
> This fixes it.

Thanks, that helped me to understand a lot better - and the original
commitlog then made much more sense to me after this version.

Plus I can now see that it is inherently a very confusing situation,
made the more confusing by the series of not-quite-right commits,
so all the more difficult to explain to an outsider.

I still won't pretend to understand it fully, but don't mind that:
my main concern is that if the commitlog is confused, then that
might hint that the code is still not quite right.

But all my evidence so far is that it is now right: I'll continue
testing v4.6+fix on a couple of loads until this evening: all is
well so far.  And then switch to testing v4.5+fix on those loads
for another day and a half.

Hugh
--0-887917893-1464712124=:7816--
