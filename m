Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415MDc43LdzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 19:40:16 +1000 (AEST)
Date: Wed, 13 Jun 2018 11:40:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
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
 Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jun 2018, Ricardo Neri wrote:
> @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
>  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
>  		kick_timer(hdata);
>  
> +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");

Eeew.

>  /**
> + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> + * @val:	Attribute associated with the NMI. Not used.
> + * @regs:	Register values as seen when the NMI was asserted
> + *
> + * When an NMI is issued, look for hardlockups. If the timer is not periodic,
> + * kick it. The interrupt is always handled when if delivered via the
> + * Front-Side Bus.
> + *
> + * Returns:
> + *
> + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> + * otherwise.
> + */
> +static int hardlockup_detector_nmi_handler(unsigned int val,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	unsigned int use_fsb;
> +
> +	/*
> +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> +	 * edge-triggered and there is no need to check the ISR register.
> +	 */
> +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
> +
> +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
> +		return NMI_DONE;

So for 'use_fsb == True' every single NMI will fall through into the
watchdog code below.

> +	inspect_for_hardlockups(regs);
> +
> +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> +		kick_timer(hdata);

And in case that the HPET does not support periodic mode this reprogramms
the timer on every NMI which means that while perf is running the watchdog
will never ever detect anything.

Aside of that, reading TWO HPET registers for every NMI is insane. HPET
access is horribly slow, so any high frequency perf monitoring will take a
massive performance hit.

Thanks,

	tglx
