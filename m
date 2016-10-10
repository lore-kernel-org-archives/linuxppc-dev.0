Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssxlb30TXzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 21:52:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Haren Myneni <hbabu@us.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/fadump: Fix the race in crash_fadump().
In-Reply-To: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
References: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
Date: Mon, 10 Oct 2016 21:52:10 +1100
Message-ID: <87lgxw5vdx.fsf@concordia.ellerman.id.au>
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
> There are chances that multiple CPUs can call crash_fadump() simultaneously
> and would start duplicating same info to vmcoreinfo ELF note section. This
> causes makedumpfile to fail during kdump capture. One example is,
> triggering dumprestart from HMC which sends system reset to all the CPUs at
> once.
...
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index b3a6633..2ed9d1c 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -402,8 +402,14 @@ void crash_fadump(struct pt_regs *regs, const char *str)
>  {
>  	struct fadump_crash_info_header *fdh = NULL;
>  
> -	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
> +	mutex_lock(&fadump_mutex);

What happens when a crashing CPU can't get the mutex and goes to sleep?

cheers
