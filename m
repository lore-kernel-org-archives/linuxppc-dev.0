Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA0C51A0A42
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 08:45:04 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 19 Dec 2014 21:44:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 27B5A2190046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 21:44:27 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBJLiuAU57999600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 21:44:56 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBJLiuLG027219
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 16:44:56 -0500
Date: Fri, 19 Dec 2014 22:44:52 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: force all CPUs to be bootable
Message-ID: <20141219224452.0a3f48da@bahia.local>
In-Reply-To: <20141212113627.12778.47915.stgit@bahia.local>
References: <20141212113627.12778.47915.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Dec 2014 12:37:40 +0100
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> The subcore logic needs all the CPUs declared in the DT to be bootable,
> otherwise the kernel hangs at boot time. Since subcore support starts
> with POWER8, we can keep the current behaviour for older CPUs.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> 
> Since smt-enabled is still needed by Freescale, the choice was made to fix
> powernv only. I could test that smt-enabled is still honored on POWER7 and
> ignored on POWER8, as expected.
> 

FWIW I get plenty (for nearly all vcpus) the following dump when booting a
PowerKVM guest on a virtio-blk disk with smt-enabled=off:

[   10.535151] kobject '(null)' (c0000007ff260c18): tried to add an uninitialized object, something is seriously wrong.
[   10.535538] CPU: 12 PID: 708 Comm: systemd-udevd Not tainted 3.18.0-rc3+ #3
[   10.535779] Call Trace:
[   10.535886] [c0000000ff0e38f0] [c0000000007a1db8] dump_stack+0x90/0xbc (unreliable)
[   10.536242] [c0000000ff0e3920] [c0000000003c5504] kobject_add+0xc4/0xd0
[   10.536593] [c0000000ff0e39a0] [c00000000039df20] blk_mq_register_hctx+0xd0/0x100
[   10.536930] [c0000000ff0e3a20] [c00000000039ed0c] blk_mq_sysfs_register+0x5c/0xb0
[   10.537257] [c0000000ff0e3a50] [c00000000039b694] blk_mq_queue_reinit_notify+0xc4/0x110
[   10.537594] [c0000000ff0e3a90] [c0000000000c5388] notifier_call_chain+0x88/0x100
[   10.537942] [c0000000ff0e3ae0] [c00000000009e264] cpu_notify+0x34/0x80
[   10.538227] [c0000000ff0e3b00] [c00000000009e794] _cpu_up+0x204/0x210
[   10.538519] [c0000000ff0e3bb0] [c00000000009e8ac] cpu_up+0x10c/0x130
[   10.538796] [c0000000ff0e3c30] [c00000000062121c] cpu_subsys_online+0x5c/0xe0
[   10.539089] [c0000000ff0e3c80] [c0000000004bf0e4] device_online+0xb4/0x120
[   10.539370] [c0000000ff0e3cc0] [c0000000004bf1f4] online_store+0xa4/0xb0
[   10.539651] [c0000000ff0e3d00] [c0000000004bb744] dev_attr_store+0x34/0x60
[   10.539929] [c0000000ff0e3d20] [c0000000003038c4] sysfs_kf_write+0x64/0xa0
[   10.540217] [c0000000ff0e3d40] [c000000000302940] kernfs_fop_write+0x140/0x1d0
[   10.540553] [c0000000ff0e3d90] [c00000000026ac64] vfs_write+0xd4/0x260
[   10.540831] [c0000000ff0e3de0] [c00000000026b780] SyS_write+0x60/0x110
[   10.541131] [c0000000ff0e3e30] [c0000000000091fc] syscall_exit+0x0/0x7c

It seems that split core isn't the only code that gets affected by smt-enabled.
Should we drop cpu_bootable for pseries ?

Cheers.

--
Greg

>  arch/powerpc/platforms/powernv/smp.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index b716f66..5b6e002 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -198,13 +198,24 @@ static void pnv_smp_cpu_kill_self(void)
>  
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +static int pnv_cpu_bootable(unsigned int nr)
> +{
> +	/* Starting with POWER8, all CPUs need to be booted to avoid hangs
> +	 * during subcore init.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S))
> +		return 1;
> +
> +	return smp_generic_cpu_bootable(nr);
> +}
> +
>  static struct smp_ops_t pnv_smp_ops = {
>  	.message_pass	= smp_muxed_ipi_message_pass,
>  	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
>  	.probe		= xics_smp_probe,
>  	.kick_cpu	= pnv_smp_kick_cpu,
>  	.setup_cpu	= pnv_smp_setup_cpu,
> -	.cpu_bootable	= smp_generic_cpu_bootable,
> +	.cpu_bootable	= pnv_cpu_bootable,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_disable	= pnv_smp_cpu_disable,
>  	.cpu_die	= generic_cpu_die,
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
