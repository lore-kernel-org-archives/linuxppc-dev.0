Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417J883L4pzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 23:28:08 +1000 (AEST)
Date: Sat, 16 Jun 2018 15:27:59 +0200 (CEST)
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
Subject: Re: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt
 among all monitored CPUs
In-Reply-To: <20180616004631.GB6659@voyager>
Message-ID: <alpine.DEB.2.21.1806161525390.1582@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de>
 <20180615021629.GD11625@voyager>
 <alpine.DEB.2.21.1806151122070.2079@nanos.tec.linutronix.de>
 <20180616004631.GB6659@voyager>
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

On Fri, 15 Jun 2018, Ricardo Neri wrote:
> On Fri, Jun 15, 2018 at 12:29:06PM +0200, Thomas Gleixner wrote:
> > You have to consider two cases:
> > 
> >  1) !remapped mode:
> > 
> >     That's reasonably simple because you just have to deal with the HPET
> >     TIMERn_PROCMSG_ROUT register. But then you need to do this directly and
> >     not through any of the existing interrupt facilities.
> 
> Indeed, there is no need to use the generic interrupt faciities to set affinity;
> I am dealing with an NMI anyways.
> > 
> >  2) remapped mode:
> > 
> >     That's way more complex as you _cannot_ ever do anything which touches
> >     the IOMMU and the related tables.
> > 
> >     So you'd need to reserve an IOMMU remapping entry for each CPU upfront,
> >     store the resulting value for the HPET TIMERn_PROCMSG_ROUT register in
> >     per cpu storage and just modify that one from NMI.
> > 
> >     Though there might be subtle side effects involved, which are related to
> >     the acknowledge part. You need to talk to the IOMMU wizards first.
> 
> I see. I will look into the code and prototype something that makes sense for
> the IOMMU maintainers.

I'd recommend to talk to them _before_ you cobble something together. If we
cannot reliably switch the affinity by directing the HPET NMI to a
different IOMMU remapping entry then the whole scheme does not work at all.

Thanks,

	tglx
