Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCGt11QN9zDrWD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:43:36 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6JCfcmI104685
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 08:43:34 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bssry88me-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 08:43:34 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 08:43:33 -0400
Date: Wed, 19 Jul 2017 18:13:28 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for
 stop4 cpuidle
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1500452107.git.ego@linux.vnet.ibm.com>
 <d4dfb8e8daca3af2a2451c6f39f7352852c51f48.1500452107.git.ego@linux.vnet.ibm.com>
 <20170719190323.42a0c509@roar.ozlabs.ibm.com>
 <8760eoiqae.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760eoiqae.fsf@concordia.ellerman.id.au>
Message-Id: <20170719124328.GB30836@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas, Michael,

On Wed, Jul 19, 2017 at 10:07:05PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> >> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> >> index a7b5af3..0262283 100644
> >> --- a/arch/powerpc/kernel/asm-offsets.c
> >> +++ b/arch/powerpc/kernel/asm-offsets.c
> >> @@ -743,6 +743,18 @@ int main(void)
> >>  	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
> >>  	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
> >>  	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
> >> +
> >> +	OFFSET(PACA_PID, paca_struct, stop_spr_save_area[0]);
> >> +	OFFSET(PACA_LDBAR, paca_struct, stop_spr_save_area[1]);
> >> +	OFFSET(PACA_FSCR, paca_struct, stop_spr_save_area[2]);
> >> +	OFFSET(PACA_HFSCR, paca_struct, stop_spr_save_area[3]);
> >> +
> >> +	/* On POWER9, we are already saving MMCR0 for ESL=EC=1 */
> >> +	OFFSET(PACA_MMCRA, paca_struct, stop_spr_save_area[4]);
> >> +	OFFSET(PACA_MMCR1, paca_struct, stop_spr_save_area[5]);
> >> +	OFFSET(PACA_MMCR2, paca_struct, stop_spr_save_area[6]);
> >
> > Don't these offset names go against convention?
> >
> > Look at e.g., how PACA_EXGEN is used. I would prefer using that
> > convention. You could make the name slightly shorter too, e.g.,
> > just stop_sprs or so.
> 
> Yes please.
> 
> If I see PACA_MMCRA I'm expecting that's paca->mmcra.

Ah, ok. I will fix this. 

> 
> Also if the same values always go in the same place then please use a
> proper struct, rather than an array. ie.
>

Ok, I will add the struct instead of a array.

> struct stop_sprs
> {
> 	u64 pid;
>         u64 ldbar;
>         ...
> }
> 
> cheers
> 
--
Thanks and Regards
gautham.
