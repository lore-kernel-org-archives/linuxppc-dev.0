Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFfMp15qJzDr5c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 07:28:05 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ILNbxI126944
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 17:28:03 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wg7fk0hx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 17:28:03 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 19 Aug 2016 07:27:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B29E93578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 07:27:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ILRvsM31981608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 07:27:57 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ILRvYX031931
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 07:27:57 +1000
Subject: Re: [PATCH v2] powerpc: move hmi.c to arch/powerpc/kvm/
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Daniel
 Axtens <dja@axtens.net>
Date: Fri, 19 Aug 2016 07:27:53 +1000
In-Reply-To: <56286cab-c96a-55d2-1a50-38aa178edf26@redhat.com>
References: <1470920863-15375-1-git-send-email-pbonzini@redhat.com>
 <56286cab-c96a-55d2-1a50-38aa178edf26@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1471555673.19495.44.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-08-18 at 10:53 +0200, Paolo Bonzini wrote:
> 
> On 11/08/2016 15:07, Paolo Bonzini wrote:
> > 
> > hmi.c functions are unused unless sibling_subcore_state is nonzero,
> > and
> > that in turn happens only if KVM is in use.  So move the code to
> > arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is
> > also
> > included in struct paca_struct only if KVM is supported by the
> > kernel.
> 

Mahesh, can you review this ?

> > Cc: Daniel Axtens <dja@axtens.net>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: kvm-ppc@vger.kernel.org
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > 	v1->v2: use CONFIG_KVM_BOOK3S_HV_POSSIBLE, not
> > 		CONFIG_KVM_BOOK3S_64_HANDLER.  The former implies
> > 		the latter, but the reverse is not true.
> > 
> >  arch/powerpc/include/asm/hmi.h                     |  2 +-
> >  arch/powerpc/include/asm/paca.h                    | 12 +++++++---
> > --
> >  arch/powerpc/kernel/Makefile                       |  2 +-
> >  arch/powerpc/kvm/Makefile                          |  1 +
> >  arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} |  0
> >  5 files changed, 10 insertions(+), 7 deletions(-)
> >  rename arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} (100%)
> > 
> > diff --git a/arch/powerpc/include/asm/hmi.h
> > b/arch/powerpc/include/asm/hmi.h
> > index 88b4901ac4ee..85b7a1a21e22 100644
> > --- a/arch/powerpc/include/asm/hmi.h
> > +++ b/arch/powerpc/include/asm/hmi.h
> > @@ -21,7 +21,7 @@
> >  #ifndef __ASM_PPC64_HMI_H__
> >  #define __ASM_PPC64_HMI_H__
> >  
> > -#ifdef CONFIG_PPC_BOOK3S_64
> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >  
> >  #define	CORE_TB_RESYNC_REQ_BIT		63
> >  #define MAX_SUBCORE_PER_CORE		4
> > diff --git a/arch/powerpc/include/asm/paca.h
> > b/arch/powerpc/include/asm/paca.h
> > index 148303e7771f..6a6792bb39fb 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -183,11 +183,6 @@ struct paca_struct {
> >  	 */
> >  	u16 in_mce;
> >  	u8 hmi_event_available;		 /* HMI event is
> > available */
> > -	/*
> > -	 * Bitmap for sibling subcore status. See
> > kvm/book3s_hv_ras.c for
> > -	 * more details
> > -	 */
> > -	struct sibling_subcore_state *sibling_subcore_state;
> >  #endif
> >  
> >  	/* Stuff for accurate time accounting */
> > @@ -202,6 +197,13 @@ struct paca_struct {
> >  	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
> >  #endif
> >  	struct kvmppc_host_state kvm_hstate;
> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +	/*
> > +	 * Bitmap for sibling subcore status. See
> > kvm/book3s_hv_ras.c for
> > +	 * more details
> > +	 */
> > +	struct sibling_subcore_state *sibling_subcore_state;
> > +#endif
> >  #endif
> >  };
> >  
> > diff --git a/arch/powerpc/kernel/Makefile
> > b/arch/powerpc/kernel/Makefile
> > index b2027a5cf508..fe4c075bcf50 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -41,7 +41,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> >  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o
> > cpu_setup_pa6t.o
> >  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
> > -obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o hmi.o
> > +obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
> >  obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
> > idle_book3e.o
> >  obj-$(CONFIG_PPC64)		+= vdso64/
> >  obj-$(CONFIG_ALTIVEC)		+= vecemu.o
> > diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> > index 1f9e5529e692..855d4b95d752 100644
> > --- a/arch/powerpc/kvm/Makefile
> > +++ b/arch/powerpc/kvm/Makefile
> > @@ -78,6 +78,7 @@ kvm-book3s_64-builtin-xics-objs-
> > $(CONFIG_KVM_XICS) := \
> >  
> >  ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >  kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
> > +	book3s_hv_hmi.o \
> >  	book3s_hv_rmhandlers.o \
> >  	book3s_hv_rm_mmu.o \
> >  	book3s_hv_ras.o \
> > diff --git a/arch/powerpc/kernel/hmi.c
> > b/arch/powerpc/kvm/book3s_hv_hmi.c
> > similarity index 100%
> > rename from arch/powerpc/kernel/hmi.c
> > rename to arch/powerpc/kvm/book3s_hv_hmi.c
> > 
> 
> Ping?
> 
> Paolo
