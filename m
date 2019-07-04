Return-Path: <SRS0=vYn1=VB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862CCC06510
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 03:38:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AD12064A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 03:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AD12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fNwv309NzDqc7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 13:38:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nayna@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fNtx12ZlzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2019 13:36:37 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x643W0Qt015995
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2019 23:36:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2th76ycdbu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2019 23:36:34 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nayna@linux.vnet.ibm.com>;
 Thu, 4 Jul 2019 04:36:34 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 4 Jul 2019 04:36:31 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x643aUG748366014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jul 2019 03:36:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2486112064;
 Thu,  4 Jul 2019 03:36:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C2BE112063;
 Thu,  4 Jul 2019 03:36:30 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.198.40])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  4 Jul 2019 03:36:30 +0000 (GMT)
Subject: Re: Kernel Bug/oops during boot (PowerVM LPAR w/vTPM)
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <49B804EE-726B-4EB4-9BED-116F8FB5B374@linux.vnet.ibm.com>
 <20190703131716.7e16d840@naga> <20190703231559.29d54c5c@kitsune.suse.cz>
From: Nayna <nayna@linux.vnet.ibm.com>
Date: Wed, 3 Jul 2019 23:36:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190703231559.29d54c5c@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19070403-2213-0000-0000-000003A92769
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227130; UDB=6.00646090; IPR=6.01008362; 
 MB=3.00027576; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-04 03:36:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070403-2214-0000-0000-00005F19C230
Message-Id: <b79528a7-102b-bcd2-43af-27ffa8b1c900@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-04_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040044
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
Cc: nayna@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Mimi Zohar <zohar@linux.ibm.com>, gcwilson@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sachin and Michal,


On 07/03/2019 05:15 PM, Michal Suchánek wrote:
> On Wed, 3 Jul 2019 13:17:16 +0200
> Michal Suchánek <msuchanek@suse.de> wrote:
>
>> On Wed, 3 Jul 2019 15:54:59 +0530
>> Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>>
>>> Booting mainline kernel on PowerVM LPAR with vTPM enabled results
>>> into a kernel crash.
>>>
>>> [    0.365989] BUG: Kernel NULL pointer dereference at 0x00000012
> ...
>>> [    0.366085] NIP [c00000000073dd80] tpm1_pcr_extend+0x130/0x230
>>> [    0.366090] LR [c00000000073dcd0] tpm1_pcr_extend+0x80/0x230
> ...
>> You need to revert (or fix up) commit 0b6cf6b97b7e ("tpm: pass an array
>> of tpm_extend_digest structures to tpm_pcr_extend()". At least
>> reverting it fixes the issue for me.
> FTR this is the revert on lkml https://lkml.org/lkml/2019/7/1/423
>
>


I have just now posted the fix for this to the mailing list and copied 
both of you. I would appreciate your testing and confirming that the 
patch "tpm: fixes uninitialized allocated banks for IBM vtpm driver" 
addresses this bug.

Thanks & Regards,
       - Nayna


