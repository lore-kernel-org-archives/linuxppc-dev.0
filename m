Return-Path: <linuxppc-dev+bounces-21684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0394CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:43:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRb214RCFz2yQH;
	Fri, 29 May 2026 17:43:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780040601;
	cv=none; b=OGQ8tfFRQ++OP4QQPCtJFK3Tqe3O0EFglioXAZLY5fvMASfllrchigv5WRJx3sS251Rhmi57mQI+w13DYxSo+r7ZAxhRXFrV3b8vReh62mO13/aagcTRvuotQlLtu4y9SiirG/IkAM9u3EFKuMwdsYI4OY7l7l1h3DtW0ff69vdLTprsyNtXrOAxFpDFX/gZeJSDDMeka0o0kac/1d7NGafU6mXdzskSxBQUk5Xa7jA9tK7SgUmK8QjVsTHMzvRgZY9bAT6QlvoWpAtX9Xu4hKcvUoUhOx3fdAwXykwPM9I9gqOYhntwihOfOSuweDTKpClQ4PYJTFCX/j/H4R2sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780040601; c=relaxed/relaxed;
	bh=K3PHrpl2QgP8dFFX0ysthlLv/k/xZ+1P1rJRBQ4n02s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOoWqwGS3aWk94RmYB7g2009XmZp41RqwM6FDqK1VaxcbpQs3BIL8PDME82KbtSCLIMD7pqyUxM5YN4Ibv/I5iimRQwMZq3VmZ6sIIhIsgsDI3GzeaqtQe0b8SG5DsokXfk4C8atYLz9yQaYiod/3+zTpHJksHGGD/FH7NTUIi1wWyprt0KZ8YNxCcFD0eXRBMId9il4chs4YNbNq62rS7f3FGxgU8WeaaF6YWLQKXB3BYp14/TMY0RZ954fDuf5nUbwVtDpaSxV05dCOoY2ivmyLJAMcOPcwzkQHB0az7RsYr2krQ95h8rAIWMdjZMmZcifSvrNa4PShwoQIGhLnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls3hGQ9b; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls3hGQ9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRb205zc9z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:43:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1391260564;
	Fri, 29 May 2026 07:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F441F00898;
	Fri, 29 May 2026 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040597;
	bh=K3PHrpl2QgP8dFFX0ysthlLv/k/xZ+1P1rJRBQ4n02s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ls3hGQ9bBCCV65FkzwKhquL3JLN4wxaomvnvBM7qNqs98M5DXI4vmHKsloEC6IvXF
	 e3vYAGcRikwjEmroBA9k7JCJ6w4oHRhKRJUwQRPY04AKa3IZZWnwug3TFYUj2p/DoY
	 We8Hs/rf4Vm3FL3a8VTXMNnUuo21HMTvXMDwE5TQScUxsIO5Lq8eHyZuchx3F0s/nD
	 qylFRAW0X3RNWjIFi1iQaSLcIK98tKvEGMLQu+YSPo+5NcFM3IZFRl8VZrns8phPJi
	 2jc5889Uu6m/ooW3d14iw1QyRdMUWYx/F+3sKTDcqvmblpLlthU8z/5E7QL4T/RqIf
	 nqj0aeY9VmX0A==
Message-ID: <68c83e4d-92e8-4471-99b2-404eb4f79ffa@kernel.org>
Date: Fri, 29 May 2026 09:43:13 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc/irq: Move __softirq_pending out of irq_stat
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
References: <20260523174016.999456-1-sshegde@linux.ibm.com>
 <20260523174016.999456-2-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260523174016.999456-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/05/2026 à 19:40, Shrikanth Hegde a écrit :
> __softirq_pending isn't part of arch specific irq_stats. It is used
> by softirq core for various decision making such as whether to kick off
> ksoftirqd.
> 
> Move it out of irq_cpustat_t. This makes it simple to make irq_cpustat_t
> array based approach.

Some reference to commit 0fd7d8628529 ("softirq/core: Consolidate 
default local_softirq_pending() implementations") should be made I think 
for better understanding.

> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   arch/powerpc/include/asm/hardirq.h | 3 ++-
>   arch/powerpc/kernel/irq.c          | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
> index f133b5930ae1..bf3926a0c69c 100644
> --- a/arch/powerpc/include/asm/hardirq.h
> +++ b/arch/powerpc/include/asm/hardirq.h
> @@ -6,7 +6,6 @@
>   #include <linux/irq.h>
>   
>   typedef struct {
> -	unsigned int __softirq_pending;
>   	unsigned int timer_irqs_event;
>   	unsigned int broadcast_irqs_event;
>   	unsigned int timer_irqs_others;
> @@ -23,6 +22,8 @@ typedef struct {
>   } ____cacheline_aligned irq_cpustat_t;
>   
>   DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
> +DECLARE_PER_CPU(unsigned int, __softirq_pending);
> +#define local_softirq_pending_ref       __softirq_pending
>   
>   #define __ARCH_IRQ_STAT
>   #define __ARCH_IRQ_EXIT_IRQS_DISABLED
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a0e8b998c9b5..f33df5e5c23f 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -73,6 +73,7 @@
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>   EXPORT_PER_CPU_SYMBOL(irq_stat);
> +DEFINE_PER_CPU(unsigned int, __softirq_pending);
>   
>   #ifdef CONFIG_PPC32
>   atomic_t ppc_n_lost_interrupts;


