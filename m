Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416P9g2RsRzF0tS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 12:11:18 +1000 (AEST)
Date: Thu, 14 Jun 2018 19:07:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
 Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Byungchul Park <byungchul.park@lge.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Waiman Long <longman@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Christoffer Dall <cdall@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Rientjes <rientjes@google.com>, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
Message-ID: <20180615020738.GB11625@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613090720.GV12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613090720.GV12258@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 11:07:20AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 05:57:37PM -0700, Ricardo Neri wrote:
> 
> +static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
> +{
> +       unsigned long this_isr;
> +       unsigned int lvl_trig;
> +
> +       this_isr = hpet_readl(HPET_STATUS) & BIT(hdata->num);
> +
> +       lvl_trig = hpet_readl(HPET_Tn_CFG(hdata->num)) & HPET_TN_LEVEL;
> +
> +       if (lvl_trig && this_isr)
> +               return true;
> +
> +       return false;
> +}
> 
> > +static int hardlockup_detector_nmi_handler(unsigned int val,
> > +					   struct pt_regs *regs)
> > +{
> > +	struct hpet_hld_data *hdata = hld_data;
> > +	unsigned int use_fsb;
> > +
> > +	/*
> > +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> > +	 * edge-triggered and there is no need to check the ISR register.
> > +	 */
> > +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
> 
> Please do explain.. That FSB thing basically means MSI. But there's only
> a single NMI vector. How do we know this NMI came from the HPET?

Indeed, I see now that this is wrong. There is no way to know. The only way
is to use an IO APIC interrupt and read the HPET status register.

> 
> > +
> > +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
> 
> So you add _2_ HPET reads for every single NMI that gets triggered...
> and IIRC HPET reads are _sllooooowwwwww_.


Since the trigger mode of the HPET timer is not expected to change, 
perhaps is_hpet_wdt_interrupt() can only need the interrupt status
register. This would reduce the reads to one. Furthermore, the hardlockup
detector can skip an X number of NMIs and reduce further the frequency
of reads. Does this make sense?

> 
> > +		return NMI_DONE;
> > +
> > +	inspect_for_hardlockups(regs);
> > +
> > +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > +		kick_timer(hdata);
> > +
> > +	/* Acknowledge interrupt if in level-triggered mode */
> > +	if (!use_fsb)
> > +		hpet_writel(BIT(hdata->num), HPET_STATUS);
> > +
> > +	return NMI_HANDLED;
> 
> So if I read this right, when in FSB/MSI mode, we'll basically _always_
> claim every single NMI as handled?
> 
> That's broken.

Yes, this is not correct. I will drop the functionality to use
FSB/MSI mode.

Thanks and BR,
Ricardo
