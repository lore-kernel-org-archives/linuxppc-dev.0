Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHSJ05yZczDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 10:02:24 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g6so5486704pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:02:24 -0700 (PDT)
Date: Thu, 19 Oct 2017 10:02:13 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 11/25] powerpc: introduce execute-only pkey
Message-ID: <20171019100213.421a76fe@MiWiFi-R3-srv>
In-Reply-To: <20171018205739.GG5617@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-20-git-send-email-linuxram@us.ibm.com>
 <20171018151522.4123fe34@firefly.ozlabs.ibm.com>
 <20171018205739.GG5617@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Oct 2017 13:57:39 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Wed, Oct 18, 2017 at 03:15:22PM +1100, Balbir Singh wrote:
> > On Fri,  8 Sep 2017 15:44:59 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >   
> > > This patch provides the implementation of execute-only pkey.
> > > The architecture-independent layer expects the arch-dependent
> > > layer, to support the ability to create and enable a special
> > > key which has execute-only permission.
> > > 
> > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/book3s/64/mmu.h |    1 +
> > >  arch/powerpc/include/asm/pkeys.h         |    9 ++++-
> > >  arch/powerpc/mm/pkeys.c                  |   57 ++++++++++++++++++++++++++++++
> > >  3 files changed, 66 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> > > index 55950f4..ee18ba0 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> > > @@ -115,6 +115,7 @@ struct patb_entry {
> > >  	 * bit unset -> key available for allocation
> > >  	 */
> > >  	u32 pkey_allocation_map;
> > > +	s16 execute_only_pkey; /* key holding execute-only protection */
> > >  #endif
> > >  } mm_context_t;
> > >  
> > > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > > index 78c5362..0cf115f 100644
> > > --- a/arch/powerpc/include/asm/pkeys.h
> > > +++ b/arch/powerpc/include/asm/pkeys.h
> > > @@ -115,11 +115,16 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> > >   * Try to dedicate one of the protection keys to be used as an
> > >   * execute-only protection key.
> > >   */
> > > +extern int __execute_only_pkey(struct mm_struct *mm);
> > >  static inline int execute_only_pkey(struct mm_struct *mm)
> > >  {
> > > -	return 0;
> > > +	if (!pkey_inited || !pkey_execute_disable_support)
> > > +		return -1;
> > > +
> > > +	return __execute_only_pkey(mm);
> > >  }
> > >  
> > > +
> > >  static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> > >  		int prot, int pkey)
> > >  {
> > > @@ -141,6 +146,8 @@ static inline void pkey_mm_init(struct mm_struct *mm)
> > >  	if (!pkey_inited)
> > >  		return;
> > >  	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> > > +	/* -1 means unallocated or invalid */
> > > +	mm->context.execute_only_pkey = -1;
> > >  }
> > >  
> > >  extern void thread_pkey_regs_save(struct thread_struct *thread);
> > > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > > index 7cd1be4..8a24983 100644
> > > --- a/arch/powerpc/mm/pkeys.c
> > > +++ b/arch/powerpc/mm/pkeys.c
> > > @@ -188,3 +188,60 @@ void thread_pkey_regs_init(struct thread_struct *thread)
> > >  	write_iamr(0x0ul);
> > >  	write_uamor(0x0ul);
> > >  }
> > > +
> > > +static inline bool pkey_allows_readwrite(int pkey)
> > > +{
> > > +	int pkey_shift = pkeyshift(pkey);
> > > +
> > > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> > > +		return true;  
> > 
> > If uamor for key 0 is 0x10 for example or 0x01 it's a bug.
> > The above check might miss it.  
> 
> 
> The specs says both the bits corresponding to a key are set or
> reset, cannot be anything else.
>

I agree, thats why I said it's a bug if the values are such.
Do we care to validate that both bits are the same?

Balbir Singh.
