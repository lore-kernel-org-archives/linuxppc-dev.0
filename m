Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F19D114007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 18:25:20 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 15 May 2014 13:55:17 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8F4AEE0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 13:55:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4F8PNB655902306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 13:55:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4F8PC27001766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 13:55:14 +0530
Message-ID: <537479E7.90806@linux.vnet.ibm.com>
Date: Thu, 15 May 2014 13:55:11 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 rusty@rustcorp.com.au, dave.hansen@intel.com, paulus@samba.org,
 mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ingo,

	Do you have any comments for the latest version of the patchset. If
not, kindly can you pick it up as is.


With regards
Maddy

> Kirill A. Shutemov with 8c6e50b029 commit introduced
> vm_ops->map_pages() for mapping easy accessible pages around
> fault address in hope to reduce number of minor page faults.
> 
> This patch creates infrastructure to modify the FAULT_AROUND_ORDER
> value using mm/Kconfig. This will enable architecture maintainers
> to decide on suitable FAULT_AROUND_ORDER value based on
> performance data for that architecture. First patch also defaults
> FAULT_AROUND_ORDER Kconfig element to 4. Second patch list
> out the performance numbers for powerpc (platform pseries) and
> initialize the fault around order variable for pseries platform of
> powerpc.
> 
> V4 Changes:
>   Replaced the BUILD_BUG_ON with VM_BUG_ON.
>   Moved fault_around_pages() and fault_around_mask() functions outside of
>    #ifdef CONFIG_DEBUG_FS.
> 
> V3 Changes:
>   Replaced FAULT_AROUND_ORDER macro to a variable to support arch's that
>    supports sub platforms.
>   Made changes in commit messages.
> 
> V2 Changes:
>   Created Kconfig parameter for FAULT_AROUND_ORDER
>   Added check in do_read_fault to handle FAULT_AROUND_ORDER value of 0
>   Made changes in commit messages.
> 
> Madhavan Srinivasan (2):
>   mm: move FAULT_AROUND_ORDER to arch/
>   powerpc/pseries: init fault_around_order for pseries
> 
>  arch/powerpc/platforms/pseries/pseries.h |    2 ++
>  arch/powerpc/platforms/pseries/setup.c   |    5 +++++
>  mm/Kconfig                               |    8 ++++++++
>  mm/memory.c                              |   25 ++++++-------------------
>  4 files changed, 21 insertions(+), 19 deletions(-)
> 
