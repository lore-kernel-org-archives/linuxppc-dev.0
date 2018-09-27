Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92716C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:33:33 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA01E2170B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA01E2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lhjj2GdTzF38H
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:33:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lhgg0bsvzF37b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 03:31:42 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8RHTfYI018311
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:31:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ms2amv1y4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:31:40 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 27 Sep 2018 13:31:39 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 27 Sep 2018 13:31:36 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8RHVZ4Y27984048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Sep 2018 17:31:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C97BAE05F;
 Thu, 27 Sep 2018 13:30:02 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA9FDAE064;
 Thu, 27 Sep 2018 13:30:01 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.41.100.111])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 27 Sep 2018 13:30:01 -0400 (EDT)
Subject: Re: [PATCH] powerpc/rtas: Fix a potential race between CPU-Offline &
 Migration
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1538067112-11493-1-git-send-email-ego@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 27 Sep 2018 12:31:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538067112-11493-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092717-0040-0000-0000-000004776135
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009782; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094487; UDB=6.00565773; IPR=6.00874522; 
 MB=3.00023531; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 17:31:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092717-0041-0000-0000-0000087F67E2
Message-Id: <fa97b7f0-0cef-fc47-6566-216e399ac52a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-09-27_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270163
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927173134.Yr5bmrkxRxaMuPapcsKRLsiI3ztc6elgaJ_m4fZTlXI@z>

On 09/27/2018 11:51 AM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Live Partition Migrations require all the present CPUs to execute the
> H_JOIN call, and hence rtas_ibm_suspend_me() onlines any offline CPUs
> before initiating the migration for this purpose.
> 
> The commit 85a88cabad57
> ("powerpc/pseries: Disable CPU hotplug across migrations")
> disables any CPU-hotplug operations once all the offline CPUs are
> brought online to prevent any further state change. Once the
> CPU-Hotplug operation is disabled, the code assumes that all the CPUs
> are online.
> 
> However, there is a minor window in rtas_ibm_suspend_me() between
> onlining the offline CPUs and disabling CPU-Hotplug when a concurrent
> CPU-offline operations initiated by the userspace can succeed thereby
> nullifying the the aformentioned assumption. In this unlikely case
> these offlined CPUs will not call H_JOIN, resulting in a system hang.
> 
> Fix this by verifying that all the present CPUs are actually online
> after CPU-Hotplug has been disabled, failing which we return from
> rtas_ibm_suspend_me() with -EBUSY.

Would we also want to havr the ability to re-try onlining all of the cpus
before failing the migration?

This would involve a bigger code change as the current code to online all
CPUs would work in its current form.

-Nathan

> 
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 2c7ed31..27f6fd3 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -982,6 +982,16 @@ int rtas_ibm_suspend_me(u64 handle)
>  	}
> 
>  	cpu_hotplug_disable();
> +
> +	/* Check if we raced with a CPU-Offline Operation */
> +	if (unlikely(!cpumask_equal(cpu_present_mask, cpu_online_mask))) {
> +		pr_err("%s: Raced against a concurrent CPU-Offline\n",
> +		       __func__);
> +		atomic_set(&data.error, -EBUSY);
> +		cpu_hotplug_enable();
> +		goto out;
> +	}
> +
>  	stop_topology_update();
> 
>  	/* Call function on all CPUs.  One of us will make the
> 

