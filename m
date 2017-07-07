Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3lMm4R5xzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 16:39:48 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v676cbg2076078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 02:39:45 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bhwbynh9v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 02:39:44 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 7 Jul 2017 16:39:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v676ddVD64684130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 16:39:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v676dUNL027915
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 16:39:31 +1000
Subject: Re: [next-20170609] Oops while running CPU off-on
 (cpuset.c/cpuset_can_attach)
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>, mpe
 <mpe@ellerman.id.au>
Date: Fri, 07 Jul 2017 12:09:34 +0530
In-Reply-To: <20170705152855.GD19330@htj.duckdns.org>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
 <20170627153608.GD2289@htj.duckdns.org>
 <1499092582.10651.15.camel@abdul.in.ibm.com>
 <20170705152855.GD19330@htj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499409574.19784.26.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-05 at 11:28 -0400, Tejun Heo wrote:
> Hello, Abdul.
> 
> Thanks for the debug info.  Can you please see whether the following
> patch fixes the issue?  

It is my pleasure and yes the patch fixes the problem.

> If the problem is too difficult to reproduce

The problem was reproducible all the time. 

With the patch fix, I tried multiple times and long runs of cpu off-on
cycles but no Oops is seen.

Thank you for spending your valuable time on fixing this issue.

Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

> to confirm the fix by seeing whether it no longer triggers, please let
> me know.  We can instead apply a patch which triggers WARN on the
> failing condition to confirm the diagnosis.
> 
> Thanks.
> 
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 793565c05742..8b4c3c2f2509 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -33,6 +33,9 @@ struct cgroup_taskset {
>  	struct list_head	src_csets;
>  	struct list_head	dst_csets;
> 
> +	/* the number of tasks in the set */
> +	int			nr_tasks;
> +
>  	/* the subsys currently being processed */
>  	int			ssid;
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index dbfd7028b1c6..e3c4152741a3 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1954,6 +1954,8 @@ static void cgroup_migrate_add_task(struct task_struct *task,
>  	if (!cset->mg_src_cgrp)
>  		return;
> 
> +	mgctx->tset.nr_tasks++;
> +
>  	list_move_tail(&task->cg_list, &cset->mg_tasks);
>  	if (list_empty(&cset->mg_node))
>  		list_add_tail(&cset->mg_node,
> @@ -2047,16 +2049,18 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
>  		return 0;
> 
>  	/* check that we can legitimately attach to the cgroup */
> -	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> -		if (ss->can_attach) {
> -			tset->ssid = ssid;
> -			ret = ss->can_attach(tset);
> -			if (ret) {
> -				failed_ssid = ssid;
> -				goto out_cancel_attach;
> +	if (tset->nr_tasks) {
> +		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> +			if (ss->can_attach) {
> +				tset->ssid = ssid;
> +				ret = ss->can_attach(tset);
> +				if (ret) {
> +					failed_ssid = ssid;
> +					goto out_cancel_attach;
> +				}
>  			}
> -		}
> -	} while_each_subsys_mask();
> +		} while_each_subsys_mask();
> +	}
> 
>  	/*
>  	 * Now that we're guaranteed success, proceed to move all tasks to
> @@ -2085,25 +2089,29 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
>  	 */
>  	tset->csets = &tset->dst_csets;
> 
> -	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> -		if (ss->attach) {
> -			tset->ssid = ssid;
> -			ss->attach(tset);
> -		}
> -	} while_each_subsys_mask();
> +	if (tset->nr_tasks) {
> +		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> +			if (ss->attach) {
> +				tset->ssid = ssid;
> +				ss->attach(tset);
> +			}
> +		} while_each_subsys_mask();
> +	}
> 
>  	ret = 0;
>  	goto out_release_tset;
> 
>  out_cancel_attach:
> -	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> -		if (ssid == failed_ssid)
> -			break;
> -		if (ss->cancel_attach) {
> -			tset->ssid = ssid;
> -			ss->cancel_attach(tset);
> -		}
> -	} while_each_subsys_mask();
> +	if (tset->nr_tasks) {
> +		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
> +			if (ssid == failed_ssid)
> +				break;
> +			if (ss->cancel_attach) {
> +				tset->ssid = ssid;
> +				ss->cancel_attach(tset);
> +			}
> +		} while_each_subsys_mask();
> +	}
>  out_release_tset:
>  	spin_lock_irq(&css_set_lock);
>  	list_splice_init(&tset->dst_csets, &tset->src_csets);
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
