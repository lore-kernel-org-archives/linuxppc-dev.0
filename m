Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHtkD4WjWzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 02:53:08 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JFnG5p011308
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 11:53:05 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpx2mc28f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 11:53:05 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 11:53:04 -0400
Date: Thu, 19 Oct 2017 08:52:55 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 11/25] powerpc: introduce execute-only pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-20-git-send-email-linuxram@us.ibm.com>
 <20171018151522.4123fe34@firefly.ozlabs.ibm.com>
 <20171018205739.GG5617@ram.oc3035372033.ibm.com>
 <20171019100213.421a76fe@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019100213.421a76fe@MiWiFi-R3-srv>
Message-Id: <20171019155255.GR5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:02:13AM +1100, Balbir Singh wrote:
> On Wed, 18 Oct 2017 13:57:39 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Wed, Oct 18, 2017 at 03:15:22PM +1100, Balbir Singh wrote:
> > > On Fri,  8 Sep 2017 15:44:59 -0700
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >   
> > > > This patch provides the implementation of execute-only pkey.
> > > > The architecture-independent layer expects the arch-dependent
> > > > layer, to support the ability to create and enable a special
> > > > key which has execute-only permission.
> > > > 
> > > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > > ---
> > > >  arch/powerpc/include/asm/book3s/64/mmu.h |    1 +
> > > >  arch/powerpc/include/asm/pkeys.h         |    9 ++++-
> > > >  arch/powerpc/mm/pkeys.c                  |   57 ++++++++++++++++++++++++++++++
> > > >  3 files changed, 66 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> > > > index 55950f4..ee18ba0 100644
> > > > --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> > > > +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> > > > @@ -115,6 +115,7 @@ struct patb_entry {
> > > >  	 * bit unset -> key available for allocation
> > > >  	 */
> > > >  	u32 pkey_allocation_map;
> > > > +	s16 execute_only_pkey; /* key holding execute-only protection */
> > > >  #endif
> > > >  } mm_context_t;
> > > >  
> > > > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > > > index 78c5362..0cf115f 100644
> > > > --- a/arch/powerpc/include/asm/pkeys.h
> > > > +++ b/arch/powerpc/include/asm/pkeys.h
> > > > @@ -115,11 +115,16 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> > > >   * Try to dedicate one of the protection keys to be used as an
> > > >   * execute-only protection key.
> > > >   */
> > > > +extern int __execute_only_pkey(struct mm_struct *mm);
> > > >  static inline int execute_only_pkey(struct mm_struct *mm)
> > > >  {
> > > > -	return 0;
> > > > +	if (!pkey_inited || !pkey_execute_disable_support)
> > > > +		return -1;
> > > > +
> > > > +	return __execute_only_pkey(mm);
> > > >  }
> > > >  
> > > > +
> > > >  static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> > > >  		int prot, int pkey)
> > > >  {
> > > > @@ -141,6 +146,8 @@ static inline void pkey_mm_init(struct mm_struct *mm)
> > > >  	if (!pkey_inited)
> > > >  		return;
> > > >  	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> > > > +	/* -1 means unallocated or invalid */
> > > > +	mm->context.execute_only_pkey = -1;
> > > >  }
> > > >  
> > > >  extern void thread_pkey_regs_save(struct thread_struct *thread);
> > > > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > > > index 7cd1be4..8a24983 100644
> > > > --- a/arch/powerpc/mm/pkeys.c
> > > > +++ b/arch/powerpc/mm/pkeys.c
> > > > @@ -188,3 +188,60 @@ void thread_pkey_regs_init(struct thread_struct *thread)
> > > >  	write_iamr(0x0ul);
> > > >  	write_uamor(0x0ul);
> > > >  }
> > > > +
> > > > +static inline bool pkey_allows_readwrite(int pkey)
> > > > +{
> > > > +	int pkey_shift = pkeyshift(pkey);
> > > > +
> > > > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> > > > +		return true;  
> > > 
> > > If uamor for key 0 is 0x10 for example or 0x01 it's a bug.
> > > The above check might miss it.  
> > 
> > 
> > The specs says both the bits corresponding to a key are set or
> > reset, cannot be anything else.
> >
> 
> I agree, thats why I said it's a bug if the values are such.
> Do we care to validate that both bits are the same?

I will put in a assert. Will that work?

RP

> 
> Balbir Singh.

-- 
Ram Pai
