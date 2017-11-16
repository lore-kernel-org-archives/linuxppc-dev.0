Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd5bj6lFWzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:02:09 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGG1d7A047430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 11:02:05 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9au8tv7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 11:02:05 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 09:02:03 -0700
Subject: Re: [PATCH v2 0/8] powerpc: Support ibm,dynamic-memory-v2 property
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAGZKiBqX+Y==jK1XRcsS=ewr+sPATcOe0MEYduKqfX78jJxasQ@mail.gmail.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 10:01:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZKiBqX+Y==jK1XRcsS=ewr+sPATcOe0MEYduKqfX78jJxasQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <77eae60c-a406-dd8c-acb5-9e137153ce7a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/15/2017 11:37 PM, Bharata B Rao wrote:
> On Fri, Oct 20, 2017 at 6:51 PM, Nathan Fontenot <nfont@linux.vnet.ibm.com <mailto:nfont@linux.vnet.ibm.com>> wrote:
> 
>     This patch set provides a set of updates to de-couple the LMB information
>     provided in the ibm,dynamic-memory device tree property from the device
>     tree property format. A part of this patch series introduces a new
>     device tree property format for dynamic memory, ibm-dynamic-meory-v2.
>     By separating the device tree format from the information provided by
>     the device tree property consumers of this information need not know
>     what format is currently being used and provide multiple parsing routines
>     for the information.
> 
>     The first two patches update the of_get_assoc_arrays() and
>     of_get_usable_memory() routines to look up the device node for the
>     properties they parse. This is needed because the calling routines for
>     these two functions will not have the device node to pass in in
>     subsequent patches.
> 
>     The third patch adds a new kernel structure, struct drmem_lmb, that
>     is used to represent each of the possible LMBs specified in the
>     ibm,dynamic-memory* device tree properties. The patch adds code
>     to parse the property and build the LMB array data, and updates prom.c
>     to use this new data structure instead of parsing the device tree directly.
> 
>     The fourth and fifth patches update the numa and pseries hotplug code
>     respectively to use the new LMB array data instead of parsing the
>     device tree directly.
> 
>     The sixth patch moves the of_drconf_cell struct to drmem.h where it
>     fits better than prom.h
> 
>     The seventh patch introduces support for the ibm,dynamic-memory-v2
>     property format by updating the new drmem.c code to be able to parse
>     and create this new device tree format.
> 
>     The last patch in the series updates the architecture vector to indicate
>     support for ibm,dynamic-memory-v2.
> 
> 
> Here we are consolidating LMBs into LMB sets but still end up working with individual LMBs during hotplug. Can we instead start working with LMB sets together during hotplug ? In other words

In a sense we do do this when handling memory DLPAR indexed-count requests. This takes a starting
drc index for a LMB and adds/removes the following <count> contiguous LMBs. This operation is
all-or-nothing, if any LMB fails to add/remove we revert back to the original state.

Thi isn't exactly what you're asking for but...
> 
> - The RTAS calls involved during DRC acquire stage can be done only once per LMB set.
> - One configure-connector call for the entire LMB set.

these two interfaces work on a single drc index, not a set of drc indexes. Working on a set
of LMBs would require extending the current rtas calls or creating new ones.

One thing we can look into doing for indexed-count requests is to perform each of the
steps for all LMBs in the set at once, i.e. make the acquire call for LMBs, then make the
configure-connector calls for all the LMBs...

The only drawback is this approach would make handling failures and backing out of the
updates a bit messier, but I've never really thought that optimizing for the failure
case to be as important.

-Nathan

> 
> I think this should help hotplugging of large amounts of memory. Other than that, if we choose to use LMB representation for PMEM, it will be useful there too to handle all the LMBs of a PMEM range as one set.
> 
> Regards,
> Bharata.
