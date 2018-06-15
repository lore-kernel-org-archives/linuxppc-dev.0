Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416PTM5NR0zF0tS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 12:24:55 +1000 (AEST)
Date: Thu, 14 Jun 2018 19:21:12 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180615022112.GE11625@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
 <20180613084219.GT12258@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
 <20180613215225.2a938abc@roar.ozlabs.ibm.com>
 <20180614013117.GC22652@voyager>
 <20180614123250.230667f6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614123250.230667f6@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2018 at 12:32:50PM +1000, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:31:17 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > On Wed, Jun 13, 2018 at 09:52:25PM +1000, Nicholas Piggin wrote:
> > > On Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >   
> > > > On Wed, 13 Jun 2018, Peter Zijlstra wrote:  
> > > > > On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:    
> > > > > > On Tue, 12 Jun 2018 17:57:32 -0700
> > > > > > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > > > > >     
> > > > > > > Instead of exposing individual functions for the operations of the NMI
> > > > > > > watchdog, define a common interface that can be used across multiple
> > > > > > > implementations.
> > > > > > > 
> > > > > > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > > > > > definitions include the enable, disable, start, stop, and cleanup
> > > > > > > operations.
> > > > > > > 
> > > > > > > Only a single NMI watchdog can be used in the system. The operations of
> > > > > > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > > > > > variable is set to point the operations of the first NMI watchdog that
> > > > > > > initializes successfully. Even though at this moment, the only available
> > > > > > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > > > > > can be added in the future.    
> > > > > > 
> > > > > > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > > > > > least have their own NMI watchdogs, it would be good to have those
> > > > > > converted as well.    
> > > > > 
> > > > > Yeah, agreed, this looks like half a patch.    
> > > > 
> > > > Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
> > > > low level architecture details so having yet another 'ops' data structure
> > > > with a gazillion of callbacks, checks and indirections does not provide
> > > > value over the currently available weak stubs.  
> > > 
> > > The other way to go of course is librify the perf watchdog and make an
> > > x86 watchdog that selects between perf and hpet... I also probably
> > > prefer that for code such as this, but I wouldn't strongly object to
> > > ops struct if I'm not writing the code. It's not that bad is it?  
> > 
> > My motivation to add the ops was that the hpet and perf watchdog share
> > significant portions of code.
> 
> Right, a good motivation.
> 
> > I could look into creating the library for
> > common code and relocate the hpet watchdog into arch/x86 for the hpet-
> > specific parts.
> 
> If you can investigate that approach, that would be appreciated. I hope
> I did not misunderstand you there, Thomas.
> 
> Basically you would have perf infrastructure and hpet infrastructure,
> and then the x86 watchdog driver will use one or the other of those. The
> generic watchdog driver will be just a simple shim that uses the perf
> infrastructure. Then hopefully the powerpc driver would require almost
> no change.

Sure, I will try to structure code to minimize the changes to the powerpc
watchdog... without breaking the sparc one.

Thanks and BR,
Ricardo
