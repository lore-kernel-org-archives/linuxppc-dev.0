Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5672014008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 11:32:17 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 9 Apr 2014 11:32:16 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CA6E12BB0076
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 11:32:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s391Vx2l393640
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 11:31:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s391WCoT004195
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Apr 2014 11:32:13 +1000
Message-ID: <5344A312.80802@linux.vnet.ibm.com>
Date: Wed, 09 Apr 2014 07:02:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com>
In-Reply-To: <533EDB63.8090909@intel.com>
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

On Friday 04 April 2014 09:48 PM, Dave Hansen wrote:
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

I though about it and decided not to do this way because, in future,
sub platforms of the architecture may decide to change the values. Also,
adding an if line for each architecture with different sub platforms
oring to it will look messy.

With regards
Maddy

> you only put it in one place, and folks only have to care if they want
> to change the default to be something other than 4.
> 
