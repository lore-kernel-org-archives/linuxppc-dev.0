Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FD291A067D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 16:34:09 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 794C61409BB
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2015 16:34:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 Jul 2015 12:04:06 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B70CA1258044
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2015 12:06:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t646Y1L058327206
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jul 2015 12:04:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t646Y0BD008612
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jul 2015 12:04:01 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>, mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, shreyas@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] opal-elog: Fix opal-elog interrupt handler
In-Reply-To: <1435909152-18891-1-git-send-email-alistair@popple.id.au>
References: <1435909152-18891-1-git-send-email-alistair@popple.id.au>
Date: Sat, 04 Jul 2015 12:04:00 +0530
Message-ID: <877fqgsa7b.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

> The conversion of opal events to a proper irqchip means that handlers
> are called until the relevant opal event has been cleared by
> processing it. Events that queue work should therefore use a threaded
> handler to mask the event until processing is complete.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/opal-elog.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 4949ef0..37f959b 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -237,7 +237,7 @@ static struct elog_obj *create_elog_obj(uint64_t id, size_t size, uint64_t type)
>  	return elog;
>  }
>
> -static void elog_work_fn(struct work_struct *work)
> +static irqreturn_t elog_event(int irq, void *data)
>  {
>  	__be64 size;
>  	__be64 id;
> @@ -251,7 +251,7 @@ static void elog_work_fn(struct work_struct *work)
>  	rc = opal_get_elog_size(&id, &size, &type);
>  	if (rc != OPAL_SUCCESS) {
>  		pr_err("ELOG: OPAL log info read failed\n");
> -		return;
> +		return IRQ_HANDLED;
>  	}
>
>  	elog_size = be64_to_cpu(size);
> @@ -270,16 +270,10 @@ static void elog_work_fn(struct work_struct *work)
>  	 * entries.
>  	 */
>  	if (kset_find_obj(elog_kset, name))
> -		return;
> +		return IRQ_HANDLED;
>
>  	create_elog_obj(log_id, elog_size, elog_type);
> -}
> -
> -static DECLARE_WORK(elog_work, elog_work_fn);
>
> -static irqreturn_t elog_event(int irq, void *data)
> -{
> -	schedule_work(&elog_work);
>  	return IRQ_HANDLED;
>  }
>
> @@ -304,8 +298,8 @@ int __init opal_elog_init(void)
>  		return irq;
>  	}
>
> -	rc = request_irq(irq, elog_event,
> -			IRQ_TYPE_LEVEL_HIGH, "opal-elog", NULL);
> +	rc = request_threaded_irq(irq, NULL, elog_event,
> +			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "opal-elog", NULL);
>  	if (rc) {
>  		pr_err("%s: Can't request OPAL event irq (%d)\n",
>  		       __func__, rc);
> -- 
> 2.1.4
