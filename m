Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8883BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 11:08:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88E22084F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 11:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88E22084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ND1d5fy5zDqM3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 22:08:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=srikar@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NCzd6KpMzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 22:06:21 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2IB5V0K019344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 07:06:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2raa2j0amb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 07:06:18 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Mon, 18 Mar 2019 11:06:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 18 Mar 2019 11:06:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2IB6Ej135455214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Mar 2019 11:06:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22AB811C05B;
 Mon, 18 Mar 2019 11:06:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2517B11C04C;
 Mon, 18 Mar 2019 11:06:11 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 18 Mar 2019 11:06:10 +0000 (GMT)
Date: Mon, 18 Mar 2019 16:36:10 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC v3] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
References: <20190304195952.16879-1-lvivier@redhat.com>
 <77b142fe-0886-1510-28bd-d432ea2c796a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <77b142fe-0886-1510-28bd-d432ea2c796a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19031811-0028-0000-0000-0000035561FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031811-0029-0000-0000-00002413F9B0
Message-Id: <20190318110610.GB4450@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-18_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180085
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Laurent Vivier <lvivier@redhat.com> [2019-03-15 12:12:45]:

> 
> Another way to avoid the nodes overlapping for the offline nodes at
> startup is to ensure the default values don't define a distance that
> merge all offline nodes into node 0.
> 
> A powerpc specific patch can workaround the kernel crash by doing this:
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 87f0dd0..3ba29bb 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -623,6 +623,7 @@ static int __init parse_numa_properties(void)
>         struct device_node *memory;
>         int default_nid = 0;
>         unsigned long i;
> +       int nid, dist;
> 
>         if (numa_enabled == 0) {
>                 printk(KERN_WARNING "NUMA disabled by user\n");
> @@ -636,6 +637,10 @@ static int __init parse_numa_properties(void)
> 
>         dbg("NUMA associativity depth for CPU/Memory: %d\n",
> min_common_depth);
> 
> +       for (nid = 0; nid < MAX_NUMNODES; nid ++)
> +               for (dist = 0; dist < MAX_DISTANCE_REF_POINTS; dist++)
> +                       distance_lookup_table[nid][dist] = nid;
> +

The only reason, this would have worked in the specific case, is because we
are overriding the distance_lookup_table with a unique distance.
So node_distance for any other node other than itself will return max
distance which is 40 in this case. (since distance_ref_points_depth is 2)

I am not sure if  this will work if the node distance between the two nodes
happens to be 20.

>         /*
>          * Even though we connect cpus to numa domains later in SMP
>          * init, we need to know the node ids now. This is because
> 

-- 
Thanks and Regards
Srikar Dronamraju

