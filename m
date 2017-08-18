Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYP4R0MxTzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 10:25:26 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7I0OqFg071448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:25:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cddrk6t4t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:25:24 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 17 Aug 2017 18:25:23 -0600
Date: Thu, 17 Aug 2017 17:25:12 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Haren Myneni <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC v7 26/25] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys: Add
 sysfs interface
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <20170811173443.6227-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170811173443.6227-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170818002512.GE5427@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 02:34:43PM -0300, Thiago Jung Bauermann wrote:
> Expose useful information for programs using memory protection keys.
> Provide implementation for powerpc and x86.
> 
> On a powerpc system with pkeys support, here is what is shown:
> 
> $ head /sys/kernel/mm/protection_keys/*
> ==> /sys/kernel/mm/protection_keys/disable_execute_supported <==
> true

We should not just call out disable_execute_supported.
disable_access_supported and disable_write_supported should also 
be called out.

> 
> ==> /sys/kernel/mm/protection_keys/total_keys <==
> 32
> 

> ==> /sys/kernel/mm/protection_keys/usable_keys <==
> 30

This is little nebulous.  It depends on how we define
usable as.  Is it the number of keys that are available
to the app?  If that is the case that value is dynamic.
Sometime the OS steals one key for execute-only key.
And anything that is dynamic can be inherently racy.
So I think we should define 'usable' as guaranteed number
of keys available to the app and display a value that is
one less than what is available.

in the above example the value should be 29.

RP
