Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHPqb6fF7zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 11:10:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/powernv: Add more BPF in defconfig
In-Reply-To: <20170206025544.3292-2-mikey@neuling.org>
References: <20170206025544.3292-1-mikey@neuling.org>
 <20170206025544.3292-2-mikey@neuling.org>
Date: Tue, 07 Feb 2017 11:10:16 +1100
Message-ID: <87tw86g8t3.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> This enables BCC (https://github.com/iovisor/bcc) on powernv.
>
> This adds 225KB to the vmlinux size.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/configs/powernv_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 7028dbc753..911b43e2c7 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -29,6 +29,7 @@ CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_PERF=y
>  CONFIG_USER_NS=y
>  CONFIG_BLK_DEV_INITRD=y
> +CONFIG_BPF_SYSCALL=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=y
>  CONFIG_OPROFILE=y
> @@ -79,6 +80,10 @@ CONFIG_NETFILTER=y
>  # CONFIG_NETFILTER_ADVANCED is not set
>  CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
> +CONFIG_NET_SCHED=y
> +CONFIG_NET_CLS_BPF=y
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_ACT_BPF=y

I'm inclined to make these =m.

I assume that would still work for bcc?

cheers
