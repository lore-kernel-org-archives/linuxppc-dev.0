Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41XGBG2sKmzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2018 02:12:37 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6KGA3oO062829
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 12:12:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kbgnbpycv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 12:12:34 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 20 Jul 2018 12:12:33 -0400
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
To: John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-2-jallen@linux.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 20 Jul 2018 11:12:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180717194048.3057-2-jallen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <72a0aa53-2268-2539-da97-34fb644717ac@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 02:40 PM, John Allen wrote:
> When a PRRN event is being handled and another PRRN event comes in, the
> second event will block rtas polling waiting on the first to complete,
> preventing any further rtas events from being handled. This can be
> especially problematic in case that PRRN events are continuously being
> queued in which case rtas polling gets indefinitely blocked completely.
> 
> This patch introduces a mutex that prevents any subsequent PRRN events from
> running while there is a prrn event being handled, allowing rtas polling to
> continue normally.
> 
> Signed-off-by: John Allen <jallen@linux.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> v2:
>    -Unlock prrn_lock when PRRN operations are complete, not after handler is
>     scheduled.
>    -Remove call to flush_work, the previous broken method of serializing
>     PRRN events.
> ---
>   arch/powerpc/kernel/rtasd.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 44d66c33d59d..845fc5aec178 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -35,6 +35,8 @@
> 
>   static DEFINE_SPINLOCK(rtasd_log_lock);
> 
> +static DEFINE_MUTEX(prrn_lock);
> +
>   static DECLARE_WAIT_QUEUE_HEAD(rtas_log_wait);
> 
>   static char *rtas_log_buf;
> @@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
>   	 */
>   	pseries_devicetree_update(-prrn_update_scope);
>   	numa_update_cpu_topology(false);
> +	mutex_unlock(&prrn_lock);
>   }
> 
>   static DECLARE_WORK(prrn_work, prrn_work_fn);
> 
>   static void prrn_schedule_update(u32 scope)
>   {
> -	flush_work(&prrn_work);
> -	prrn_update_scope = scope;
> -	schedule_work(&prrn_work);
> +	if (mutex_trylock(&prrn_lock)) {
> +		prrn_update_scope = scope;
> +		schedule_work(&prrn_work);
> +	}
>   }
> 
>   static void handle_rtas_event(const struct rtas_error_log *log)
> 
