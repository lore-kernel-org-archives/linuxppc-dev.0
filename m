Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id D966E1400E8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 03:19:33 +1100 (EST)
Message-ID: <533EDB63.8090909@intel.com>
Date: Fri, 04 Apr 2014 09:18:43 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
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

On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
> This patch creates infrastructure to move the FAULT_AROUND_ORDER
> to arch/ using Kconfig. This will enable architecture maintainers
> to decide on suitable FAULT_AROUND_ORDER value based on
> performance data for that architecture. Patch also adds
> FAULT_AROUND_ORDER Kconfig element in arch/X86.

Please don't do it this way.

In mm/Kconfig, put

	config FAULT_AROUND_ORDER
		int
		default 1234 if POWERPC
		default 4

The way you have it now, every single architecture that needs to enable
this has to go put that in their Kconfig.  That's madness.  This way,
you only put it in one place, and folks only have to care if they want
to change the default to be something other than 4.
