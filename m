Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811EBC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:22:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA292086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA292086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VfWs0pxWzF13y
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:22:33 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VfTr6dfmzF12D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:20:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AGEr31004836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:20:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1kccm8c1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:20:46 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 12:20:45 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 12:20:43 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AGKgU064159830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 16:20:42 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 420A8124054;
 Wed, 10 Oct 2018 13:20:29 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEEA0124052;
 Wed, 10 Oct 2018 13:20:28 -0400 (EDT)
Received: from oc6428688403.ibm.com (unknown [9.80.235.83])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Oct 2018 13:20:28 -0400 (EDT)
Subject: Re: [PATCH] powerpc/pseries: Export maximum memory value
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <153916697991.21165.5694207762066031403.stgit@aravinda>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Oct 2018 11:20:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153916697991.21165.5694207762066031403.stgit@aravinda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101016-0060-0000-0000-000002BE857F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009854; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100688; UDB=6.00569503; IPR=6.00880737; 
 MB=3.00023698; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 16:20:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101016-0061-0000-0000-000046CC57AB
Message-Id: <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
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
Cc: naveen.n.rao@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/10/2018 05:22 AM, Aravinda Prasad wrote:
> This patch exports the maximum possible amount of memory
> configured on the system via /proc/powerpc/lparcfg.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/lparcfg.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index 7c872dc..aa82f55 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -26,6 +26,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/hugetlb.h>
>  #include <asm/lppaca.h>
>  #include <asm/hvcall.h>
>  #include <asm/firmware.h>
> @@ -36,6 +37,7 @@
>  #include <asm/vio.h>
>  #include <asm/mmu.h>
>  #include <asm/machdep.h>
> +#include <asm/drmem.h>
> 
>  #include "pseries.h"
> 
> @@ -433,6 +435,16 @@ static void parse_em_data(struct seq_file *m)
>  		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
>  }
> 
> +static void maxmem_data(struct seq_file *m)
> +{
> +	unsigned long maxmem = 0;
> +
> +	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
> +	maxmem += hugetlb_total_pages() * PAGE_SIZE;
> +
> +	seq_printf(m, "MaxMem=%ld\n", maxmem);

Should this be MaxPossibleMem?

At least for the drmem memory the value calculated is the maximum possible
memory. I wonder if calling it MaxMem would lead users to think they have
that much memory available to them.

-Nathan

> +}
> +
>  static int pseries_lparcfg_data(struct seq_file *m, void *v)
>  {
>  	int partition_potential_processors;
> @@ -491,6 +503,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
>  	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
>  #endif
>  	parse_em_data(m);
> +	maxmem_data(m);
> 
>  	return 0;
>  }
> 

