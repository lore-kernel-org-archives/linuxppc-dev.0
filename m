Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B162140126
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 18:20:33 +1000 (EST)
Date: Wed, 9 Apr 2014 10:20:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Message-ID: <20140409082008.GA10526@twins.programming.kicks-ass.net>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5344A312.80802@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, ak@linux.intel.com, paulus@samba.org,
 mgorman@suse.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2014 at 07:02:02AM +0530, Madhavan Srinivasan wrote:
> On Friday 04 April 2014 09:48 PM, Dave Hansen wrote:
> > On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
> >> This patch creates infrastructure to move the FAULT_AROUND_ORDER
> >> to arch/ using Kconfig. This will enable architecture maintainers
> >> to decide on suitable FAULT_AROUND_ORDER value based on
> >> performance data for that architecture. Patch also adds
> >> FAULT_AROUND_ORDER Kconfig element in arch/X86.
> > 
> > Please don't do it this way.
> > 
> > In mm/Kconfig, put
> > 
> > 	config FAULT_AROUND_ORDER
> > 		int
> > 		default 1234 if POWERPC
> > 		default 4
> > 
> > The way you have it now, every single architecture that needs to enable
> > this has to go put that in their Kconfig.  That's madness.  This way,
> 
> I though about it and decided not to do this way because, in future,
> sub platforms of the architecture may decide to change the values. Also,
> adding an if line for each architecture with different sub platforms
> oring to it will look messy.

This still misses out on Ben's objection that its impossible to get this
right at compile time for many kernels, since they can boot and run on
many different subarchs.
