Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vm7Hb2cyLzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 16:41:46 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2J5cZ8Q025557
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 01:41:39 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 298wtw97uc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 01:41:39 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 19 Mar 2017 15:41:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2J5fQYn55246884
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 16:41:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2J5exL6027092
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 16:40:59 +1100
Subject: Re: [PATCH kernel] KVM: PPC: Add MMIO emulation for stdx (store
 doubleword indexed)
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
Date: Sun, 19 Mar 2017 16:40:38 +1100
In-Reply-To: <0aa18ddc-4715-8b2c-9d7f-44566aaf5d20@ozlabs.ru>
References: <20170317083138.36527-1-aik@ozlabs.ru>
 <0aa18ddc-4715-8b2c-9d7f-44566aaf5d20@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1489902038.2504.20.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-17 at 23:11 +1100, Alexey Kardashevskiy wrote:
> On 17/03/17 19:31, Alexey Kardashevskiy wrote:
> > This adds missing stdx emulation which allow Mellanox driver from
> > recent kernels work when MMIO emulation is enforced in the
> > userspace.
> 
> 
> btw what would its load counterpart? Load Doubleword Indexed - ldx
> RT,RA,RB?

Yes.

Do we also do the more "classic" ld/std ?

Cheers,
Ben.

> 
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  arch/powerpc/include/asm/ppc-opcode.h | 1 +
> >  arch/powerpc/kvm/emulate_loadstore.c  | 6 ++++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/ppc-opcode.h
> > b/arch/powerpc/include/asm/ppc-opcode.h
> > index e7d6d86563ee..ca1bbe49590b 100644
> > --- a/arch/powerpc/include/asm/ppc-opcode.h
> > +++ b/arch/powerpc/include/asm/ppc-opcode.h
> > @@ -92,6 +92,7 @@
> >  #define OP_31_XOP_TRAP_64   68
> >  #define OP_31_XOP_DCBF      86
> >  #define OP_31_XOP_LBZX      87
> > +#define OP_31_XOP_STDX      149
> >  #define OP_31_XOP_STWX      151
> >  #define OP_31_XOP_STBX      215
> >  #define OP_31_XOP_LBZUX     119
> > diff --git a/arch/powerpc/kvm/emulate_loadstore.c
> > b/arch/powerpc/kvm/emulate_loadstore.c
> > index 6d3c0ee1d744..9fdbeb8ea86c 100644
> > --- a/arch/powerpc/kvm/emulate_loadstore.c
> > +++ b/arch/powerpc/kvm/emulate_loadstore.c
> > @@ -82,6 +82,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu
> > *vcpu)
> >  			kvmppc_set_gpr(vcpu, ra, vcpu-
> > >arch.vaddr_accessed);
> >  			break;
> >  
> > +		case OP_31_XOP_STDX:
> > +			emulated = kvmppc_handle_store(run, vcpu,
> > +						       kvmppc_get_
> > gpr(vcpu, rs),
> > +							8, 1);
> > +			break;
> > +
> >  		case OP_31_XOP_STWX:
> >  			emulated = kvmppc_handle_store(run, vcpu,
> >  						       kvmppc_get_
> > gpr(vcpu, rs),
> > 
> 
> 
