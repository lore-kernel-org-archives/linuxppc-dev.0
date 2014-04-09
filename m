Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 49B55140152
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 01:50:10 +1000 (EST)
Message-ID: <53456B61.1040901@intel.com>
Date: Wed, 09 Apr 2014 08:46:41 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com>
In-Reply-To: <5344A312.80802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 rusty@rustcorp.com.au, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2014 06:32 PM, Madhavan Srinivasan wrote:
>> > In mm/Kconfig, put
>> > 
>> > 	config FAULT_AROUND_ORDER
>> > 		int
>> > 		default 1234 if POWERPC
>> > 		default 4
>> > 
>> > The way you have it now, every single architecture that needs to enable
>> > this has to go put that in their Kconfig.  That's madness.  This way,
> I though about it and decided not to do this way because, in future,
> sub platforms of the architecture may decide to change the values. Also,
> adding an if line for each architecture with different sub platforms
> oring to it will look messy.

I'm not sure why I'm trying here any more.  You do seem quite content to
add as much cruft to ppc and every other architecture as possible.  If
your theoretical scenario pops up, you simply do this in ppc:

config ARCH_FAULT_AROUND_ORDER
	int
	default 999
	default 888 if OTHER_SILLY_POWERPC_SUBARCH

But *ONLY* in the architectures that care about doing that stuff.  You
leave every other architecture on the planet alone.  Then, in mm/Kconfig:

config FAULT_AROUND_ORDER
	int
	default ARCH_FAULT_AROUND_ORDER if ARCH_FAULT_AROUND_ORDER
	default 4

Your way still requires going and individually touching every single
architecture's Kconfig that wants to enable fault around.  That's not an
acceptable solution.
