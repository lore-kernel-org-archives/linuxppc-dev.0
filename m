Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz2s2615nzDsM5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 16:00:38 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id m30so95306pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 23:00:38 -0700 (PDT)
Date: Fri, 22 Sep 2017 16:00:19 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 4/6] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys: Add
 sysfs interface
Message-ID: <20170922160019.0d6d1eae@firefly.ozlabs.ibm.com>
In-Reply-To: <1505524870-4783-5-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
 <1505524870-4783-5-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Sep 2017 18:21:08 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> Expose useful information for programs using memory protection keys.
> Provide implementation for powerpc and x86.
> 
> On a powerpc system with pkeys support, here is what is shown:
> 
> $ head /sys/kernel/mm/protection_keys/*
> ==> /sys/kernel/mm/protection_keys/disable_access_supported <==  
> true
> 
> ==> /sys/kernel/mm/protection_keys/disable_execute_supported <==  
> true
> 
> ==> /sys/kernel/mm/protection_keys/disable_write_supported <==  
> true
> 
> ==> /sys/kernel/mm/protection_keys/total_keys <==  
> 32
> 
> ==> /sys/kernel/mm/protection_keys/usable_keys <==  
> 29
> 
> And on an x86 without pkeys support:
> 
> $ head /sys/kernel/mm/protection_keys/*
> ==> /sys/kernel/mm/protection_keys/disable_access_supported <==  
> false
> 
> ==> /sys/kernel/mm/protection_keys/disable_execute_supported <==  
> false
> 
> ==> /sys/kernel/mm/protection_keys/disable_write_supported <==  
> false
> 
> ==> /sys/kernel/mm/protection_keys/total_keys <==  
> 1
> 
> ==> /sys/kernel/mm/protection_keys/usable_keys <==  
> 0
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---

Just curious, how do you see this being used? For debugging
or will applications parse these properties and use them?
It's hard for an application to partition its address space
among keys at runtime, would you agree?

Balbir Singh.
