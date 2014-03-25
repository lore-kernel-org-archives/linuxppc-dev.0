Return-Path: <dave.hansen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 97753140086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 05:06:07 +1100 (EST)
Message-ID: <5331C1C9.5020309@intel.com>
Date: Tue, 25 Mar 2014 10:50:01 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20140325173605.GA21411@node.dhcp.inet.fi>
In-Reply-To: <20140325173605.GA21411@node.dhcp.inet.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
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

On 03/25/2014 10:36 AM, Kirill A. Shutemov wrote:
>> > +/*
>> > + * Fault around order is a control knob to decide the fault around pages.
>> > + * Default value is set to 0UL (disabled), but the arch can override it as
>> > + * desired.
>> > + */
>> > +#ifndef FAULT_AROUND_ORDER
>> > +#define FAULT_AROUND_ORDER	0UL
>> > +#endif
> FAULT_AROUND_ORDER == 0 case should be handled separately in
> do_read_fault(): no reason to go to do_fault_around() if we are going to
> fault in only one page.

Isn't this the kind of thing we want to do in Kconfig?
