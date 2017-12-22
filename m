Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2wqv11pMzDrZl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 15:43:23 +1100 (AEDT)
In-Reply-To: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 kamalesh@linux.vnet.ibm.com, paulus@samba.org, kan.liang@intel.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Dereference bhrb entries safely
Message-Id: <3z2wqt3rg6z9s7g@ozlabs.org>
Date: Fri, 22 Dec 2017 15:43:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-12 at 12:29:15 UTC, Ravi Bangoria wrote:
> It may very well happen that branch instructions recorded by
> bhrb entries already get unmapped before they get processed by
> the kernel. Hence, trying to dereference such memory location
> will endup in a crash. Ex,
> 
>     Unable to handle kernel paging request for data at address 0xc008000019c41764
>     Faulting instruction address: 0xc000000000084a14
>     NIP [c000000000084a14] branch_target+0x4/0x70
>     LR [c0000000000eb828] record_and_restart+0x568/0x5c0
>     Call Trace:
>     [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
>     [c0000000000ec378] perf_event_interrupt+0x298/0x460
>     [c000000000027964] performance_monitor_exception+0x54/0x70
>     [c000000000009ba4] performance_monitor_common+0x114/0x120
> 
> Fix this by deferefencing them safely.
> 
> Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f41d84dddc66b164ac16acf3f584c2

cheers
