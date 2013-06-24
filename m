Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0F1B2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 03:18:16 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 13:18:12 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 00AAAC90044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:18:10 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OHIAcP275624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:18:10 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OHIAai025873
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:18:10 -0400
Received: from kernel.stglabs.ibm.com (kernel.stglabs.ibm.com [9.114.214.19])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r5OHI7rJ025692
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:18:07 -0400
Date: Mon, 24 Jun 2013 12:18:04 -0500
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] Do not update sysfs cpu registration from invalid context
Message-ID: <20130624171804.GB3869@cerebellum>
References: <51C8543F.6080905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C8543F.6080905@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 24, 2013 at 09:14:23AM -0500, Nathan Fontenot wrote:
> The topology update code that updates the cpu node registration in sysfs
> should not be called while in stop_machine(). The register/unregister
> calls take a lock and may sleep.
> 
> This patch moves these calls outside of the call to stop_machine().
> 
> Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: Seth Jennings <sjenning@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/numa.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: powerpc/arch/powerpc/mm/numa.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/mm/numa.c	2013-06-24 06:53:31.000000000 -0500
> +++ powerpc/arch/powerpc/mm/numa.c	2013-06-24 06:56:30.000000000 -0500
> @@ -1433,11 +1433,9 @@
>  		if (cpu != update->cpu)
>  			continue;
> 
> -		unregister_cpu_under_node(update->cpu, update->old_nid);
>  		unmap_cpu_from_node(update->cpu);
>  		map_cpu_to_node(update->cpu, update->new_nid);
>  		vdso_getcpu_init();
> -		register_cpu_under_node(update->cpu, update->new_nid);
>  	}
> 
>  	return 0;
> @@ -1485,6 +1483,9 @@
>  	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
> 
>  	for (ud = &updates[0]; ud; ud = ud->next) {
> +		unregister_cpu_under_node(update->cpu, update->old_nid);
> +		register_cpu_under_node(update->cpu, update->new_nid);
> +
>  		dev = get_cpu_device(ud->cpu);
>  		if (dev)
>  			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
