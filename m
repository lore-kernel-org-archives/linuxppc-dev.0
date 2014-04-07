Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D3CC1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 15:47:25 +1000 (EST)
Message-ID: <1396849534.3671.35.camel@pasglop>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 07 Apr 2014 15:45:34 +1000
In-Reply-To: <533EDB63.8090909@intel.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, riel@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 peterz@infradead.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-04 at 09:18 -0700, Dave Hansen wrote:
> On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
> > This patch creates infrastructure to move the FAULT_AROUND_ORDER
> > to arch/ using Kconfig. This will enable architecture maintainers
> > to decide on suitable FAULT_AROUND_ORDER value based on
> > performance data for that architecture. Patch also adds
> > FAULT_AROUND_ORDER Kconfig element in arch/X86.
> 
> Please don't do it this way.
> 
> In mm/Kconfig, put
> 
> 	config FAULT_AROUND_ORDER
> 		int
> 		default 1234 if POWERPC
> 		default 4
> 
> The way you have it now, every single architecture that needs to enable
> this has to go put that in their Kconfig.  That's madness.  This way,
> you only put it in one place, and folks only have to care if they want
> to change the default to be something other than 4.

Also does it have to be a constant ? Maddy here tested on our POWER
servers. The "Sweet spot" value might be VERY different on an embedded
chip or even on a future generation of server chip.

Cheers,
Ben.
