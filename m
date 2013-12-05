Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 146092C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 04:28:38 +1100 (EST)
Message-ID: <52A0B786.608@redhat.com>
Date: Thu, 05 Dec 2013 12:27:34 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>	
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1386126782.16703.137.camel@pasglop>
In-Reply-To: <1386126782.16703.137.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/2013 10:13 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-11-18 at 14:58 +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
>> On archs like ppc64 that don't use _PAGE_PROTNONE and also have
>> a separate page table outside linux pagetable, we just need to
>> make sure that when calling change_prot_numa we flush the
>> hardware page table entry so that next page access  result in a numa
>> fault.
>
> That patch doesn't look right...

At first glance, indeed...

> You are essentially making change_prot_numa() do whatever it does (which
> I don't completely understand) *for all architectures* now, whether they
> have CONFIG_ARCH_USES_NUMA_PROT_NONE or not ... So because you want that
> behaviour on powerpc book3s64, you change everybody.

However, it appears that since the code was #ifdefed
like that, the called code was made generic enough,
that change_prot_numa should actually work for
everything.

In other words:

Reviewed-by: Rik van Riel <riel@redhat.com>
