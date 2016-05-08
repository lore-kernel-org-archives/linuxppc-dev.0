Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2t4k5CqLzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 03:37:26 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 8 May 2016 23:07:23 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5FBDA125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 May 2016 23:09:26 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u48HbJkd48890050
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 May 2016 23:07:19 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u48HbJdC001256
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 May 2016 23:07:19 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: oliver <oohall@gmail.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 0/2] Enable ZONE_DEVICE on POWER
In-Reply-To: <CAOSf1CH=gGARN+-D8uE=wAp0NUZTkp=9Xc273K_7GTEJqhuWXQ@mail.gmail.com>
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87r3dgk1bh.fsf@skywalker.in.ibm.com> <572C2801.7050605@linux.vnet.ibm.com>
 <CAOSf1CH=gGARN+-D8uE=wAp0NUZTkp=9Xc273K_7GTEJqhuWXQ@mail.gmail.com>
Date: Sun, 08 May 2016 23:07:18 +0530
Message-ID: <877ff4jvsh.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

oliver <oohall@gmail.com> writes:

> Hi,
>
> I've been working on kernel support for a persistent memory (nvdimm)
> device and the kernel driver infrastructure requires ZONE_DEVICE for
> DAX support.. I've had it enabled in my tree for some time (without
> altmap support) without any real issues.


IIUC a DAX usage of pmem doesn't really need ZONE_DEVICE. It is only
for struct page backing to those pmem area we need ZONE_DEVICE.

>
> I wasn't planning on upstreaming any of my changes until 4.8 at the
> earliest so I am ok with carrying these patches myself. However, there
> has been some interest in using ZONE_DEVICE for other things on ppc
> (wasn't that you?) and given that ZONE_DEVICE is gated behind
> CONFIG_EXPERT I can't see there being any kind of negative impact on
> end users by merging it now. At the very least it lets the rest of the
> kernel development community know that changes affecting zones should
> also be tested on powerpc.
>
>

A partially done patch like that will miss quiet a lot details. For
example if I look at the x86 changes related to altmap
(4b94ffdc4163bae1e ("x86, mm: introduce vmem_altmap to augment
vmemmap_populate")) i see them handling pagetable free and memory
hotplug. This patch doesn't do any of those. From the commit message it is
also not clear how we intent to use those zone device memory on ppc64.
If we say they will not get hotplugged out or they will never be part
of page table then those changes I mentioned above are really not
needed. But the patch is missing a lot of those details.

-aneesh
