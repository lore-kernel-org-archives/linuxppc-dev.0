Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHPcD1F5vzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:01:15 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IKwxm7021577
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:01:14 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpayjued5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:01:13 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 17:01:12 -0400
Date: Wed, 18 Oct 2017 14:01:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 12/25] powerpc: ability to associate pkey to a vma
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-21-git-send-email-linuxram@us.ibm.com>
 <20171018152733.7f2702af@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018152733.7f2702af@firefly.ozlabs.ibm.com>
Message-Id: <20171018210104.GH5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 03:27:33PM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:00 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > arch-independent code expects the arch to  map
> > a  pkey  into the vma's protection bit setting.
> > The patch provides that ability.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/mman.h  |    8 +++++++-
> >  arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
> >  2 files changed, 25 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
> > index 30922f6..067eec2 100644
> > --- a/arch/powerpc/include/asm/mman.h
> > +++ b/arch/powerpc/include/asm/mman.h
> > @@ -13,6 +13,7 @@
> >  
> >  #include <asm/cputable.h>
> >  #include <linux/mm.h>
> > +#include <linux/pkeys.h>
> >  #include <asm/cpu_has_feature.h>
> >  
> >  /*
> > @@ -22,7 +23,12 @@
> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >  		unsigned long pkey)
> >  {
> > -	return (prot & PROT_SAO) ? VM_SAO : 0;
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	return (((prot & PROT_SAO) ? VM_SAO : 0) |
> > +			pkey_to_vmflag_bits(pkey));
> > +#else
> > +	return ((prot & PROT_SAO) ? VM_SAO : 0);
> > +#endif
> >  }
> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> >  
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 0cf115f..f13e913 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -23,6 +23,24 @@
> >  #define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> >  #endif
> >  
> > +/* override any generic PKEY Permission defines */
> > +#define PKEY_DISABLE_EXECUTE   0x4
> > +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
> > +				PKEY_DISABLE_WRITE  |\
> > +				PKEY_DISABLE_EXECUTE)
> > +
> > +static inline u64 pkey_to_vmflag_bits(u16 pkey)
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> > +
> > +	return (((pkey & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) |
> > +		((pkey & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |
> > +		((pkey & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |
> > +		((pkey & 0x8UL) ? VM_PKEY_BIT3 : 0x0UL) |
> > +		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
> > +}
> 
> Assuming that there is a linear order between VM_PKEY_BIT4 to
> VM_PKEY_BIT0, the conditional checks can be removed
> 
> (pkey & 0x1fUL) << VM_PKEY_BIT0?

yes. currently the are linear. But I am afraid it will break without
notice someday when someone decides to change the values of VM_PKEY_BITx to
be non-contiguous. I can put a BUILD_ASSERTION I suppose.  But thought
this will be safe.

RP

> 
> 
> Balbir Singh

-- 
Ram Pai
