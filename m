Return-Path: <ego.lkml@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Dzpl2WRYzF0fg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 20:32:59 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id y4-v6so816789pgp.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 03:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
In-Reply-To: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Tue, 18 Sep 2018 16:02:45 +0530
Message-ID: <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
To: nfont@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,
On Tue, Sep 18, 2018 at 1:05 AM Nathan Fontenot
<nfont@linux.vnet.ibm.com> wrote:
>
> When performing partition migrations all present CPUs must be online
> as all present CPUs must make the H_JOIN call as part of the migration
> process. Once all present CPUs make the H_JOIN call, one CPU is returned
> to make the rtas call to perform the migration to the destination system.
>
> During testing of migration and changing the SMT state we have found
> instances where CPUs are offlined, as part of the SMT state change,
> before they make the H_JOIN call. This results in a hung system where
> every CPU is either in H_JOIN or offline.
>
> To prevent this this patch disables CPU hotplug during the migration
> process.
>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8afd146bc9c7..2c7ed31c736e 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -981,6 +981,7 @@ int rtas_ibm_suspend_me(u64 handle)
>                 goto out;
>         }
>
> +       cpu_hotplug_disable();

So, some of the onlined CPUs ( via
rtas_online_cpus_mask(offline_mask);) can go still offline,
if the userspace issues an offline command, just before we execute
cpu_hotplug_disable().

So we are narrowing down the race, but it still exists. Am I missing something ?

>         stop_topology_update();
>
>         /* Call function on all CPUs.  One of us will make the
> @@ -995,6 +996,7 @@ int rtas_ibm_suspend_me(u64 handle)
>                 printk(KERN_ERR "Error doing global join\n");
>
>         start_topology_update();
> +       cpu_hotplug_enable();
>
>         /* Take down CPUs not online prior to suspend */
>         cpuret = rtas_offline_cpus_mask(offline_mask);
>


-- 
Thanks and Regards
gautham.
