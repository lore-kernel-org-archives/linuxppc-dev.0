Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD7WF1QkFzDrHR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 08:15:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6KMDew9053224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 18:15:18 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu29hpjra-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 18:15:18 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 20 Jul 2017 16:15:16 -0600
Date: Thu, 20 Jul 2017 15:15:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 mhocko@kernel.org
Subject: Re: [RFC v6 27/62] powerpc: helper to validate key-access
 permissions of a pte
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-28-git-send-email-linuxram@us.ibm.com>
 <87mv7zpq1k.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87mv7zpq1k.fsf@skywalker.in.ibm.com>
Message-Id: <20170720221504.GJ5487@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 12:12:47PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > helper function that checks if the read/write/execute is allowed
> > on the pte.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
> >  arch/powerpc/include/asm/pkeys.h             |   12 +++++++++
> >  arch/powerpc/mm/pkeys.c                      |   33 ++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 30d7f55..0056e58 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -472,6 +472,10 @@ static inline void write_uamor(u64 value)
> >  	mtspr(SPRN_UAMOR, value);
> >  }
> >
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> >  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >  				       unsigned long addr, pte_t *ptep)
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index bbb5d85..7a9aade 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -53,6 +53,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> >  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
> >  }
> >
> > +static inline u16 pte_to_pkey_bits(u64 pteflags)
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> 
> Do we really need that above check ? We should always find it
> peky_inited to be set. 

Yes. there are cases where pkey_inited is not enabled. 
a) if the MMU is radix.
b) if the PAGE size is 4k.
c) if the device tree says the feature is not available
d) if the CPU is of a older generation. P6 and older.

RP
