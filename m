Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x693x0cj1zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 15:04:28 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6B53hwa084804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 01:04:26 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bma0p5gcc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 01:04:25 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 23:04:25 -0600
Date: Tue, 11 Jul 2017 10:34:20 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
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
 <20170707173710.GE8913@in.ibm.com>
 <20170708190526.44ea9ab9@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170708190526.44ea9ab9@roar.ozlabs.ibm.com>
Message-Id: <20170711050420.GA11116@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 08, 2017 at 07:05:26PM +1000, Nicholas Piggin wrote:
> On Fri, 7 Jul 2017 23:07:10 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jul 07, 2017 at 01:29:16AM +1000, Nicholas Piggin wrote:
> > > On Wed,  5 Jul 2017 22:08:16 +0530
> > > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> > >   
> > > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > > 
> > > > Currently, we use the opal call opal_slw_set_reg() to inform the that
> > > > the Sleep-Winkle Engine (SLW) to restore the contents of some of the
> > > > Hypervisor state on wakeup from deep idle states that lose full
> > > > hypervisor context (characterized by the flag
> > > > OPAL_PM_LOSE_FULL_CONTEXT).
> > > > 
> > > > However, the current code has a bug in that if opal_slw_set_reg()
> > > > fails, we don't disable the use of these deep states (winkle on
> > > > POWER8, stop4 onwards on POWER9).
> > > > 
> > > > This patch fixes this bug by ensuring that if the the sleep winkle
> > > > engine is unable to restore the hypervisor states in
> > > > pnv_save_sprs_for_deep_states(), then we mark as invalid the states
> > > > which lose full context.
> > > > 
> > > > As a side-effect, since supported_cpuidle_states in
> > > > pnv_probe_idle_states() consists of flags of only the valid states,
> > > > this patch will ensure that no other subsystem in the kernel can use
> > > > the states which lose full context on stop-api failures.  
> > > 
> > > Looks good. Is there something minimal we can do for stable here?
> > > 
> > > Aside question, do we need to restore LPCR at all with the SLW engine?
> > > It gets set up again when by the idle wakeup code.  
> > 
> > 
> > > 
> > > And does POWER9 really need MSR and PSSCR restored by SLW? (going a bit
> > > off topic here, I'm just curious)  
> > 
> > MSR is needed to be restored so that we wakeup with the right
> > endianness and with the IR,DR disabled.
> 
> And POWER8 does not require this?
> 
> > PSSCR is set to a value so that in case of a special wakeup for a
> > deep-stop, the SLW can program the core to go back to the stop level
> > provided by the PSSCR value via the stop-api.
> 
> It always restores to deepest stop? Is there any way to restore to the
> achieved stop level? Maybe there is no usefulness for that.

That would have been ideal. But there's no way to achieve that at the
moment. The alternative is to have call the stop-api with psscr set to
the desired stop level before every stop entry. This is will consume
additional cycles which is what we are trying to avoid.

So we are currently setting the psscr value to deepest stop via stop
api as a compromise, because then on wakeup, we end up restoring more
than what would typically be required, but that's still ok since we
would be erring on the side of caution.

Programming the PSSCR to any other value might have safety
concerns. Eg: Suppose a core which was in stop11 got woken up by a
special wakeup and if the psscr programmed via stop API was stop4 then
the firmware will put the core in stop4. Now, since stop4 doesn't lose
timebase and stop11 does, in the aforementioned case TB would have
gone out of sync in the duration that the core was in stop11. Thus,
when the core wakes up in the kernel in stop4, the kernel won't resync
the TB which is a problematic.

> 
> Thanks,
> Nick
> 
