Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d9qK1S35zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 11:13:00 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4518oeP043595
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 May 2018 21:12:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hs21n13gj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 21:12:57 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 5 May 2018 02:12:56 +0100
Date: Fri, 4 May 2018 18:12:43 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma
 bit for powerpc pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
 <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
Message-Id: <20180505011243.GB5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 04, 2018 at 03:57:33PM -0700, Dave Hansen wrote:
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 0c9e392..3ddddc7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -679,6 +679,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >  		[ilog2(VM_PKEY_BIT1)]	= "",
> >  		[ilog2(VM_PKEY_BIT2)]	= "",
> >  		[ilog2(VM_PKEY_BIT3)]	= "",
> > +		[ilog2(VM_PKEY_BIT4)]	= "",
> >  #endif /* CONFIG_ARCH_HAS_PKEYS */
> ...
> > +#if defined(CONFIG_PPC)
> > +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> > +#else 
> > +# define VM_PKEY_BIT4	0
> > +#endif
> >  #endif /* CONFIG_ARCH_HAS_PKEYS */
> 
> That new line boils down to:
> 
> 		[ilog2(0)]	= "",
> 
> on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
> possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
> out of this array.
> 
> I would just be a wee bit worried that this would overwrite the 0 entry
> ("??") with "".

Yes it would :-( and could potentially break anything that depends on
0th entry being "??"

Is the following fix acceptable?

#if VM_PKEY_BIT4
                [ilog2(VM_PKEY_BIT4)]   = "",
#endif

-- 
Ram Pai
