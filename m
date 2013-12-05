Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5A1D22C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 07:25:17 +1100 (EST)
Message-ID: <52A0E12E.8050105@redhat.com>
Date: Thu, 05 Dec 2013 15:25:18 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mgorman@suse.de
Subject: Re: [PATCH -V3] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
References: <1386268702-30806-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1386268702-30806-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2013 01:38 PM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
> On archs like ppc64 that don't use _PAGE_PROTNONE and also have
> a separate page table outside linux pagetable, we just need to
> make sure that when calling change_prot_numa we flush the
> hardware page table entry so that next page access  result in a numa
> fault.
>
> We still need to make sure we use the numa faulting logic only
> when CONFIG_NUMA_BALANCING is set. This implies the migrate-on-fault
> (Lazy migration) via mbind will only work if CONFIG_NUMA_BALANCING
> is set.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@redhat.com>
