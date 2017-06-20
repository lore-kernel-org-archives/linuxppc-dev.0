Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wskWm6TDszDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 09:27:00 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KNNXmC015294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:26:58 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7an75wvs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:26:58 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 17:26:57 -0600
Date: Tue, 20 Jun 2017 16:26:45 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC v2 06/12] powerpc: Program HPTE key protection bits.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-7-git-send-email-linuxram@us.ibm.com>
 <645f057e-1599-3206-d8d7-b4118a89d3a0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <645f057e-1599-3206-d8d7-b4118a89d3a0@linux.vnet.ibm.com>
Message-Id: <20170620232645.GH17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 01:51:45PM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:22 AM, Ram Pai wrote:
> > Map the PTE protection key bits to the HPTE key protection bits,
> > while creatiing HPTE  entries.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 5 +++++
> >  arch/powerpc/include/asm/pkeys.h              | 7 +++++++
> >  arch/powerpc/mm/hash_utils_64.c               | 5 +++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > index cfb8169..3d7872c 100644
> > --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > @@ -90,6 +90,8 @@
> >  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
> >  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
> >  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> > +#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
> > +#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
> >  #define HPTE_R_RPN_SHIFT	12
> >  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
> >  #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
> > @@ -104,6 +106,9 @@
> >  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
> >  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
> >  #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
> > +#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
> > +#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
> > +#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
> > 
> 
> Should we indicate/document how these 5 bits are not contiguous
> in the HPTE format for any given real page ?

I can, but its all well documented in the ISA. Infact all the bits and
the macros are one to one translation from the ISA.

> 
> >  #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
> >  #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 0f3dca8..9b6820d 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -27,6 +27,13 @@
> >  		((vm_flags & VM_PKEY_BIT3) ? H_PAGE_PKEY_BIT1 : 0x0UL) |     \
> >  		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL))
> > 
> > +#define calc_pte_to_hpte_pkey_bits(pteflags)	\
> > +	(((pteflags & H_PAGE_PKEY_BIT0) ? HPTE_R_KEY_BIT0 : 0x0UL) |	\
> > +	((pteflags & H_PAGE_PKEY_BIT1) ? HPTE_R_KEY_BIT1 : 0x0UL) |	\
> > +	((pteflags & H_PAGE_PKEY_BIT2) ? HPTE_R_KEY_BIT2 : 0x0UL) |	\
> > +	((pteflags & H_PAGE_PKEY_BIT3) ? HPTE_R_KEY_BIT3 : 0x0UL) |	\
> > +	((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL))
> > +
> 
> We can drop calc_ in here. pte_to_hpte_pkey_bits should be
> sufficient.

ok. will do.

thanks for your comments,
RP
