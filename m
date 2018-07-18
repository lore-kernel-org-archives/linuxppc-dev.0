Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vqdm40sWzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 18:13:00 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6I85HSZ125470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:12:58 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k9xt46xpx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:12:58 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 Jul 2018 04:12:56 -0400
Date: Wed, 18 Jul 2018 13:42:49 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
Reply-To: ego@linux.vnet.ibm.com
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
 <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
Message-Id: <20180718081249.GA17700@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mikey,

On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
> 
> >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > b/arch/powerpc/kernel/idle_book3s.S
> > index d85d551..5069d42 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
> >  	mfspr	r4, SPRN_MMCR2
> >  	std	r3, STOP_MMCR1(r13)
> >  	std	r4, STOP_MMCR2(r13)
> > +
> > +	mfspr	r3, SPRN_SPRG3
> > +	std	r3, STOP_SPRG3(r13)
> 
> We don't need to save it.  Just restore it from paca->sprg_vdso which should
> never change.

Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.

> 
> How can we do better at catching these missing SPRGs?

We can go through the list of SPRs from the POWER9 User Manual and
document explicitly why we don't have to save/restore certain SPRs
during the execution of the stop instruction. Does this sound ok ?

(Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
accessible from
https://openpowerfoundation.org/?resource_lib=power9-processor-users-manual)

> 
> We missed this one and looking at c1b25a17d249 we missed the AMOR a couple of
> months back. I'd rather we had some systematic way of finding the ones we are
> missing, rather than playing wake-a-mole.

I agree, we need something more systematic than the try-catch method
thing we have now.

For deep stop states on POWER9, we looked at the list of SPRs that
were being lost and restored during winkle on POWER8. The additional
SPRs that we took care of were the ones related to the Radix and IMC.

Now since winkle was used only in the context of CPU-Hotplug, the
CPU-online code would reinit some of the SPRs such as SPRG3, which is
why we didn't see this problem on POWER8. So, that is one obvious
place to audit.

AMOR was a bad miss. It was being restored in POWER8 as part of the
subcore restore code, so like RPR, it should have been restored along
with the other per-core SPRs.

> 
> Mikey 
> 
> >  	blr
> >  
> >  power9_restore_additional_sprs:
> > @@ -144,7 +147,9 @@ power9_restore_additional_sprs:
> >  	mtspr	SPRN_MMCR1, r4
> >  
> >  	ld	r3, STOP_MMCR2(r13)
> > +	ld	r4, STOP_SPRG3(r13)
> >  	mtspr	SPRN_MMCR2, r3
> > +	mtspr	SPRN_SPRG3, r4
> >  	blr
> >  
> >  /*
