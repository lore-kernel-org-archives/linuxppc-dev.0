Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73B7B1A0EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 01:40:20 +1100 (AEDT)
Message-ID: <1420641610.5830.29.camel@kernel.crashing.org>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Wed, 07 Jan 2015 15:40:10 +0100
In-Reply-To: <54AA9C4D.3000001@freescale.com>
References: <54AA9C4D.3000001@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-05 at 16:14 +0200, Purcareata Bogdan wrote:
> Hello,
> 
> While doing some performance testing of a KVM guest on a PPC platform, I 
> noticed that there's a read of the CPU_WHOAMI register after each MPIC 
> EOI [1]. This has been present since the initial implementation of the 
> MPIC driver [2]. In a KVM virtualized environment, this results in an 
> additional kvm_exit.
> 
> Is the read back necessary? Is it used to provide some sort of 
> synchronization mechanism, making sure that nothing else is executed 
> until the EOI write is finished? I eliminated the mpic_cpu_read call and 
> run the kernel on hardware and noticed no anomaly, however I am not sure 
> of all the implications and race conditions it might lead to.

It was done to ensure that the store to the EOI has reached the MPIC and
been fully processed before re-enabling interrupts on the CPU. On some
implementations, the MPIC runs quite slowly (significantly slower than
the core) and the stores to it are asynchronous, so we had situation
where we would restore interrupts while the MPIC hasn't yet de-asserted
the output line.

One way to work around the performance loss for you would be to add some
DT property to indicate to the guest that the read isn't necessary.

> I was curious why the mpic_cpu_read(MPIC_INFO(CPU_WHOAMI)) was there in 
> the first place and if it's still needed. If it's still required, I 
> guess a better approach is to eliminate the call only if the kernel is 
> running on the KVM guest side, where the MPIC is emulated and no longer 
> requires a readback.
> 
> Thank you,
> Bogdan P.
> 
> [1] http://lxr.free-electrons.com/source/arch/powerpc/sysdev/mpic.c#L659
> [2] https://lkml.org/lkml/2004/10/22/483
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
