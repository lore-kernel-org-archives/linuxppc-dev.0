Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48214C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 06:03:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63742087D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 06:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63742087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TmqY5gcdzF3MJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 17:03:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TmnM6w9QzF3LF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 17:01:11 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w995xMoj116492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Oct 2018 02:01:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n0juvy5m5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 02:01:08 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 07:01:07 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Oct 2018 07:01:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w996137h4653436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Oct 2018 06:01:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D232E4C04A;
 Tue,  9 Oct 2018 09:00:40 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41EA44C059;
 Tue,  9 Oct 2018 09:00:40 +0100 (BST)
Received: from [9.193.12.96] (unknown [9.193.12.96])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Oct 2018 09:00:40 +0100 (BST)
Subject: Re: [PATCH] powerpc/perf: Quiet PMU registration message
To: Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>
References: <20181009055444.20317-1-joel@jms.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 9 Oct 2018 11:31:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009055444.20317-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100906-0008-0000-0000-0000027CCFFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100906-0009-0000-0000-000021E60986
Message-Id: <4e599d64-53dd-fcc0-39ca-2cb7bdd9134f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090063
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



On Tuesday 09 October 2018 11:24 AM, Joel Stanley wrote:
> On a Power9 box we get a few screens full of these on boot. Drop
> them to pr_debug.
>
> [    5.993645] nest_centaur6_imc performance monitor hardware support registered
> [    5.993728] nest_centaur7_imc performance monitor hardware support registered
> [    5.996510] core_imc performance monitor hardware support registered
> [    5.996569] nest_mba0_imc performance monitor hardware support registered
> [    5.996631] nest_mba1_imc performance monitor hardware support registered
> [    5.996685] nest_mba2_imc performance monitor hardware support registered
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   arch/powerpc/perf/core-book3s.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 81f8a0c838ae..a01c521694e8 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2249,8 +2249,8 @@ int register_power_pmu(struct power_pmu *pmu)
>   		return -EBUSY;		/* something's already registered */
>
>   	ppmu = pmu;
> -	pr_info("%s performance monitor hardware support registered\n",
> -		pmu->name);
> +	pr_debug("%s performance monitor hardware support registered\n",
> +		 pmu->name);

We should have this message since this is for CPU PMU.
But we can imc once. Something like this


diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b12a0..6954636b16d1 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1392,7 +1392,7 @@ int init_imc_pmu(struct device_node *parent, 
struct imc_pmu *pmu_ptr, int pmu_id
      if (ret)
          goto err_free_cpuhp_mem;

-    pr_info("%s performance monitor hardware support registered\n",
+    pr_debug("%s performance monitor hardware support registered\n",
                              pmu_ptr->pmu.name);

      return 0;


Maddy

>   	power_pmu.attr_groups = ppmu->attr_groups;
>

