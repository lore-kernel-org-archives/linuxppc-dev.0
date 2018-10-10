Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A0DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:52:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316C221470
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316C221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vg9n07z8zF1XR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:51:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vg7V1jSKzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:49:57 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AGYrGu026457
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:49:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jfg8mya-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 12:49:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 17:49:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 17:49:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AGnnGg62849160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 16:49:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78357A4040;
 Wed, 10 Oct 2018 19:49:22 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C65AA4053;
 Wed, 10 Oct 2018 19:49:22 +0100 (BST)
Received: from localhost (unknown [9.77.126.208])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 19:49:21 +0100 (BST)
Date: Wed, 10 Oct 2018 22:19:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Export maximum memory value
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
References: <153916697991.21165.5694207762066031403.stgit@aravinda>
 <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
In-Reply-To: <0c429575-93e1-0ca9-9c75-29dec1e4105c@linux.vnet.ibm.com>
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18101016-0012-0000-0000-000002B5439C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101016-0013-0000-0000-000020E99D43
Message-Id: <1539190032.dzxxjmgaua.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100161
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

Nathan Fontenot wrote:
> On 10/10/2018 05:22 AM, Aravinda Prasad wrote:
>> This patch exports the maximum possible amount of memory
>> configured on the system via /proc/powerpc/lparcfg.
>>=20
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/lparcfg.c |   13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>=20
>> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/pla=
tforms/pseries/lparcfg.c
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
>>=20
>>  #include "pseries.h"
>>=20
>> @@ -433,6 +435,16 @@ static void parse_em_data(struct seq_file *m)
>>  		seq_printf(m, "power_mode_data=3D%016lx\n", retbuf[0]);
>>  }
>>=20
>> +static void maxmem_data(struct seq_file *m)
>> +{
>> +	unsigned long maxmem =3D 0;
>> +
>> +	maxmem +=3D drmem_info->n_lmbs * drmem_info->lmb_size;
>> +	maxmem +=3D hugetlb_total_pages() * PAGE_SIZE;
>> +
>> +	seq_printf(m, "MaxMem=3D%ld\n", maxmem);
>=20
> Should this be MaxPossibleMem?
>=20
> At least for the drmem memory the value calculated is the maximum possibl=
e
> memory. I wonder if calling it MaxMem would lead users to think they have
> that much memory available to them.

That's a good point. This seems to be referred to as just 'maximum=20
memory' in the LPAR configuration as well as in the lparstat=20
documentation, but it shouldn't hurt to rename it here.

- Naveen

=

