Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymdg41Rw0zDqv7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 09:31:11 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASMSlSU134849
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:31:08 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ehfub1yk4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:31:07 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 17:31:07 -0500
Subject: Re: [PATCH V2 0/3] powerpc/hotplug: Fix affinity assoc for LPAR
 migration
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <030d7727-9b39-f9ab-53e6-6a47605ac6b3@linux.vnet.ibm.com>
In-Reply-To: <030d7727-9b39-f9ab-53e6-6a47605ac6b3@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 16:30:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e9689260-c088-9fd7-3883-0bd8cfed744d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello:
    I would like to pull / defer further consideration of this patch set
for a while.  I will be discussing changes here with respect to the
LMB optimizations that Nathan Fontenot is working upon.
    A revision of this patch set will be sent out somewhat later.
Thanks for your attention and assistance.

Michael

On 11/16/2017 11:50 AM, Michael Bringmann wrote:
> The migration of LPARs across Power systems affects many attributes
> including that of the associativity of memory blocks and CPUs.  The
> patches in this set execute when a system is coming up fresh upon a
> migration target.  They are intended to,
> 
> * Recognize changes to the associativity of memory and CPUs recorded
>   in internal data structures when compared to the latest copies in
>   the device tree (e.g. ibm,dynamic-memory, ibm,dynamic-memory-v2,
>   cpus),
> * Recognize changes to the associativity mapping (e.g. ibm,
>   associativity-lookup-arrays), locate all assigned memory blocks
>   corresponding to each changed row, and readd all such blocks.
> * Generate calls to other code layers to reset the data structures
>   related to associativity of the CPUs and memory.
> * Re-register the 'changed' entities into the target system.
>   Re-registration of CPUs and memory blocks mostly entails acting as
>   if they have been newly hot-added into the target system.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> 
> Michael Bringmann (3):
>   hotplug/mobility: Apply assoc lookup updates for Post Migration Topo
>   postmigration/memory: Review assoc lookup array changes
>   postmigration/memory: Associativity & 'ibm,dynamic-memory-v2'
> ---
> Changes in V2:
>   -- Try to improve patch header documentation.
>   -- Remove unnecessary spacing changes from patch
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
