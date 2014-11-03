Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCC391A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 02:45:39 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 08:45:35 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9372F3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 08:45:32 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id sA3FjWhi45744166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 16:45:32 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA3FjRdN005673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 08:45:29 -0700
Message-ID: <5457A314.8080806@linux.vnet.ibm.com>
Date: Mon, 03 Nov 2014 09:45:24 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dan Streetman <ddstreet@ieee.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: use device_online/offline() instead of
 cpu_up/down()
References: <CALZtONCwrBb+HPY7j7x4R-xmyhajFNCwaS3sns50RMDxHxyiEQ@mail.gmail.com>
 <1414784494-12573-1-git-send-email-ddstreet@ieee.org>
In-Reply-To: <1414784494-12573-1-git-send-email-ddstreet@ieee.org>
Content-Type: text/plain; charset=utf-8
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Daniel Walter <dwalter@google.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Neil Zhang <zhangwm@marvell.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2014 02:41 PM, Dan Streetman wrote:
> In powerpc pseries platform dlpar operations, Use device_online() and
> device_offline() instead of cpu_up() and cpu_down().
> 
> Calling cpu_up/down directly does not update the cpu device offline
> field, which is used to online/offline a cpu from sysfs.  Calling
> device_online/offline instead keeps the sysfs cpu online value correct.
> The hotplug lock, which is required to be held when calling
> device_online/offline, is already held when dlpar_online/offline_cpu
> are called, since they are called only from cpu_probe|release_store.
> 
> This patch fixes errors on PowerVM systems that have cpu(s) added/removed
> using dlpar operations; without this patch, the
> /sys/devices/system/cpu/cpuN/online nodes do not correctly show the
> online state of added/removed cpus.
> 
> Signed-off-by: Dan Streetman <ddstreet@ieee.org>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> 
> Previous discussion for this:
> https://lkml.org/lkml/2014/10/29/839
> 
>  arch/powerpc/platforms/pseries/dlpar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 6ad83bd..c22bb1b 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -382,7 +382,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>  			BUG_ON(get_cpu_current_state(cpu)
>  					!= CPU_STATE_OFFLINE);
>  			cpu_maps_update_done();
> -			rc = cpu_up(cpu);
> +			rc = device_online(get_cpu_device(cpu));
>  			if (rc)
>  				goto out;
>  			cpu_maps_update_begin();
> @@ -467,7 +467,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
>  				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
>  				cpu_maps_update_done();
> -				rc = cpu_down(cpu);
> +				rc = device_offline(get_cpu_device(cpu));
>  				if (rc)
>  					goto out;
>  				cpu_maps_update_begin();
> 
