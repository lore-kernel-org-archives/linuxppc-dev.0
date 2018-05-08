Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gQmt6k6NzF1Sb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 03:03:41 +1000 (AEST)
Date: Tue, 8 May 2018 19:03:36 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: fweimer@redhat.com, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar
 <mingo@kernel.org>, mhocko@kernel.org, Ulrich.Weigand@de.ibm.com,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Message-ID: <20180508190336.361a508b@naga.suse.cz>
In-Reply-To: <20180508163801.GC5474@ram.oc3035372033.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
 <20180504214507.GA5871@ram.oc3035372033.ibm.com>
 <20180505143956.139f4828@naga.suse.cz>
 <20180506201043.GE5617@ram.oc3035372033.ibm.com>
 <20180507132149.3fc1dcc5@kitsune.suse.cz>
 <20180508163801.GC5474@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 8 May 2018 09:38:01 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Mon, May 07, 2018 at 01:21:49PM +0200, Michal Such=C3=A1nek wrote:
> > On Sun, 6 May 2018 13:10:43 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >  =20
> > > On Sat, May 05, 2018 at 02:39:56PM +0200, Michal Such=C3=A1nek wrote:=
 =20
> > > > On Fri, 4 May 2018 14:45:07 -0700
> > > > Ram Pai <linuxram@us.ibm.com> wrote:
...
> > Suppose an application is adapted to take advantage of freeing key
> > 0, perhaps to revoke access to any code and data used at runtime
> > initialization which is not longer needed.=20
> >=20
> > As I understand it with the proposed change any address range not
> > associated with non-default key becomes inaccessible and key 0
> > becomes available for allocation again. =20
>=20
> The above sentence is difficult to parse. I think what you are saying
> is -- Any address range associated with key-0 become inaccessible if
> key-0 is freed.  Is that a correct simplification of the above
> 	statement?
>=20
> Assuming I got it right -- =20
>=20
> 	Yes. key-0 when freed becomes available for allocation again.
> 	No. When key-0 is freed any address range
> associated with key-0 will continue to be accessible.  It was
> accessible to begin with and will continue to be accessible.  It was
> accessible, because kernel; during task-creation, never disables any
> permissions on key-0, and also never lets userspace disable any
> permissions on key-0.

Oh, right. The result of freeing a used key is not defined. When it is
not defined expecting a sane result is too much.

>=20
> The problem arises, when key-0 gets reallocated at a later time. If
> the key-0 at that point(during reallocation) is treated like any
> other key; allowing userspace to change its permissions, it can
> explode on access to any page associated with key-0. (BTW: almost
> everything is associated with key-0 by default).
>=20
> > This is fine on x86 where key 0 is fully functional.  =20
>=20
> >=20
> > However, on powerpc the application now has key 0 available and it
> > is not fully a fully functional key. So the application now needs
> > to check that the key it is allocating is not key 0. Otherwise
> > further key operations may unexpectedly fail.
> >=20
> > To prevent this I would suggest
> >=20
> > a) do not allow allocating key 0. If it is freed it becomes
> > reserved =20
>=20
> Certainly yes. We never promised any particular key to the user
> space. So not returning key-0 during allocation should break no
> semantics.
>=20
> >=20
> > b) never expose key 0 to applications. Allocate key 2 as the default
> > key and present the key numbers with an offset to userspace so key 2
> > appears as key 0 to user applications. =20
>=20
> this is complicated. offseting the number is not easy. if kernel
> has allocated key-2 and tells the user space to use key-0, userspace
> will use bit-0 and bit-1 of the AMR register to program the
> permissions on the key, and cpu will start applying those changes on
> key-0. Basically kernel, userspace and cpu will be out-of-sync. This
> is possible if the userspace uses a shift-aware library function to
> program the AMR. BTW: A library function integrated into glibc is yet
> to be defined AFAICK.

If userspace can program the hardware directly then it is not possible
to lie about the key numbers, unfortunately. An alternative is to
reserve a different key for the kernel so applications get default key
as 0 and can set permissions on it on any platform.

How is the application denied setting the permissions on key 0 if it
can program the register directly?

Thanks

Michal
