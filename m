Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gQCY1wjrzF1P7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:38:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w48GZkkr123952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 May 2018 12:38:12 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hue9dmq4p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 12:38:11 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 8 May 2018 17:38:10 +0100
Date: Tue, 8 May 2018 09:38:01 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: fweimer@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 Ulrich.Weigand@de.ibm.com, mhocko@kernel.org,
 Dave Hansen <dave.hansen@intel.com>, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
 <20180504214507.GA5871@ram.oc3035372033.ibm.com>
 <20180505143956.139f4828@naga.suse.cz>
 <20180506201043.GE5617@ram.oc3035372033.ibm.com>
 <20180507132149.3fc1dcc5@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180507132149.3fc1dcc5@kitsune.suse.cz>
Message-Id: <20180508163801.GC5474@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2018 at 01:21:49PM +0200, Michal Suchánek wrote:
> On Sun, 6 May 2018 13:10:43 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Sat, May 05, 2018 at 02:39:56PM +0200, Michal Suchánek wrote:
> > > On Fri, 4 May 2018 14:45:07 -0700
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >   
> > > > On Fri, May 04, 2018 at 02:31:10PM -0700, Dave Hansen wrote:  
> > > > > On 05/04/2018 02:26 PM, Michal Suchánek wrote:    
> > > > > > If it is not ok to change permissions of pkey 0 is it ok to
> > > > > > free it?    
> > > > > 
> > > > > It's pretty much never OK to free it on x86 or ppc.  But, we're
> > > > > not going to put code in to keep userspace from shooting itself
> > > > > in the foot, at least on x86.    
> > > > 
> > > > and on powerpc aswell.  
> > > 
> > > But once it's free it can be re-allocated. So you are moving the
> > > special-casing from free code to code dealing with allocation.  
> > 
> > Actually if an application frees key-0, it has potentially opened up a
> > can-of-worms. It could step on anything that explodes. 
> > 
> > Its choice between imposing policies on an application v/s freeing it
> > up to choose its own policy. I think the kernel should impose some
> > form of mild-policy. But others think there should be none.
> 
> It is a problem of the application when it frees a key it still needs.
> I am not for or against allowing that. The problem is with the
> interface change once the key is freed.
> 
> > 
> > > 
> > > If you want something like allocate_exec_only_pkey then the function
> > > (either in kernel or in userspace) needs to make sure it is not
> > > getting/requesting key 0 on powerpc.  
> > 
> > Yes. makes sense. I will put in some checks towards that.
> 
> Suppose an application is adapted to take advantage of freeing key
> 0, perhaps to revoke access to any code and data used at runtime
> initialization which is not longer needed. 
> 
> As I understand it with the proposed change any address range not
> associated with non-default key becomes inaccessible and key 0 becomes
> available for allocation again.

The above sentence is difficult to parse. I think what you are saying is --
	Any address range associated with key-0 become inaccessible if key-0
	is freed.  Is that a correct simplification of the above
	statement?

Assuming I got it right --  

	Yes. key-0 when freed becomes available for allocation again.
	No. When key-0 is freed any address range
associated with key-0 will continue to be accessible.  It was accessible
to begin with and will continue to be accessible.  It was accessible,
   because kernel; during task-creation, never disables any permissions on
   key-0, and also never lets userspace disable any permissions on
   key-0.

The problem arises, when key-0 gets reallocated at a later time. If the
key-0 at that point(during reallocation) is treated like any other key;
allowing userspace to change its permissions, it can explode on
access to any page associated with key-0. (BTW: almost everything is
associated with key-0 by default).

> This is fine on x86 where key 0 is fully functional. 

> 
> However, on powerpc the application now has key 0 available and it is
> not fully a fully functional key. So the application now needs to check
> that the key it is allocating is not key 0. Otherwise further key
> operations may unexpectedly fail.
> 
> To prevent this I would suggest
> 
> a) do not allow allocating key 0. If it is freed it becomes reserved

Certainly yes. We never promised any particular key to the user space. So
not returning key-0 during allocation should break no semantics.

> 
> b) never expose key 0 to applications. Allocate key 2 as the default
> key and present the key numbers with an offset to userspace so key 2
> appears as key 0 to user applications.

this is complicated. offseting the number is not easy. if kernel
has allocated key-2 and tells the user space to use key-0, userspace
will use bit-0 and bit-1 of the AMR register to program the permissions
on the key, and cpu will start applying those changes on key-0.
Basically kernel, userspace and cpu will be out-of-sync. This is
possible if the userspace uses a shift-aware library function to program
the AMR. BTW: A library function integrated into glibc is yet to be
defined AFAICK.


> 
> Thanks
> 
> Michal

-- 
Ram Pai
