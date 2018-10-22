Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB4C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E9820853
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E9820853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dsxc4287zDr6V
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:21:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aravinda@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dsrl54lRzF36h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 21:17:11 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9MA9gkK018256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 06:17:09 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n9aegduw1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 06:17:09 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 22 Oct 2018 06:17:08 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 06:17:06 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9MAH5Oe33095926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 10:17:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFA7F112065;
 Mon, 22 Oct 2018 10:17:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FE3F112063;
 Mon, 22 Oct 2018 10:17:04 +0000 (GMT)
Received: from [9.124.35.81] (unknown [9.124.35.81])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 10:17:04 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Export maximum memory value
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <153916697991.21165.5694207762066031403.stgit@aravinda>
 <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Oct 2018 15:47:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102210-0068-0000-0000-000003514DF6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106281; UDB=6.00572880; IPR=6.00886365; 
 MB=3.00023855; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 10:17:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102210-0069-0000-0000-0000462876CA
Message-Id: <8a052961-0013-3b91-4ba0-69d98b377ff5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-21_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220091
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



On Wednesday 10 October 2018 09:50 PM, Nathan Fontenot wrote:
> On 10/10/2018 05:22 AM, Aravinda Prasad wrote:
>> This patch exports the maximum possible amount of memory
>> configured on the system via /proc/powerpc/lparcfg.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/lparcfg.c |   13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
>> index 7c872dc..aa82f55 100644
>> --- a/arch/powerpc/platforms/pseries/lparcfg.c
>> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/slab.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/hugetlb.h>
>>  #include <asm/lppaca.h>
>>  #include <asm/hvcall.h>
>>  #include <asm/firmware.h>
>> @@ -36,6 +37,7 @@
>>  #include <asm/vio.h>
>>  #include <asm/mmu.h>
>>  #include <asm/machdep.h>
>> +#include <asm/drmem.h>
>>
>>  #include "pseries.h"
>>
>> @@ -433,6 +435,16 @@ static void parse_em_data(struct seq_file *m)
>>  		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
>>  }
>>
>> +static void maxmem_data(struct seq_file *m)
>> +{
>> +	unsigned long maxmem = 0;
>> +
>> +	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
>> +	maxmem += hugetlb_total_pages() * PAGE_SIZE;
>> +
>> +	seq_printf(m, "MaxMem=%ld\n", maxmem);
> 
> Should this be MaxPossibleMem?
> 
> At least for the drmem memory the value calculated is the maximum possible
> memory. I wonder if calling it MaxMem would lead users to think they have
> that much memory available to them.

Nathan,

I feel MaxMem makes more sense because, we use "Minimum memory",
"Desired memory" and "Maximum memory" in the LPAR profile configuration
and MaxMem is in fact displaying the value of this "Maximum memory"
profile value.

So I want to keep it as "MaxMem". Let me know if you think otherwise.

Regards,
Aravinda


> 
> -Nathan
> 
>> +}
>> +
>>  static int pseries_lparcfg_data(struct seq_file *m, void *v)
>>  {
>>  	int partition_potential_processors;
>> @@ -491,6 +503,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
>>  	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
>>  #endif
>>  	parse_em_data(m);
>> +	maxmem_data(m);
>>
>>  	return 0;
>>  }
>>

-- 
Regards,
Aravinda

