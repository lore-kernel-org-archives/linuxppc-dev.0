Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzKD84mjlzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 02:48:08 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8MGi0Lj091933
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 12:48:04 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d56148v26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 12:48:04 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 22 Sep 2017 10:48:03 -0600
Date: Fri, 22 Sep 2017 09:47:52 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com, dave.hansen@intel.com
Subject: Re: [PATCH 4/6] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys: Add
 sysfs interface
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
 <1505524870-4783-5-git-send-email-linuxram@us.ibm.com>
 <20170922160019.0d6d1eae@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922160019.0d6d1eae@firefly.ozlabs.ibm.com>
Message-Id: <20170922164752.GQ5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2017 at 04:00:19PM +1000, Balbir Singh wrote:
> On Fri, 15 Sep 2017 18:21:08 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > 
> > Expose useful information for programs using memory protection keys.
> > Provide implementation for powerpc and x86.
> > 
> > On a powerpc system with pkeys support, here is what is shown:
> > 
> > $ head /sys/kernel/mm/protection_keys/*
> > ==> /sys/kernel/mm/protection_keys/disable_access_supported <==  
> > true
> > 
> > ==> /sys/kernel/mm/protection_keys/disable_execute_supported <==  
> > true
> > 
> > ==> /sys/kernel/mm/protection_keys/disable_write_supported <==  
> > true
> > 
> > ==> /sys/kernel/mm/protection_keys/total_keys <==  
> > 32
> > 
> > ==> /sys/kernel/mm/protection_keys/usable_keys <==  
> > 29
> > 
> > And on an x86 without pkeys support:
> > 
> > $ head /sys/kernel/mm/protection_keys/*
> > ==> /sys/kernel/mm/protection_keys/disable_access_supported <==  
> > false
> > 
> > ==> /sys/kernel/mm/protection_keys/disable_execute_supported <==  
> > false
> > 
> > ==> /sys/kernel/mm/protection_keys/disable_write_supported <==  
> > false
> > 
> > ==> /sys/kernel/mm/protection_keys/total_keys <==  
> > 1
> > 
> > ==> /sys/kernel/mm/protection_keys/usable_keys <==  
> > 0
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > ---
> 
> Just curious, how do you see this being used? 
> For debugging or will applications parse these properties and use them?

Its upto the application to determine the best way to fully exploit all
the keys. But that cannot happen if the application has no easy way to
determine the number of available keys.


> It's hard for an application to partition its address space
> among keys at runtime, would you agree?

Why would it be hard? Because the application may not know; in advance,
the range of its address space?  Well that is true.  But that may not be
the best strategy. It should not be based on how large its address space
range is, rather it should be based on how many unique access-domains it
will need. It can associate a key with each domain and it can associate
address-ranges to the appropriate domains. The more the number
of keys the more the number of access-domains and finer the control.

> 
> Balbir Singh.

-- 
Ram Pai
