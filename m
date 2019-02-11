Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4537EC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01CC222AA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01CC222AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynG64nMHzDqBg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:49:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymxx5cqmzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:35:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BDTV9S000768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 08:35:31 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qk81eea6h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 08:35:31 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 11 Feb 2019 13:35:29 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Feb 2019 13:35:01 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1BDZ0sV23330918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 13:35:00 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41B322805A;
 Mon, 11 Feb 2019 13:35:00 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14A3C28059;
 Mon, 11 Feb 2019 13:34:59 +0000 (GMT)
Received: from [9.85.73.133] (unknown [9.85.73.133])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 11 Feb 2019 13:34:58 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] drivers/mtd: Use mtd->name when registering nvmem
 device
To: Boris Brezillon <boris.brezillon@collabora.com>
References: <20190208151419.1800-1-aneesh.kumar@linux.ibm.com>
 <20190210135552.65f532bb@collabora.com>
 <2f3cae2b-32d2-0651-29ef-2359221de4ef@linux.ibm.com>
 <20190211121628.30c22370@collabora.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 11 Feb 2019 19:04:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211121628.30c22370@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021113-2213-0000-0000-0000034E09E3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010577; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159515; UDB=6.00605101; IPR=6.00940061; 
 MB=3.00025525; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-11 13:35:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021113-2214-0000-0000-00005D515212
Message-Id: <c7885c03-6cd5-d6ba-b2f4-63e2d1f03cd4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110106
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
Cc: linuxppc-dev@lists.ozlabs.org, Alban Bedel <albeu@free.fr>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/11/19 4:46 PM, Boris Brezillon wrote:
> On Mon, 11 Feb 2019 16:26:38 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> On 2/10/19 6:25 PM, Boris Brezillon wrote:
>>> Hello Aneesh,
>>>
>>> On Fri,  8 Feb 2019 20:44:18 +0530
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>    
>>>> With this patch, we use the mtd->name instead of concatenating the name with '0'
>>>>
>>>> Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>
>>> You forgot to Cc the MTD ML and maintainers. Can you please send a new
>>> version?
>>>    
>>
>> linux-mtd list is on CC: Is that not sufficient?
> 
> Not in your original email, I added it in my reply.
> 


Sorry about that. I will now resend with linux-mtd on CC: I missed that 
earlier.

-aneesh

