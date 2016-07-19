Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtlkL0Ks6zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 13:23:37 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6J3NY39137605
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 23:23:36 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r7j012-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 23:23:35 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 19 Jul 2016 13:23:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 390AC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 13:23:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6J3NUui19202256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 13:23:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6J3NTFk011493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 13:23:29 +1000
Date: Tue, 19 Jul 2016 13:23:25 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, aik@ozlabs.ru,
 agraf@suse.de, kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org,
 paulus@samba.org, david@gibson.dropbear.id.au
Subject: Re: [1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
References: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
 <3rmB8G0Wkxz9s9Z@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3rmB8G0Wkxz9s9Z@ozlabs.org>
Message-Id: <20160719032325.GA14519@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2016 at 08:49:49PM +1000, Michael Ellerman wrote:
> On Wed, 2016-06-07 at 06:05:54 UTC, Sam bobroff wrote:
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 02416fe..06d79bc 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  		r = 1;
> >  		break;
> >  #endif
> > +	case KVM_CAP_PPC_HTM:
> > +		r = cpu_has_feature(CPU_FTR_TM)
> > +		    && is_kvmppc_hv_enabled(kvm);
> 
> I think it should be using CPU_FTR_TM_COMP.

Oh, why is that? I'm happy to respin the patch I'm just curious.

(I did it that way becuase that seems to be the way the other flags are used,
e.g. CPU_FTR_ALTIVEC).

If I read the code correctly, using CPU_FTR_TM_COMP will work fine: it should
cause the cpu_has_feature() test to always return false if CPU_FTR_TM_COMP is
0.

> And AFAICS you don't need to break that line.

Sure, I'll un-split it when I respin.

> cheers

Cheers,
Sam.
