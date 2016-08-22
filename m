Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHrJX0jwyzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 21:02:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7MB0BEf100928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 07:02:49 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24yauqmwg0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 07:02:49 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 21:02:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6FFEF3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 21:02:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7MB2hG332309388
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 21:02:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7MB2he2008243
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 21:02:43 +1000
Subject: Re: [PATCH] powerpc/powernv : Drop reference added by kset_find_obj()
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <1471848464-5735-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 16:32:40 +0530
MIME-Version: 1.0
In-Reply-To: <1471848464-5735-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57BADBD0.3030405@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2016 12:17 PM, Mukesh Ojha wrote:
> In a situation, where Linux kernel gets notified about duplicate error log
> from OPAL, it is been observed that kernel fails to remove sysfs entries
> (/sys/firmware/opal/elog/0xXXXXXXXX) of such error logs. This is because,
> we currently search the error log/dump kobject in the kset list via
> 'kset_find_obj()' routine. Which eventually increment the reference count
> by one, once it founds the kobject.
>
> So, unless we decrement the reference count by one after it found the kobject,
> we would not be able to release the kobject properly later.
>
> This patch adds the 'kobject_put()' which was missing earlier.
>
> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>


I've reviewed and tested this patch. Looks good to me.

Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant


> Cc: stable@vger.kernel.org
> ---
>   arch/powerpc/platforms/powernv/opal-dump.c | 7 ++++++-
>   arch/powerpc/platforms/powernv/opal-elog.c | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> index 2ee9643..4c82782 100644
> --- a/arch/powerpc/platforms/powernv/opal-dump.c
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -370,6 +370,7 @@ static irqreturn_t process_dump(int irq, void *data)
>   	uint32_t dump_id, dump_size, dump_type;
>   	struct dump_obj *dump;
>   	char name[22];
> +	struct kobject *kobj;
>
>   	rc = dump_read_info(&dump_id, &dump_size, &dump_type);
>   	if (rc != OPAL_SUCCESS)
> @@ -381,8 +382,12 @@ static irqreturn_t process_dump(int irq, void *data)
>   	 * that gracefully and not create two conflicting
>   	 * entries.
>   	 */
> -	if (kset_find_obj(dump_kset, name))
> +	kobj = kset_find_obj(dump_kset, name);
> +	if (kobj) {
> +		/* Drop reference added by kset_find_obj() */
> +		kobject_put(kobj);
>   		return 0;
> +	}
>
>   	dump = create_dump_obj(dump_id, dump_size, dump_type);
>   	if (!dump)
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 37f959b..f2344cb 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -247,6 +247,7 @@ static irqreturn_t elog_event(int irq, void *data)
>   	uint64_t elog_type;
>   	int rc;
>   	char name[2+16+1];
> +	struct kobject *kobj;
>
>   	rc = opal_get_elog_size(&id, &size, &type);
>   	if (rc != OPAL_SUCCESS) {
> @@ -269,8 +270,12 @@ static irqreturn_t elog_event(int irq, void *data)
>   	 * that gracefully and not create two conflicting
>   	 * entries.
>   	 */
> -	if (kset_find_obj(elog_kset, name))
> +	kobj = kset_find_obj(elog_kset, name);
> +	if (kobj) {
> +		/* Drop reference added by kset_find_obj() */
> +		kobject_put(kobj);
>   		return IRQ_HANDLED;
> +	}
>
>   	create_elog_obj(log_id, elog_size, elog_type);
>
