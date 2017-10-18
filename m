Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGyYW4RLNzDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:42:23 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9I3dB4l142399
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:42:21 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dnrw2ejrx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:42:20 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 17 Oct 2017 23:42:20 -0400
Date: Tue, 17 Oct 2017 20:42:13 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 04/25] powerpc: helper function to read,write
 AMR,IAMR,UAMOR registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-13-git-send-email-linuxram@us.ibm.com>
 <20171018141735.60198cf3@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018141735.60198cf3@firefly.ozlabs.ibm.com>
Message-Id: <20171018034213.GC5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 02:17:35PM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:52 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Implements helper functions to read and write the key related
> > registers; AMR, IAMR, UAMOR.
> > 
> > AMR register tracks the read,write permission of a key
> > IAMR register tracks the execute permission of a key
> > UAMOR register enables and disables a key
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable.h |   31 ++++++++++++++++++++++++++
> >  1 files changed, 31 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index b9aff51..73ed52c 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -438,6 +438,37 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> >  		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
> >  }
> >  
> > +#include <asm/reg.h>
> > +static inline u64 read_amr(void)
> > +{
> > +	return mfspr(SPRN_AMR);
> > +}
> > +static inline void write_amr(u64 value)
> > +{
> > +	mtspr(SPRN_AMR, value);
> > +}
> 
> Do we care to validate values or is that in
> the caller


No. Caller is expected to validate the values.

> 
> > +extern bool pkey_execute_disable_support;
> > +static inline u64 read_iamr(void)
> > +{
> > +	if (pkey_execute_disable_support)
> > +		return mfspr(SPRN_IAMR);
> > +	else
> > +		return 0x0UL;
> > +}
> > +static inline void write_iamr(u64 value)
> > +{
> > +	if (pkey_execute_disable_support)
> > +		mtspr(SPRN_IAMR, value);
> > +}
> > +static inline u64 read_uamor(void)
> > +{
> > +	return mfspr(SPRN_UAMOR);
> > +}
> > +static inline void write_uamor(u64 value)
> > +{
> > +	mtspr(SPRN_UAMOR, value);
> > +}
> > +
> >  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >  				       unsigned long addr, pte_t *ptep)
> 
> Looks reasonable otherwise

Thanks!
RP


> Acked-by: Balbir Singh <bsingharora@gmail.com>

-- 
Ram Pai
