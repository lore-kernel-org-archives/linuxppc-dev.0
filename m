Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlCzc1BSXzDrDk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 17:10:51 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1J63adh082472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 01:10:49 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g7ppkkxg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 01:10:48 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 19 Feb 2018 06:10:47 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V3] cxl: Fix timebase synchronization status on P9
In-Reply-To: <1518794852-30137-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1518794852-30137-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 11:40:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87woz9h5lp.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Christophe,

Mostly ok with this patch. Some very minor review comments:

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -62,6 +62,16 @@ static ssize_t psl_timebase_synced_show(struct device *device,
>  					char *buf)
>  {
>  	struct cxl *adapter = to_cxl_adapter(device);
> +	u64 psl_tb;
> +	int delta;
> +
> +	psl_tb = adapter->native->sl_ops->timebase_read(adapter);
> +	delta = mftb() - psl_tb;
> +	if (delta < 0)
> +		delta = -delta;
Can just use abs().
> +
> +	/* CORE TB and PSL TB difference <= 16usecs ? */
> +	adapter->psl_timebase_synced = (tb_to_ns(delta) < 16000) ? true : false;
Can be re-written as
'adapter->psl_timebase_synced = (tb_to_ns(abs(delta)) < 16000);'

>
>  	return scnprintf(buf, PAGE_SIZE, "%i\n",
>  	adapter->psl_timebase_synced);
Might be a good idea to debug print/print_once the delta.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
