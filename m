Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415ll71sGnzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 11:04:34 +1000 (AEST)
Date: Wed, 13 Jun 2018 18:00:54 -0700
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
Subject: Re: [RFC PATCH 16/23] watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20180614010054.GB22358@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-17-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1e5bc136-4123-328a-2d2e-e6f2faef5bf4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e5bc136-4123-328a-2d2e-e6f2faef5bf4@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 10:23:47PM -0700, Randy Dunlap wrote:
> Hi,

Hi Randy,

> 
> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c40c7b7..6e79833 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -828,6 +828,16 @@ config HARDLOCKUP_DETECTOR_PERF
> >  	bool
> >  	select SOFTLOCKUP_DETECTOR
> >  
> > +config HARDLOCKUP_DETECTOR_HPET
> > +	bool "Use HPET Timer for Hard Lockup Detection"
> > +	select SOFTLOCKUP_DETECTOR
> > +	select HARDLOCKUP_DETECTOR
> > +	depends on HPET_TIMER && HPET
> > +	help
> > +	  Say y to enable a hardlockup detector that is driven by an High-Precision
> > +	  Event Timer. In addition to selecting this option, the command-line
> > +	  parameter nmi_watchdog option. See Documentation/admin-guide/kernel-parameters.rst
> 
> The "In addition ..." thing is a broken (incomplete) sentence.

Oops. I apologize. I missed this I will fix it in my next version.

Thanks and BR,
Ricardo
