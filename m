Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fgF36cg7zF1Rp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 21:21:57 +1000 (AEST)
Date: Mon, 7 May 2018 13:21:49 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: fweimer@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 Ulrich.Weigand@de.ibm.com, mhocko@kernel.org, Dave Hansen
 <dave.hansen@intel.com>, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Message-ID: <20180507132149.3fc1dcc5@kitsune.suse.cz>
In-Reply-To: <20180506201043.GE5617@ram.oc3035372033.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
 <20180504214507.GA5871@ram.oc3035372033.ibm.com>
 <20180505143956.139f4828@naga.suse.cz>
 <20180506201043.GE5617@ram.oc3035372033.ibm.com>
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

On Sun, 6 May 2018 13:10:43 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Sat, May 05, 2018 at 02:39:56PM +0200, Michal Such=C3=A1nek wrote:
> > On Fri, 4 May 2018 14:45:07 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >  =20
> > > On Fri, May 04, 2018 at 02:31:10PM -0700, Dave Hansen wrote: =20
> > > > On 05/04/2018 02:26 PM, Michal Such=C3=A1nek wrote:   =20
> > > > > If it is not ok to change permissions of pkey 0 is it ok to
> > > > > free it?   =20
> > > >=20
> > > > It's pretty much never OK to free it on x86 or ppc.  But, we're
> > > > not going to put code in to keep userspace from shooting itself
> > > > in the foot, at least on x86.   =20
> > >=20
> > > and on powerpc aswell. =20
> >=20
> > But once it's free it can be re-allocated. So you are moving the
> > special-casing from free code to code dealing with allocation. =20
>=20
> Actually if an application frees key-0, it has potentially opened up a
> can-of-worms. It could step on anything that explodes.=20
>=20
> Its choice between imposing policies on an application v/s freeing it
> up to choose its own policy. I think the kernel should impose some
> form of mild-policy. But others think there should be none.

It is a problem of the application when it frees a key it still needs.
I am not for or against allowing that. The problem is with the
interface change once the key is freed.

>=20
> >=20
> > If you want something like allocate_exec_only_pkey then the function
> > (either in kernel or in userspace) needs to make sure it is not
> > getting/requesting key 0 on powerpc. =20
>=20
> Yes. makes sense. I will put in some checks towards that.

Suppose an application is adapted to take advantage of freeing key
0, perhaps to revoke access to any code and data used at runtime
initialization which is not longer needed.=20

As I understand it with the proposed change any address range not
associated with non-default key becomes inaccessible and key 0 becomes
available for allocation again. This is fine on x86 where key 0 is
fully functional.=20

However, on powerpc the application now has key 0 available and it is
not fully a fully functional key. So the application now needs to check
that the key it is allocating is not key 0. Otherwise further key
operations may unexpectedly fail.

To prevent this I would suggest

a) do not allow allocating key 0. If it is freed it becomes reserved

b) never expose key 0 to applications. Allocate key 2 as the default
key and present the key numbers with an offset to userspace so key 2
appears as key 0 to user applications.

Thanks

Michal
