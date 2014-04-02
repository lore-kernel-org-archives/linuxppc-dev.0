Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D24E21400F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 15:46:00 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 14:45:59 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 721932BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 15:45:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s324jbex10355196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 15:45:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s324jk3u023906
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 15:45:47 +1100
Message-ID: <533B95F6.2010303@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2014 10:15:42 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20140325173605.GA21411@node.dhcp.inet.fi> <5331C1C9.5020309@intel.com>
In-Reply-To: <5331C1C9.5020309@intel.com>
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

On Tuesday 25 March 2014 11:20 PM, Dave Hansen wrote:
> On 03/25/2014 10:36 AM, Kirill A. Shutemov wrote:
>>>> +/*
>>>> + * Fault around order is a control knob to decide the fault around pages.
>>>> + * Default value is set to 0UL (disabled), but the arch can override it as
>>>> + * desired.
>>>> + */
>>>> +#ifndef FAULT_AROUND_ORDER
>>>> +#define FAULT_AROUND_ORDER	0UL
>>>> +#endif
>> FAULT_AROUND_ORDER == 0 case should be handled separately in
>> do_read_fault(): no reason to go to do_fault_around() if we are going to
>> fault in only one page.
> 
> Isn't this the kind of thing we want to do in Kconfig?
> 
> 
I am still investigating this option since this looks better. But it is
taking time, my bad. I will get back on this.

With Regards
Maddy
