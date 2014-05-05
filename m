Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88F87140321
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:36:01 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 00:35:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 98BAE2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:35:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45EEl4R65470488
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 00:14:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45EZtuZ024975
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 00:35:55 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
In-Reply-To: <53677558.50900@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de>
Date: Mon, 05 May 2014 20:05:51 +0530
Message-ID: <87r4489ttk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05/04/2014 07:25 PM, Aneesh Kumar K.V wrote:
>> We reserve 5% of total ram for CMA allocation and not using that can
>> result in us running out of numa node memory with specific
>> configuration. One caveat is we may not have node local hpt with pinned
>> vcpu configuration. But currently libvirt also pins the vcpu to cpuset
>> after creating hash page table.
>
> I don't understand the problem. Can you please elaborate?
>
>

Lets take a system with 100GB RAM. We reserve around 5GB for htab
allocation. Now if we use rest of available memory for hugetlbfs
(because we want all the guest to be backed by huge pages), we would
end up in a situation where we have a few GB of free RAM and 5GB of CMA
reserve area. Now if we allow hash page table allocation to consume the
free space, we would end up hitting page allocation failure for other
non movable kernel allocation even though we still have 5GB CMA reserve
space free.

-aneesh
