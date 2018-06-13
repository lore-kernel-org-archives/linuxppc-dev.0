Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Ky32gYZzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 18:42:35 +1000 (AEST)
Date: Wed, 13 Jun 2018 10:42:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>,
 Babu Moger <babu.moger@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
Message-ID: <20180613084219.GT12258@hirez.programming.kicks-ass.net>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:
> On Tue, 12 Jun 2018 17:57:32 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > Instead of exposing individual functions for the operations of the NMI
> > watchdog, define a common interface that can be used across multiple
> > implementations.
> > 
> > The struct nmi_watchdog_ops is defined for such operations. These initial
> > definitions include the enable, disable, start, stop, and cleanup
> > operations.
> > 
> > Only a single NMI watchdog can be used in the system. The operations of
> > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > variable is set to point the operations of the first NMI watchdog that
> > initializes successfully. Even though at this moment, the only available
> > NMI watchdog is the perf-based hardlockup detector. More implementations
> > can be added in the future.
> 
> Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> least have their own NMI watchdogs, it would be good to have those
> converted as well.

Yeah, agreed, this looks like half a patch.

> Is hpet a cross platform thing, or just x86? We should avoid
> proliferation of files under kernel/ I think, so with these watchdog
> driver structs then maybe implementations could go in drivers/ or
> arch/

HPET is mostly an x86 thing (altough it can be found elsewhere), but the
whole thing relies on the x86 NMI mechanism and is thus firmly arch/
material (like the sparc and ppc thing).
