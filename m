Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30C3A1A067F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:08:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 22:08:43 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE1A42BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:08:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HC8Tkf65142844
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:08:37 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HC84xk031774
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 23:08:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, criu@openvz.org
Subject: Re: [PATCH 0/3] mm/powerpc: enabling memory soft dirty tracking
In-Reply-To: <20151016141129.8b014c6d882c475fafe577a9@linux-foundation.org>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
 <20151016141129.8b014c6d882c475fafe577a9@linux-foundation.org>
Date: Sat, 17 Oct 2015 17:37:44 +0530
Message-ID: <87io65itpr.fsf@linux.vnet.ibm.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 16 Oct 2015 14:07:05 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>
>> This series is enabling the software memory dirty tracking in the
>> kernel for powerpc.  This is the follow up of the commit 0f8975ec4db2
>> ("mm: soft-dirty bits for user memory changes tracking") which
>> introduced this feature in the mm code.
>> 
>> The first patch is fixing an issue in the code clearing the soft dirty
>> bit.  The PTE were not cleared before being modified, leading to hang
>> on ppc64.
>> 
>> The second patch is fixing a build issue when the transparent huge
>> page is not enabled.
>> 
>> The third patch is introducing the soft dirty tracking in the powerpc
>> architecture code. 
>
> I grabbed these patches, but they're more a ppc thing than a core
> kernel thing.  I can merge them into 4.3 with suitable acks or drop
> them if they turn up in the powerpc tree.  Or something else?

patch 1 and patch 2 are fixes for generic code. That can go via -mm
tree. The ppc64 bits should go via linux-powerpc tree. We have changes
in this area pending to be merged upstream and patch 3 will result
in conflicts.


-aneesh
