Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fH1t5x4tzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 06:10:58 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w46K91C4028188
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 May 2018 16:10:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hst0hnpnn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 16:10:54 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 6 May 2018 21:10:52 +0100
Date: Sun, 6 May 2018 13:10:43 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>, fweimer@redhat.com,
 Ingo Molnar <mingo@kernel.org>, mhocko@kernel.org,
 Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
 <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
 <20180504214507.GA5871@ram.oc3035372033.ibm.com>
 <20180505143956.139f4828@naga.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180505143956.139f4828@naga.suse.cz>
Message-Id: <20180506201043.GE5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 05, 2018 at 02:39:56PM +0200, Michal Suchánek wrote:
> On Fri, 4 May 2018 14:45:07 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Fri, May 04, 2018 at 02:31:10PM -0700, Dave Hansen wrote:
> > > On 05/04/2018 02:26 PM, Michal Suchánek wrote:  
> > > > If it is not ok to change permissions of pkey 0 is it ok to free
> > > > it?  
> > > 
> > > It's pretty much never OK to free it on x86 or ppc.  But, we're not
> > > going to put code in to keep userspace from shooting itself in the
> > > foot, at least on x86.  
> > 
> > and on powerpc aswell.
> 
> But once it's free it can be re-allocated. So you are moving the
> special-casing from free code to code dealing with allocation.

Actually if an application frees key-0, it has potentially opened up a
can-of-worms. It could step on anything that explodes. 

Its choice between imposing policies on an application v/s freeing it up
to choose its own policy. I think the kernel should impose some form of
mild-policy. But others think there should be none.

> 
> If you want something like allocate_exec_only_pkey then the function
> (either in kernel or in userspace) needs to make sure it is not
> getting/requesting key 0 on powerpc.

Yes. makes sense. I will put in some checks towards that.


Thanks,
RP

> 
> Thanks
> 
> Michal

-- 
Ram Pai
