Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xst7Y4HrJzDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:10:17 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DKA05w038821
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:10:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy5y4be7c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:10:14 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 13 Sep 2017 16:10:14 -0400
Date: Wed, 13 Sep 2017 13:10:06 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Haren Myneni/Beaverton/IBM <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/7] powerpc: introduce pte_get_hash_gslot() helper
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-3-git-send-email-linuxram@us.ibm.com>
 <CAKTCnz=SYo5NbVWuXWE8+fapW_v65rrEJDWShwofDR6x-X8Wyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnz=SYo5NbVWuXWE8+fapW_v65rrEJDWShwofDR6x-X8Wyw@mail.gmail.com>
Message-Id: <20170913201006.GA5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 13, 2017 at 07:32:57PM +1000, Balbir Singh wrote:
> On Sat, Sep 9, 2017 at 8:44 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > Introduce pte_get_hash_gslot()() which returns the slot number of the
> > HPTE in the global hash table.
> >
> > This function will come in handy as we work towards re-arranging the
> > PTE bits in the later patches.
> >
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash.h |    3 +++
> >  arch/powerpc/mm/hash_utils_64.c           |   18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > index f884520..060c059 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -166,6 +166,9 @@ static inline int hash__pte_none(pte_t pte)
> >         return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
> >  }
> >
> > +unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
> > +               int ssize, real_pte_t rpte, unsigned int subpg_index);
> > +
> >  /* This low level function performs the actual PTE insertion
> >   * Setting the PTE depends on the MMU type and other factors. It's
> >   * an horrible mess that I'm not going to try to clean up now but
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > index 67ec2e9..e68f053 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -1591,6 +1591,24 @@ static inline void tm_flush_hash_page(int local)
> >  }
> >  #endif
> >
> > +/*
> > + * return the global hash slot, corresponding to the given
> > + * pte, which contains the hpte.
> 
> Does this work with native/guest page tables? I guess both.

Yes. it is supposed to work with native as well as guest page tables.
The code has been this way for ages. This patch encapsulate
the logic in a standalone function.

> The comment sounds trivial, could you please elaborate more.
> Looking at the code, it seems like given a real pte, we use
> the hash value and hidx to figure out the slot value in the global
> slot information. This uses information in the software page
> tables. Is that correct?

Yes. This uses information passed to it by the caller, the information
is expected to be derived from linux page table.

> Do we have to consider validity and
> present state here or is that guaranteed?

This function's job is to do the math and return the global slot based
on the input. It will return the calculated value regardless of the validity of
its inputs.

Its the the callers' job to validate the pte and ensure that it is hashed,
before meaningfully using the return value of the this function.

> 
> > + */
> > +unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
> > +               int ssize, real_pte_t rpte, unsigned int subpg_index)
> > +{
> > +       unsigned long hash, slot, hidx;
> > +
> > +       hash = hpt_hash(vpn, shift, ssize);
> > +       hidx = __rpte_to_hidx(rpte, subpg_index);
> > +       if (hidx & _PTEIDX_SECONDARY)
> > +               hash = ~hash;
> > +       slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > +       slot += hidx & _PTEIDX_GROUP_IX;
> > +       return slot;
> > +}
> > +
> >  /* WARNING: This is called from hash_low_64.S, if you change this prototype,
> >   *          do not forget to update the assembly call site !
> >   */
> 
> Balbir Singh.

-- 
Ram Pai
