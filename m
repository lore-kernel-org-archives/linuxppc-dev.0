Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwYpv0DHczF19n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 22:05:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: Export ldbar spr to sysfs
In-Reply-To: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Tue, 06 Mar 2018 22:05:39 +1100
Message-ID: <878tb5foqk.fsf@concordia.ellerman.id.au>
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

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 4437c70..caefb64 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>  			device_create_file(s, &pmc_attrs[i]);
>  
>  #ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		device_create_file(s, &dev_attr_ldbar);

Is this register readable in supervisor state?

cheers
