Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0b9c1Dx5zDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:19:15 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L6IVI8096497
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 02:19:12 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2675yg7qw2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 02:19:11 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 21 Oct 2016 16:19:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2EA442BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:19:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L6J6oW15335588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:19:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L6J5Pw029246
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:19:05 +1100
Subject: Re: [PATCH] cxl: Fix leaking pid refs in some error paths
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1477028783-1260-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 21 Oct 2016 17:19:05 +1100
MIME-Version: 1.0
In-Reply-To: <1477028783-1260-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <923f7b85-fc43-4e4b-0121-ba82eefa67cc@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/10/16 16:46, Vaibhav Jain wrote:
> In some error paths in functions cxl_start_context and
> afu_ioctl_start_work pid references to the current & group-leader tasks
> can leak after they are taken. This patch fixes these error paths to
> release these pid references before exiting the error path.
>
> This patch is based on earlier patch "cxl: Prevent adapter reset
> if an active context exists" at
> https://patchwork.ozlabs.org/patch/682187/

Put this paragraph under the ---.

>
> Fixes: 7b8ad495("cxl: Fix DSI misses when the context owning task exits")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/api.c  |  2 ++
>  drivers/misc/cxl/file.c | 22 +++++++++++++---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index af23d7d..2e5233b 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -247,7 +247,9 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
>  	cxl_ctx_get();
>
>  	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
> +		put_pid(ctx->glpid);
>  		put_pid(ctx->pid);
> +		ctx->glpid = ctx->pid = NULL;

This is only needed if task != NULL, but I think it should be okay as 
long as ctx->[gl]pid is already NULL in that situation (which I haven't 
checked but I think that's the case).

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
