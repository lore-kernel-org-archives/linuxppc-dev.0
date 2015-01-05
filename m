Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4528E1A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 03:47:35 +1100 (AEDT)
Message-ID: <54AA9C4D.3000001@freescale.com>
Date: Mon, 5 Jan 2015 16:14:37 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>
Subject: [RFC] PPC: MPIC: necessary readback after EOI?
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

While doing some performance testing of a KVM guest on a PPC platform, I 
noticed that there's a read of the CPU_WHOAMI register after each MPIC 
EOI [1]. This has been present since the initial implementation of the 
MPIC driver [2]. In a KVM virtualized environment, this results in an 
additional kvm_exit.

Is the read back necessary? Is it used to provide some sort of 
synchronization mechanism, making sure that nothing else is executed 
until the EOI write is finished? I eliminated the mpic_cpu_read call and 
run the kernel on hardware and noticed no anomaly, however I am not sure 
of all the implications and race conditions it might lead to.

I was curious why the mpic_cpu_read(MPIC_INFO(CPU_WHOAMI)) was there in 
the first place and if it's still needed. If it's still required, I 
guess a better approach is to eliminate the call only if the kernel is 
running on the KVM guest side, where the MPIC is emulated and no longer 
requires a readback.

Thank you,
Bogdan P.

[1] http://lxr.free-electrons.com/source/arch/powerpc/sysdev/mpic.c#L659
[2] https://lkml.org/lkml/2004/10/22/483
