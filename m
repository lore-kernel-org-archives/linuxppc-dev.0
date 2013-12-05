Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 186E22C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 04:53:35 +1100 (EST)
Message-ID: <52A0BD6E.4090401@redhat.com>
Date: Thu, 05 Dec 2013 12:52:46 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>	
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>	
 <1386126782.16703.137.camel@pasglop> <87a9gfri3u.fsf@linux.vnet.ibm.com>
 <1386220835.21910.21.camel@pasglop>
In-Reply-To: <1386220835.21910.21.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2013 12:20 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-12-05 at 10:48 +0530, Aneesh Kumar K.V wrote:
>>
>> Ok, I can move the changes below #ifdef CONFIG_NUMA_BALANCING ? We call
>> change_prot_numa from task_numa_work and queue_pages_range(). The later
>> may be an issue. So doing the below will help ?
>>
>> -#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
>> +#ifdef CONFIG_NUMA_BALANCING
>
> I will defer to Mel and Rik (should we also CC Andrea ?)

It looks like manual numa binding can also use lazy
page migration, but I am not sure if that can happen
without CONFIG_NUMA_BALANCING, or if mbind always uses
MPOL_MF_STRICT...
