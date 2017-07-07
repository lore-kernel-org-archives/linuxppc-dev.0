Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x41ym5hmrzDr71
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 03:37:36 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v67HNemf055684
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 13:37:31 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bjcmjd6bv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 13:37:31 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Jul 2017 11:37:30 -0600
Date: Fri, 7 Jul 2017 23:07:10 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] powernv:idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails.
Reply-To: ego@linux.vnet.ibm.com
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-6-git-send-email-ego@linux.vnet.ibm.com>
 <20170707012916.215ed32a@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170707012916.215ed32a@roar.ozlabs.ibm.com>
Message-Id: <20170707173710.GE8913@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 07, 2017 at 01:29:16AM +1000, Nicholas Piggin wrote:
> On Wed,  5 Jul 2017 22:08:16 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Currently, we use the opal call opal_slw_set_reg() to inform the that
> > the Sleep-Winkle Engine (SLW) to restore the contents of some of the
> > Hypervisor state on wakeup from deep idle states that lose full
> > hypervisor context (characterized by the flag
> > OPAL_PM_LOSE_FULL_CONTEXT).
> > 
> > However, the current code has a bug in that if opal_slw_set_reg()
> > fails, we don't disable the use of these deep states (winkle on
> > POWER8, stop4 onwards on POWER9).
> > 
> > This patch fixes this bug by ensuring that if the the sleep winkle
> > engine is unable to restore the hypervisor states in
> > pnv_save_sprs_for_deep_states(), then we mark as invalid the states
> > which lose full context.
> > 
> > As a side-effect, since supported_cpuidle_states in
> > pnv_probe_idle_states() consists of flags of only the valid states,
> > this patch will ensure that no other subsystem in the kernel can use
> > the states which lose full context on stop-api failures.
> 
> Looks good. Is there something minimal we can do for stable here?
> 
> Aside question, do we need to restore LPCR at all with the SLW engine?
> It gets set up again when by the idle wakeup code.


> 
> And does POWER9 really need MSR and PSSCR restored by SLW? (going a bit
> off topic here, I'm just curious)

MSR is needed to be restored so that we wakeup with the right
endianness and with the IR,DR disabled.

PSSCR is set to a value so that in case of a special wakeup for a
deep-stop, the SLW can program the core to go back to the stop level
provided by the PSSCR value via the stop-api.


> 
> Thanks,
> Nick
> 

--
Thanks and Regards
gautham.
