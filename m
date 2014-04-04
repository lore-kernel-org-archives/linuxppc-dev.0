Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id E776B1400F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 04:49:24 +1100 (EST)
Date: Fri, 04 Apr 2014 13:50:56 -0400 (EDT)
Message-Id: <20140404.135056.2103520199689146670.davem@davemloft.net>
To: dave.hansen@intel.com
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
From: David Miller <davem@davemloft.net>
In-Reply-To: <533EDB63.8090909@intel.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, rusty@rustcorp.com.au, maddy@linux.vnet.ibm.com,
 riel@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterz@infradead.org, ak@linux.intel.com, paulus@samba.org,
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

From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 04 Apr 2014 09:18:43 -0700

> On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
>> This patch creates infrastructure to move the FAULT_AROUND_ORDER
>> to arch/ using Kconfig. This will enable architecture maintainers
>> to decide on suitable FAULT_AROUND_ORDER value based on
>> performance data for that architecture. Patch also adds
>> FAULT_AROUND_ORDER Kconfig element in arch/X86.
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

It looks more like it's necessary only to change the default, not
to enable it.  Unless I read his patch wrong...
