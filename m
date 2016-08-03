Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s4Ls574lSzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 04:17:45 +1000 (AEST)
Subject: Re: [PATCH 1/2] mm: Allow disabling deferred struct page
 initialisation
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470143947-24443-2-git-send-email-srikar@linux.vnet.ibm.com>
 <57A0E1D1.8020608@intel.com> <20160803063808.GI6310@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 mahesh@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <57A23547.1070207@intel.com>
Date: Wed, 3 Aug 2016 11:17:43 -0700
MIME-Version: 1.0
In-Reply-To: <20160803063808.GI6310@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2016 11:38 PM, Srikar Dronamraju wrote:
> * Dave Hansen <dave.hansen@intel.com> [2016-08-02 11:09:21]:
>> On 08/02/2016 06:19 AM, Srikar Dronamraju wrote:
>>> Kernels compiled with CONFIG_DEFERRED_STRUCT_PAGE_INIT will initialise
>>> only certain size memory per node. The certain size takes into account
>>> the dentry and inode cache sizes. However such a kernel when booting a
>>> secondary kernel will not be able to allocate the required amount of
>>> memory to suffice for the dentry and inode caches. This results in
>>> crashes like the below on large systems such as 32 TB systems.
>>
>> What's a "secondary kernel"?
>>
> I mean the kernel thats booted to collect the crash, On fadump, the
> first kernel acts as the secondary kernel i.e the same kernel is booted
> to collect the crash.

OK, but I'm still not seeing what the problem is.  You've said that it
crashes and that it crashes during inode/dentry cache allocation.

But, *why* does the same kernel image crash in when it is used as a
"secondary kernel"?
