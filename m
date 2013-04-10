Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93ECE2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:53:15 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 18:48:24 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E8B6A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:52:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A8dHUk12059020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:39:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A8qYud012984
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:52:35 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH -V5 06/25] powerpc: Reduce PTE table memory wastage
In-Reply-To: <87obdmom5o.fsf@linux.vnet.ibm.com>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410071453.GB24786@concordia> <87obdmom5o.fsf@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 14:22:31 +0530
Message-ID: <87ip3uojhs.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michael Ellerman <michael@ellerman.id.au> writes:
>
>> On Thu, Apr 04, 2013 at 11:27:44AM +0530, Aneesh Kumar K.V wrote:
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>> 
>>> We allocate one page for the last level of linux page table. With THP and
>>> large page size of 16MB, that would mean we are wasting large part
>>> of that page. To map 16MB area, we only need a PTE space of 2K with 64K
>>> page size. This patch reduce the space wastage by sharing the page
>>> allocated for the last level of linux page table with multiple pmd
>>> entries. We call these smaller chunks PTE page fragments and allocated
>>> page, PTE page.
>>
>> This is not compiling for me:
>>
>> arch/powerpc/mm/mmu_context_hash64.c:118:3: error: implicit declaration of function 'reset_page_mapcount'
>>
>
> can you share the .config ? I have the git tree at 
>
> git://github.com/kvaneesh/linux.git ppc64-thp-7

22b751c3d0376e86a377e3a0aa2ddbbe9d2eefc1 . Will rebase to latest linus tree.

-aneesh
