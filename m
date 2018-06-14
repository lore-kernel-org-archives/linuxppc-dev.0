Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lhv6h52zF11V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 11:02:38 +1000 (AEST)
Date: Wed, 13 Jun 2018 17:58:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Byungchul Park <byungchul.park@lge.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Waiman Long <longman@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Rientjes <rientjes@google.com>, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET
 watchdog via a boot parameter
Message-ID: <20180614005839.GA22358@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 10:26:57PM -0700, Randy Dunlap wrote:
> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2040d4..a8833c7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2577,7 +2577,7 @@
> >  			Format: [state][,regs][,debounce][,die]
> >  
> >  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> > -			Format: [panic,][nopanic,][num]
> > +			Format: [panic,][nopanic,][num,][hpet]
> >  			Valid num: 0 or 1
> >  			0 - turn hardlockup detector in nmi_watchdog off
> >  			1 - turn hardlockup detector in nmi_watchdog on
> 
> This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
> Is that correct?

Yes, this what I meant. In my view, if you set nmi_watchdog=hpet it
implies that you want to activate the NMI watchdog. In this case, perf.

I can see how this will be ambiguous for the case of perf and arch NMI
watchdogs.

Alternative, a new parameter could be added; such as nmi_watchdog_type. I
didn't want to add it in this patchset as I think that a single parameter
can handle the enablement and type of the NMI watchdog.

What do you think?

Thanks and BR,
Ricardo
