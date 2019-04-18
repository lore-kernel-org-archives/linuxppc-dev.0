Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B70C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 03:49:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD98214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 03:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD98214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l4pv1CLLzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l4n45T5yzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 13:47:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3I3fjO6069066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:47:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rxegqx10j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:47:32 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 18 Apr 2019 04:47:31 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Apr 2019 04:47:27 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3I3lQ9w36241604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2019 03:47:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A1A7AE05F;
 Thu, 18 Apr 2019 03:47:26 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69692AE05C;
 Thu, 18 Apr 2019 03:47:25 +0000 (GMT)
Received: from [9.102.0.54] (unknown [9.102.0.54])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Apr 2019 03:47:25 +0000 (GMT)
Subject: Re: [PATCH v4 2/8] powerpc/mm/hash64: Map all the kernel regions in
 the same 0xc range
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
References: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
 <20190417125920.785-3-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 18 Apr 2019 09:17:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417125920.785-3-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041803-0068-0000-0000-000003B6E0EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010947; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190664; UDB=6.00623947; IPR=6.00971460; 
 MB=3.00026493; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-18 03:47:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041803-0069-0000-0000-00004833B107
Message-Id: <52d533ea-b9c4-e0c8-d7eb-719d1b05028a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-18_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180022
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

On 4/17/19 6:29 PM, Aneesh Kumar K.V wrote:
> This patch maps vmalloc, IO and vmemap regions in the 0xc address range
> instead of the current 0xd and 0xf range. This brings the mapping closer
> to radix translation mode.
> 
> With hash 64K page size each of this region is 512TB whereas with 4K config
> we are limited by the max page table range of 64TB and hence there regions
> are of 16TB size.
> 
> The kernel mapping is now:
> 
>   On 4K hash
> 
>       kernel_region_map_size = 16TB
>       kernel vmalloc start   = 0xc000100000000000
>       kernel IO start        = 0xc000200000000000
>       kernel vmemmap start   = 0xc000300000000000
> 
> 64K hash, 64K radix and 4k radix:
> 
>       kernel_region_map_size = 512TB
>       kernel vmalloc start   = 0xc008000000000000
>       kernel IO start        = 0xc00a000000000000
>       kernel vmemmap start   = 0xc00c000000000000

I missed this when sending out the patch.

diff --git a/arch/powerpc/mm/pgtable-radix.c 
b/arch/powerpc/mm/pgtable-radix.c
index 263c3ff662c3..30fc0909f1d8 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -136,7 +136,7 @@ static int __map_kernel_page(unsigned long ea, 
unsigned long pa,
         BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);

  #ifdef CONFIG_PPC_64K_PAGES
-       BUILD_BUG_ON(RADIX_KERN_MAP_SIZE != MAX_EA_BITS_PER_CONTEXT);
+       BUILD_BUG_ON(RADIX_KERN_MAP_SIZE != (1UL << 
MAX_EA_BITS_PER_CONTEXT));
  #endif

         if (unlikely(!slab_is_available()))



