Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygWnH5ybFzDrTc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 01:48:51 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAKEimkO092893
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 09:48:49 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ec09gk5s0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 09:48:48 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Nov 2017 07:48:47 -0700
Subject: Re: [PATCH v2 0/8] powerpc: Support ibm,dynamic-memory-v2 property
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAGZKiBqX+Y==jK1XRcsS=ewr+sPATcOe0MEYduKqfX78jJxasQ@mail.gmail.com>
 <77eae60c-a406-dd8c-acb5-9e137153ce7a@linux.vnet.ibm.com>
 <CAGZKiBq-QszDXcKoQwPTq1D5dfXcXHAp0an7CRd6m8Oey0s=Sg@mail.gmail.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2017 08:48:43 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZKiBq-QszDXcKoQwPTq1D5dfXcXHAp0an7CRd6m8Oey0s=Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8b912a8d-7528-1576-f637-98f9d6747c9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2017 10:51 PM, Bharata B Rao wrote:
> 
> On Thu, Nov 16, 2017 at 9:31 PM, Nathan Fontenot <nfont@linux.vnet.ibm.com <mailto:nfont@linux.vnet.ibm.com>> wrote:
> 
> 
> 
>     On 11/15/2017 11:37 PM, Bharata B Rao wrote:
>     > On Fri, Oct 20, 2017 at 6:51 PM, Nathan Fontenot <nfont@linux.vnet.ibm.com <mailto:nfont@linux.vnet.ibm.com> <mailto:nfont@linux.vnet.ibm.com <mailto:nfont@linux.vnet.ibm.com>>> wrote:
>     >
>     >     This patch set provides a set of updates to de-couple the LMB information
>     >     provided in the ibm,dynamic-memory device tree property from the device
>     >     tree property format. A part of this patch series introduces a new
>     >     device tree property format for dynamic memory, ibm-dynamic-meory-v2.
>     >     By separating the device tree format from the information provided by
>     >     the device tree property consumers of this information need not know
>     >     what format is currently being used and provide multiple parsing routines
>     >     for the information.
>     >
>     >     The first two patches update the of_get_assoc_arrays() and
>     >     of_get_usable_memory() routines to look up the device node for the
>     >     properties they parse. This is needed because the calling routines for
>     >     these two functions will not have the device node to pass in in
>     >     subsequent patches.
>     >
>     >     The third patch adds a new kernel structure, struct drmem_lmb, that
>     >     is used to represent each of the possible LMBs specified in the
>     >     ibm,dynamic-memory* device tree properties. The patch adds code
>     >     to parse the property and build the LMB array data, and updates prom.c
>     >     to use this new data structure instead of parsing the device tree directly.
>     >
>     >     The fourth and fifth patches update the numa and pseries hotplug code
>     >     respectively to use the new LMB array data instead of parsing the
>     >     device tree directly.
>     >
>     >     The sixth patch moves the of_drconf_cell struct to drmem.h where it
>     >     fits better than prom.h
>     >
>     >     The seventh patch introduces support for the ibm,dynamic-memory-v2
>     >     property format by updating the new drmem.c code to be able to parse
>     >     and create this new device tree format.
>     >
>     >     The last patch in the series updates the architecture vector to indicate
>     >     support for ibm,dynamic-memory-v2.
>     >
>     >
>     > Here we are consolidating LMBs into LMB sets but still end up working with individual LMBs during hotplug. Can we instead start working with LMB sets together during hotplug ? In other words
> 
>     In a sense we do do this when handling memory DLPAR indexed-count requests. This takes a starting
>     drc index for a LMB and adds/removes the following <count> contiguous LMBs. This operation is
>     all-or-nothing, if any LMB fails to add/remove we revert back to the original state.
> 
> 
> I am aware of count-indexed and we do use it for memory hotplug/unplug for KVM on Power. However the RTAS and configure-connector calls there are still per-LMB.
> 
> 
>     Thi isn't exactly what you're asking for but...
>     >
>     > - The RTAS calls involved during DRC acquire stage can be done only once per LMB set.
>     > - One configure-connector call for the entire LMB set.
> 
>     these two interfaces work on a single drc index, not a set of drc indexes. Working on a set
>     of LMBs would require extending the current rtas calls or creating new ones.
> 
> 
> Yes.
>  
> 
> 
>     One thing we can look into doing for indexed-count requests is to perform each of the
>     steps for all LMBs in the set at once, i.e. make the acquire call for LMBs, then make the
>     configure-connector calls for all the LMBs...
> 
> 
> That is what I am hinting at to check the feasibility of such a mechanism. Given that all the LMBs of the set are supposed to have similar attributes (like node associativity etc), it makes sense to have a single DRC acquire call and single configure-connector call for the entire set.

I agree. I'll talk to pHyp development to see if this is something they are interested in pursuing.
If not we can submit updates to the PAPR to implement these new rtas calls even if they do not
support them in pHyp.

> 
> 
>     The only drawback is this approach would make handling failures and backing out of the
>     updates a bit messier, but I've never really thought that optimizing for the failure
>     case to be as important.
> 
> 
> Yes, error recovery can be messy given that we have multiple calls under DRC acquire call (get-sensor-state and set-indicator).
> 
> BTW I thought this reorganization involving ibm,drc-info and ibm,dynamic-memory-v2 was for representing and hotplugging huge amounts of memory efficiently and quickly. So you have not yet found the per-LMB calls to be hurting when huge amount of memory is involved ?

No. The updates for the new drc properties are for reducing the size of the properties, it does not change
the way we handle add and remove of memory.

-Nathan

> 
> Regards,
> Bharata.
> 
