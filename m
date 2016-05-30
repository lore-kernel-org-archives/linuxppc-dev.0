Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ7kX5MsWzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 17:37:40 +1000 (AEST)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 30 May 2016 08:37:37 +0100
Date: Mon, 30 May 2016 09:37:29 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-ppc] [PATCH] powerpc/pseries: start rtasd before PCI probing
Message-ID: <20160530093729.768a9fe3@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
References: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 May 2016 10:28:28 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> A strange behaviour is observed when comparing PCI hotplug in QEMU, between
> x86 and pseries. If you consider the following steps:
> - start a VM
> - add a PCI device via the QEMU monitor before the rtasd has started (for
>   example starting the VM in paused state, or hotplug during FW or boot
>   loader)
> - resume the VM execution
> 
> The x86 kernel detects the PCI device, but the pseries one does not.
> 
> This happens because the rtasd kernel worker is currently started under
> device_initcall, while PCI probing happens earlier under subsys_initcall.
> 
> As a consequence, if we have a pending RTAS event at boot time, a message
> is printed and the event is dropped.
> 
> This patch moves all the initialization of rtasd to arch_initcall, which is
> run before subsys_call: this way, logging_enabled is true when the RTAS
> event pops up and it is not lost anymore.
> 
> The proc fs bits stay at device_initcall because they cannot be run before
> fs_initcall.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---

Ping ?

>  arch/powerpc/kernel/rtasd.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index e864b7c5884e..ad9e4e1a2d5d 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -526,10 +526,8 @@ void rtas_cancel_event_scan(void)
>  }
>  EXPORT_SYMBOL_GPL(rtas_cancel_event_scan);
> 
> -static int __init rtas_init(void)
> +static int __init rtas_event_scan_init(void)
>  {
> -	struct proc_dir_entry *entry;
> -
>  	if (!machine_is(pseries) && !machine_is(chrp))
>  		return 0;
> 
> @@ -562,13 +560,24 @@ static int __init rtas_init(void)
>  		return -ENOMEM;
>  	}
> 
> +	start_event_scan();
> +
> +	return 0;
> +}
> +arch_initcall(rtas_event_scan_init);
> +
> +static int __init rtas_init(void)
> +{
> +	struct proc_dir_entry *entry;
> +
> +	if (!machine_is(pseries) && !machine_is(chrp))
> +		return 0;
> +
>  	entry = proc_create("powerpc/rtas/error_log", S_IRUSR, NULL,
>  			    &proc_rtas_log_operations);
>  	if (!entry)
>  		printk(KERN_ERR "Failed to create error_log proc entry\n");
> 
> -	start_event_scan();
> -
>  	return 0;
>  }
>  __initcall(rtas_init);
> 
> 
