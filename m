Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2DC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B067020881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B067020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z6Yv6HNZzF3WS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:36:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z6Wg0D2bzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 18:34:22 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9G7YJW7067103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 03:34:21 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n56qqtb52-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 03:34:19 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 16 Oct 2018 01:33:44 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 01:33:42 -0600
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9G7Xfik52625634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 00:33:41 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F2ABC6057;
 Tue, 16 Oct 2018 07:33:41 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3310C6055;
 Tue, 16 Oct 2018 07:33:38 +0000 (GMT)
Received: from [9.85.71.130] (unknown [9.85.71.130])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Oct 2018 07:33:38 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Export maximum memory value
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <153916697991.21165.5694207762066031403.stgit@aravinda>
 <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
 <1539190032.dzxxjmgaua.naveen@linux.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 16 Oct 2018 13:03:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1539190032.dzxxjmgaua.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101607-0016-0000-0000-000009431900
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009884; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103386; UDB=6.00571125; IPR=6.00883438; 
 MB=3.00023774; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-16 07:33:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101607-0017-0000-0000-000040B8C9C4
Message-Id: <3b851bf0-7938-51e4-88c6-d2ce0e0b3d00@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160068
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Wednesday 10 October 2018 10:19 PM, Naveen N. Rao wrote:
> Nathan Fontenot wrote:
>> On 10/10/2018 05:22 AM, Aravinda Prasad wrote:
>>> This patch exports the maximum possible amount of memory
>>> configured on the system via /proc/powerpc/lparcfg.
>>>
>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/lparcfg.c |   13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c
>>> b/arch/powerpc/platforms/pseries/lparcfg.c
>>> index 7c872dc..aa82f55 100644
>>> --- a/arch/powerpc/platforms/pseries/lparcfg.c
>>> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/seq_file.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/uaccess.h>
>>> +#include <linux/hugetlb.h>
>>>  #include <asm/lppaca.h>
>>>  #include <asm/hvcall.h>
>>>  #include <asm/firmware.h>
>>> @@ -36,6 +37,7 @@
>>>  #include <asm/vio.h>
>>>  #include <asm/mmu.h>
>>>  #include <asm/machdep.h>
>>> +#include <asm/drmem.h>
>>>
>>>  #include "pseries.h"
>>>
>>> @@ -433,6 +435,16 @@ static void parse_em_data(struct seq_file *m)
>>>          seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
>>>  }
>>>
>>> +static void maxmem_data(struct seq_file *m)
>>> +{
>>> +    unsigned long maxmem = 0;
>>> +
>>> +    maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
>>> +    maxmem += hugetlb_total_pages() * PAGE_SIZE;
>>> +
>>> +    seq_printf(m, "MaxMem=%ld\n", maxmem);
>>
>> Should this be MaxPossibleMem?
>>
>> At least for the drmem memory the value calculated is the maximum
>> possible
>> memory. I wonder if calling it MaxMem would lead users to think they have
>> that much memory available to them.
> 
> That's a good point. This seems to be referred to as just 'maximum
> memory' in the LPAR configuration as well as in the lparstat
> documentation, but it shouldn't hurt to rename it here.

As Naveen mentioned, I am using the term referred in the LPAR
configuration. But, I can rename it.

Regards,
Aravinda

> 
> - Naveen
> 

-- 
Regards,
Aravinda

