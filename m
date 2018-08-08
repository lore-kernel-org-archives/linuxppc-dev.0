Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lvb503HRzF0PT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:56:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
In-Reply-To: <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
Date: Thu, 09 Aug 2018 00:56:00 +1000
Message-ID: <87o9ecaovz.fsf@concordia.ellerman.id.au>
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

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Introduce recovery action for recovered memory errors (MCEs). There are
> soft memory errors like SLB Multihit, which can be a result of a bad
> hardware OR software BUG. Kernel can easily recover from these soft errors
> by flushing SLB contents. After the recovery kernel can still continue to
> function without any issue. But in some scenario's we may keep getting
> these soft errors until the root cause is fixed. To be able to analyze and
> find the root cause, best way is to gather enough data and system state at
> the time of MCE. Hence this patch introduces a sysctl knob where user can
> decide either to continue after recovery or panic the kernel to capture the
> dump.

I'm not convinced we want this.

As we've discovered it's often not possible to reconstruct what happened
based on a dump anyway.

The key thing you need is the content of the SLB and that's not included
in a dump.

So I think we should dump the SLB content when we get the MCE (which
this series does) and any other useful info, and then if we can recover
we should.

cheers
