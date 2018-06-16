Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416zQv32p4zDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 10:54:47 +1000 (AEST)
Date: Fri, 15 Jun 2018 17:51:03 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20180616005103.GC6659@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > On Wed, Jun 13, 2018 at 11:40:00AM +0200, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Ricardo Neri wrote:
> > > > @@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
> > > >  	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> > > >  		kick_timer(hdata);
> > > >  
> > > > +	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
> > > 
> > > Eeew.
> > 
> > If you don't mind me asking. What is the problem with this error message?
> 
> The problem is not the error message. The problem is the abuse of
> request_irq() and the fact that this irq handler function exists in the
> first place for something which is NMI based.

I wanted to add this handler in case the interrupt was not configured correctly
to be delivered as NMI (e.g., not supported by the hardware). I see your point.
Perhaps this is not needed. There is code in place to complain when an interrupt
that nobody was expecting happens.

> 
> > > And in case that the HPET does not support periodic mode this reprogramms
> > > the timer on every NMI which means that while perf is running the watchdog
> > > will never ever detect anything.
> > 
> > Yes. I see that this is wrong. With MSI interrupts, as far as I can
> > see, there is not a way to make sure that the HPET timer caused the NMI
> > perhaps the only option is to use an IO APIC interrupt and read the
> > interrupt status register.
> > 
> > > Aside of that, reading TWO HPET registers for every NMI is insane. HPET
> > > access is horribly slow, so any high frequency perf monitoring will take a
> > > massive performance hit.
> > 
> > If an IO APIC interrupt is used, only HPET register (the status register)
> > would need to be read for every NMI. Would that be more acceptable? Otherwise,
> > there is no way to determine if the HPET cause the NMI.
> 
> You need level trigger for the HPET status register to be useful at all
> because in edge mode the interrupt status bits read always 0.

Indeed.

> 
> That means you have to fiddle with the IOAPIC acknowledge magic from NMI
> context. Brilliant idea. If the NMI hits in the middle of a regular
> io_apic_read() then the interrupted code will endup with the wrong index
> register. Not to talk about the fun which the affinity rotation from NMI
> context would bring.
> 
> Do not even think about using IOAPIC and level for this.

OK. I will stay away of it and focus on MSI.
> 
> > Alternatively, there could be a counter that skips reading the HPET status
> > register (and the detection of hardlockups) for every X NMIs. This would
> > reduce the overall frequency of HPET register reads.
> 
> Great plan. So if the watchdog is the only NMI (because perf is off) then
> you delay the watchdog detection by that count.

OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
register per NMI just to check in the status register if the HPET timer
caused the NMI?

Thanks and BR,
Ricardo
