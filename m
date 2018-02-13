Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgtQq300czF1Pj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:49:19 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DJi5DJ034120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:49:17 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g45u0hjj9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:49:16 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 12:49:15 -0700
Subject: Re: [PATCH 2/2] powerpc/pseries: Declare optional dummy function for
 find_and_online_cpu_nid
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
 <1518474848-3158-2-git-send-email-linux@roeck-us.net>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 11:49:10 -0800
MIME-Version: 1.0
In-Reply-To: <1518474848-3158-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <943e73c6-cadb-cf9e-9c7f-a7b687e7177a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2018 02:34 PM, Guenter Roeck wrote:
> Commit e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with
> memoryless nodes") adds an unconditional call to find_and_online_cpu_nid(),
> which is only declared if CONFIG_PPC_SPLPAR is enabled. This results in
> the following build error if this is not the case.
> 
> arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
> arch/powerpc/platforms/pseries/hotplug-cpu.c:369:
> 			undefined reference to `.find_and_online_cpu_nid'
> 
> Follow the guideline provided by similar functions and provide a dummy
> function if CONFIG_PPC_SPLPAR is not enabled. This also moves the external
> function declaration into an include file where it should be.
> 
> Fixes: e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with ...")
> Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Nathan already sent a patch on the 9th for this issue to the list.

-Tyrel

> ---
>  arch/powerpc/include/asm/topology.h          | 5 +++++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 --
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 88187c285c70..52815982436f 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -82,6 +82,7 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
>  extern int start_topology_update(void);
>  extern int stop_topology_update(void);
>  extern int prrn_is_enabled(void);
> +extern int find_and_online_cpu_nid(int cpu);
>  #else
>  static inline int start_topology_update(void)
>  {
> @@ -95,6 +96,10 @@ static inline int prrn_is_enabled(void)
>  {
>  	return 0;
>  }
> +static inline int find_and_online_cpu_nid(int cpu)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> 
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index dceb51454d8d..f5c6a8cd2926 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -340,8 +340,6 @@ static void pseries_remove_processor(struct device_node *np)
>  	cpu_maps_update_done();
>  }
> 
> -extern int find_and_online_cpu_nid(int cpu);
> -
>  static int dlpar_online_cpu(struct device_node *dn)
>  {
>  	int rc = 0;
> 
