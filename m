Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXVy1618kzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:46:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S7dGoK000551
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:46:15 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28w1xnqf88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:46:13 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 28 Feb 2017 17:45:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CFBF13578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:45:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S7jjKS56557604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:45:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S7jKTE001151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:45:20 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 3/7] cxl: Keep track of mm struct associated with a context
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-4-git-send-email-clombard@linux.vnet.ibm.com>
Date: Tue, 28 Feb 2017 18:44:56 +1100
MIME-Version: 1.0
In-Reply-To: <1485970213-25532-4-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d90a3fca-9bc9-82ce-c0e8-1632ba409b31@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/17 04:30, Christophe Lombard wrote:
> The mm_struct corresponding to the current task is acquired each time
> an interrupt is raised. So to simplify the code, we only get the
> mm_struct when attaching an AFU context to the process.
> The mm_count reference is increased to ensure that the mm_struct can't
> be freed. The mm_struct will be released when the context is detached.
> The reference (use count) on the struct mm is not kept to avoid a
> circular dependency if the process mmaps its cxl mmio and forget to
> unmap before exiting.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

One question below, otherwise this all looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> @@ -281,7 +212,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
>  	if (!ctx->kernel) {
>
>  		mm = get_mem_context(ctx);
> -		/* indicates all the thread in task group have exited */
>  		if (mm == NULL) {
>  			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
>  				 __func__, ctx->pe, pid_nr(ctx->pid));

Is there still a case where mm can equal NULL?

> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 859959f..af6bd0e 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -216,8 +216,16 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	 * process is still accessible.
>  	 */
>  	ctx->pid = get_task_pid(current, PIDTYPE_PID);
> -	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
>
> +	/* acquire a reference to the task's mm */
> +	ctx->mm = get_task_mm(current);
> +
> +	/* ensure this mm_struct can't be freed */
> +	cxl_context_mm_count_get(ctx);
> +
> +	/* decrement the use count */
> +	if (ctx->mm)
> +		mmput(ctx->mm);

It took me a while to work out the difference between mm_users and 
mm_count... this looks fine.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
