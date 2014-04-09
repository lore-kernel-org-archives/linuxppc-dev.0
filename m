Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13B7414008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 11:45:00 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 9 Apr 2014 11:44:56 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D4C372BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 11:44:52 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s391iciI6750524
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 11:44:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s391ipBW030927
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 11:44:52 +1000
Message-ID: <5344A603.90305@linux.vnet.ibm.com>
Date: Wed, 09 Apr 2014 07:14:35 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>, dave.hansen@intel.com
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com>
 <20140404.135056.2103520199689146670.davem@davemloft.net>
In-Reply-To: <20140404.135056.2103520199689146670.davem@davemloft.net>
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

On Friday 04 April 2014 11:20 PM, David Miller wrote:
> From: Dave Hansen <dave.hansen@intel.com>
> Date: Fri, 04 Apr 2014 09:18:43 -0700
> 
>> On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
>>> This patch creates infrastructure to move the FAULT_AROUND_ORDER
>>> to arch/ using Kconfig. This will enable architecture maintainers
>>> to decide on suitable FAULT_AROUND_ORDER value based on
>>> performance data for that architecture. Patch also adds
>>> FAULT_AROUND_ORDER Kconfig element in arch/X86.
>>
>> Please don't do it this way.
>>
>> In mm/Kconfig, put
>>
>> 	config FAULT_AROUND_ORDER
>> 		int
>> 		default 1234 if POWERPC
>> 		default 4
>>
>> The way you have it now, every single architecture that needs to enable
>> this has to go put that in their Kconfig.  That's madness.  This way,
>> you only put it in one place, and folks only have to care if they want
>> to change the default to be something other than 4.
> 
> It looks more like it's necessary only to change the default, not
> to enable it.  Unless I read his patch wrong...
> 
Yes. With current patch, you only need to change the default by which
you enable it.

With regards
Maddy
> 
