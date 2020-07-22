Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2383EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 03:16:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1D320684
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 03:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1D320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBLG315X0zDqpB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBLD00WPDzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 13:14:23 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06M32253141481; Tue, 21 Jul 2020 23:14:17 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d91vsj9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 23:14:16 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M39Qmm018654;
 Wed, 22 Jul 2020 03:14:16 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 32brq98hw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 03:14:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06M3EEdj55116266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2020 03:14:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE3A4124053;
 Wed, 22 Jul 2020 03:14:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF067124052;
 Wed, 22 Jul 2020 03:14:14 +0000 (GMT)
Received: from localhost (unknown [9.160.116.141])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2020 03:14:14 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/numa: Limit possible nodes to within
 num_possible_nodes
In-Reply-To: <20200715120534.3673-1-srikar@linux.vnet.ibm.com>
References: <871rljfet9.fsf@linux.ibm.com>
 <20200715120534.3673-1-srikar@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2020 22:14:14 -0500
Message-ID: <87o8o81bsp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_01:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220015
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> MAX_NUMNODES is a theoretical maximum number of nodes thats is supported
> by the kernel. Device tree properties exposes the number of possible
> nodes on the current platform. The kernel would detected this and would
> use it for most of its resource allocations.  If the platform now
> increases the nodes to over what was already exposed, then it may lead
> to inconsistencies. Hence limit it to the already exposed nodes.
>
> Suggested-by: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: Michael Ellerman <michaele@au1.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 8ec7ff05ae47..a2c5fe0d0cad 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -221,7 +221,7 @@ static void initialize_distance_lookup_table(int nid,
>  	}
>  }
>  
> -/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
> +/* Returns nid in the range [0..num_possible_nodes()-1], or -1 if no useful numa
>   * info is found.
>   */
>  static int associativity_to_nid(const __be32 *associativity)
> @@ -235,7 +235,7 @@ static int associativity_to_nid(const __be32 *associativity)
>  		nid = of_read_number(&associativity[min_common_depth], 1);
>  
>  	/* POWER4 LPAR uses 0xffff as invalid node */
> -	if (nid == 0xffff || nid >= MAX_NUMNODES)
> +	if (nid == 0xffff || nid >= num_possible_nodes())
>  		nid = NUMA_NO_NODE;
>  
>  	if (nid > 0 &&
> @@ -448,7 +448,7 @@ static int of_drconf_to_nid_single(struct drmem_lmb *lmb)
>  		index = lmb->aa_index * aa.array_sz + min_common_depth - 1;
>  		nid = of_read_number(&aa.arrays[index], 1);
>  
> -		if (nid == 0xffff || nid >= MAX_NUMNODES)
> +		if (nid == 0xffff || nid >= num_possible_nodes())
>  			nid = default_nid;
>  
>  		if (nid > 0) {

Yes, looks fine to me.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
