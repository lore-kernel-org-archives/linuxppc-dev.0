Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dT461zgHzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 22:40:05 +1000 (AEST)
Date: Sat, 5 May 2018 14:39:56 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, fweimer@redhat.com, Ingo Molnar
 <mingo@kernel.org>, mhocko@kernel.org, Ulrich.Weigand@de.ibm.com,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Message-ID: <20180505143956.139f4828@naga.suse.cz>
In-Reply-To: <20180504214507.GA5871@ram.oc3035372033.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
 <20180504214507.GA5871@ram.oc3035372033.ibm.com>
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

On Fri, 4 May 2018 14:45:07 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Fri, May 04, 2018 at 02:31:10PM -0700, Dave Hansen wrote:
> > On 05/04/2018 02:26 PM, Michal Such=C3=A1nek wrote: =20
> > > If it is not ok to change permissions of pkey 0 is it ok to free
> > > it? =20
> >=20
> > It's pretty much never OK to free it on x86 or ppc.  But, we're not
> > going to put code in to keep userspace from shooting itself in the
> > foot, at least on x86. =20
>=20
> and on powerpc aswell.

But once it's free it can be re-allocated. So you are moving the
special-casing from free code to code dealing with allocation.

If you want something like allocate_exec_only_pkey then the function
(either in kernel or in userspace) needs to make sure it is not
getting/requesting key 0 on powerpc.

Thanks

Michal
