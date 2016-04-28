Return-Path: <waiman.long@hpe.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0108.outbound.protection.outlook.com [157.56.111.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwr0J3jf1zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 07:42:40 +1000 (AEST)
Message-ID: <57227BAA.7040807@hpe.com>
Date: Thu, 28 Apr 2016 17:07:54 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Paul Mackerras
 <paulus@samba.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, <jeremy@goop.org>, <chrisw@sous-sol.org>,
 <akataria@vmware.com>, <rusty@rustcorp.com.au>, <gwshan@linux.vnet.ibm.com>,
 <adam.buchbinder@gmail.com>, <tglx@linutronix.de>, <marc.zyngier@arm.com>
Subject: Re: [PATCH resend] powerpc: enable qspinlock and its virtualization
 support
References: <5721EC0E.8040506@linux.vnet.ibm.com>
In-Reply-To: <5721EC0E.8040506@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2016 06:55 AM, Pan Xinhui wrote:
> From: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
>
> This patch aims to enable qspinlock on PPC. And on pseries platform, it also support
> paravirt qspinlock.
>
> Signed-off-by: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/qspinlock.h               | 37 +++++++++++++++
>   arch/powerpc/include/asm/qspinlock_paravirt.h      | 36 +++++++++++++++
>   .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 ++++++
>   arch/powerpc/include/asm/spinlock.h                | 31 ++++++++-----
>   arch/powerpc/include/asm/spinlock_types.h          |  4 ++
>   arch/powerpc/kernel/paravirt.c                     | 52 ++++++++++++++++++++++
>   arch/powerpc/lib/locks.c                           | 32 +++++++++++++
>   arch/powerpc/platforms/pseries/setup.c             |  5 +++
>   8 files changed, 198 insertions(+), 12 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
>   create mode 100644 arch/powerpc/kernel/paravirt.c
>
>

This is just an enablement patch. You will also need a patch to activate 
qspinlock for, at lease, some PPC configs. Right?

It has dependency on the pv_wait() patch that I sent out extend the 
parameter list. Some performance data on how PPC system will perform 
with and without qspinlock will also be helpful data points.

Cheers,
Longman
