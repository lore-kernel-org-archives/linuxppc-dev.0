Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:26:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680D82086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680D82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vfc831BnzF1HF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:26:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VfYp0VhgzF12D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:24:13 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AGEeMK002714
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:24:11 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jwxx21p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:24:11 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 12:24:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 12:24:08 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AGO7GI24248548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 16:24:07 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6009124052;
 Wed, 10 Oct 2018 13:23:53 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56C2C124053;
 Wed, 10 Oct 2018 13:23:53 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.80.235.83])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Oct 2018 13:23:53 -0400 (EDT)
Subject: Re: [PATCH v02] powerpc/mobility: Extend start/stop topology update
 scope
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181009195504.22636.20595.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Oct 2018 11:24:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009195504.22636.20595.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101016-0072-0000-0000-000003B2A3D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009854; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100689; UDB=6.00569503; IPR=6.00880738; 
 MB=3.00023698; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 16:24:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101016-0073-0000-0000-000049B56BA8
Message-Id: <83891d4a-067f-646c-9b16-f428a13d5534@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100159
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/09/2018 03:12 PM, Michael Bringmann wrote:
> The PPC mobility code may receive RTAS requests to perform PRRN
> topology changes at any time, including during LPAR migration
> operations.  In some configurations where the affinity of CPUs
> or memory is being changed on that platform, the PRRN requests
> may apply or refer to outdated information prior to the complete
> update of the device-tree.  This patch changes the duration for
> which topology updates are suppressed during LPAR migrations from
> just the rtas_ibm_suspend_me / 'ibm,suspend-me' call(s) to cover
> the entire 'migration_store' operation to allow all changes to
> the device-tree to be applied prior to accepting and applying any
> PRRN requests.
> 
> For tracking purposes, pr_info notices are added to the functions
> start_topology_update() and stop_topology_update() of 'numa.c'.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
> Changes in v02:
>   -- Rebase to latest powerpc next tree.
> ---
>  arch/powerpc/kernel/rtas.c                |    2 --
>  arch/powerpc/mm/numa.c                    |    6 ++++++
>  arch/powerpc/platforms/pseries/mobility.c |    5 +++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 2c7ed31..e02ac37 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -982,7 +982,6 @@ int rtas_ibm_suspend_me(u64 handle)
>  	}
> 
>  	cpu_hotplug_disable();
> -	stop_topology_update();
> 
>  	/* Call function on all CPUs.  One of us will make the
>  	 * rtas call
> @@ -995,7 +994,6 @@ int rtas_ibm_suspend_me(u64 handle)
>  	if (atomic_read(&data.error) != 0)
>  		printk(KERN_ERR "Error doing global join\n");
> 
> -	start_topology_update();
>  	cpu_hotplug_enable();
> 
>  	/* Take down CPUs not online prior to suspend */
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b5a71ba..0ade0a1 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1518,6 +1518,10 @@ int start_topology_update(void)
>  		}
>  	}
> 
> +	pr_info("Starting topology update%s%s\n",
> +		(prrn_enabled ? " prrn_enabled" : ""),
> +		(vphn_enabled ? " vphn_enabled" : ""));
> +
>  	return rc;
>  }
> 
> @@ -1539,6 +1543,8 @@ int stop_topology_update(void)
>  		rc = del_timer_sync(&topology_timer);
>  	}
> 
> +	pr_info("Stopping topology update\n");
> +
>  	return rc;
>  }
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 2f0f512..7da222d 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -367,6 +367,8 @@ static ssize_t migration_store(struct class *class,
>  	if (rc)
>  		return rc;
> 
> +	stop_topology_update();
> +
>  	do {
>  		rc = rtas_ibm_suspend_me(streamid);
>  		if (rc == -EAGAIN)
> @@ -377,6 +379,9 @@ static ssize_t migration_store(struct class *class,
>  		return rc;
> 
>  	post_mobility_fixup();
> +
> +	start_topology_update();
> +
>  	return count;
>  }
> 
> 

