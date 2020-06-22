Return-Path: <SRS0=kptR=AD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28980C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 13:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3F0206D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 13:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3F0206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49r9BX45vPzDqY1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 23:25:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49r98C4dPyzDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 23:23:07 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05MD2poG108523
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 09:23:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31sbcsk466-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 09:23:04 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MD2bsX107053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 09:23:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31sbcsk45y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 09:23:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MDJY3n017504;
 Mon, 22 Jun 2020 13:23:03 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 31sa38kraw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 13:23:03 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05MDN23I16319486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 13:23:02 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD2E0AE060;
 Mon, 22 Jun 2020 13:23:02 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91AD5AE064;
 Mon, 22 Jun 2020 13:23:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.79.210.147])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2020 13:23:00 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v0 3/5] powerpc/mm/radix: Fix PTE/PMD fragment count
 for early page table mappings
In-Reply-To: <20200406034925.22586-4-bharata@linux.ibm.com>
References: <20200406034925.22586-1-bharata@linux.ibm.com>
 <20200406034925.22586-4-bharata@linux.ibm.com>
Date: Mon, 22 Jun 2020 18:52:58 +0530
Message-ID: <874kr344lp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-22_04:2020-06-22,
 2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=985 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220094
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
Cc: leonardo@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


....

 @@ -71,8 +135,8 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
>  
>  	pgdp = pgd_offset_k(ea);
>  	if (pgd_none(*pgdp)) {
> -		pudp = early_alloc_pgtable(PUD_TABLE_SIZE, nid,
> -						region_start, region_end);
> +		pudp = early_alloc_pgtable(PAGE_SIZE, nid, region_start,
> +					   region_end);
>  		pgd_populate(&init_mm, pgdp, pudp);


Add a comment here explaining why we are using PAGE_SIZE instead of the
required PUD_TABLE_SIZE.

>  	}
>  	pudp = pud_offset(pgdp, ea);
> @@ -81,8 +145,8 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
>  		goto set_the_pte;
>  	}
>  	if (pud_none(*pudp)) {
> -		pmdp = early_alloc_pgtable(PMD_TABLE_SIZE, nid,
> -						region_start, region_end);
> +		pmdp = early_alloc_pgtable(PAGE_SIZE, nid, region_start,
> +					   region_end);
>  		pud_populate(&init_mm, pudp, pmdp);
>  	}
>  	pmdp = pmd_offset(pudp, ea);


-aneesh
