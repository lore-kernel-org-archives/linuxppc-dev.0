Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zb8lH5ykYzF0vW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 14:17:15 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w163GaFx010488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Feb 2018 22:17:13 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fy01c7x29-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 22:17:13 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 Feb 2018 03:17:10 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 Florian Weimer <fweimer@redhat.com>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Kernel 4.15 lost set_robust_list support on POWER 9
In-Reply-To: <20180206110616.5d1d5881@roar.ozlabs.ibm.com>
References: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
 <d5f533cf-bd97-794a-38e8-6b6d8c005023@linux.vnet.ibm.com>
 <1517867731.2312.146.camel@au1.ibm.com>
 <20180206110616.5d1d5881@roar.ozlabs.ibm.com>
Date: Tue, 06 Feb 2018 08:47:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tc6x0wg.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 06 Feb 2018 08:55:31 +1100
> Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
>
>> On Mon, 2018-02-05 at 19:14 -0200, Mauricio Faria de Oliveira wrote:
>> > Nick, Michael,  
>> 
>> +Aneesh.
>> 
>> > On 02/05/2018 10:48 AM, Florian Weimer wrote:  
>> > > 7041  set_robust_list(0x7fff93dc3980, 24) = -1 ENOSYS (Function not 
>> > > implemented)  
>> > 
>> > The regression was introduced by commit 371b8044 ("powerpc/64s: 
>> > Initialize ISAv3 MMU registers before setting partition table").
>> > 
>> > The problem is Radix MMU specific (does not occur with 'disable_radix'),
>> > and does not occur with that code reverted (ie do not set PIDR to zero).
>> > 
>> > Do you see any reasons why?
>> > (wondering if at all related to access_ok() in include/asm/uaccess.h)
>
> Does this help?
>
> powerpc/64s/radix: allocate guard-PID for kernel contexts at boot
>
> 64s/radix uses PID 0 for its kernel mapping at the 0xCxxx (quadrant 3)
> address. This mapping is also accessible at 0x0xxx when PIDR=0 -- the
> top 2 bits just selects the addressing mode, which is effectively the
> same when PIDR=0 -- so address 0 translates to physical address 0 by
> the kernel's linear map.
>
> Commit 371b8044 ("powerpc/64s: Initialize ISAv3 MMU registers before
> setting partition table"), which zeroes PIDR at boot, caused this
> situation, and that stops kernel access to NULL from faulting in boot.
> Before this, we inherited what firmware or kexec gave, which is almost
> always non-zero.
>
> futex_atomic_cmpxchg detection is done in boot, by testing if it
> returns -EFAULT on a NULL address. This breaks when kernel access to
> NULL during boot does not fault.
>
> This patch allocates a non-zero guard PID for init_mm, and switches
> kernel context to the guard PID at boot. This disallows access to the
> kernel mapping from quadrant 0 at boot.
>
> The effectiveness of this protection will be diminished a little after
> boot when kernel threads inherit the last context, but those should
> have NULL guard areas, and it's possible we will actually prefer to do
> a non-lazy switch back to the guard PID in a future change. For now,
> this gives a minimal fix, and gives NULL pointer protection for boot.

I also have this as a part of another patch series. Since we already
support cmpxchg(), i would suggest we avoid the runtime check.

I needed this w.r.t hash so that we don't detect a NULL access as bad
slb address because we don't have PACA slb_addr_limit initialized
correctly that early.

commit c42b0fb10027af0c44fc9e2f6f9586203c38f99b
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Jan 24 13:54:22 2018 +0530

    Don't do futext cmp test.
    
    It access NULL address early in the boot and we want to avoid that to simplify
    the fault handling.
    futex_detect_cmpxchg() does a cmpxchg_futex_value_locked on a NULL user addr
    to runtime detect whether architecture implements atomic cmpxchg for futex.

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a429d859f15d..31bc2bd5dfd1 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -75,6 +75,7 @@ config PPC_BOOK3S_64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
 	select HAVE_KERNEL_XZ
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
 
