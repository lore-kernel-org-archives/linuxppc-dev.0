Return-Path: <SRS0=DrE0=GJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D02C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CB623106
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CB623106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D9x3m0VbTzDqf0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Jan 2021 04:21:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=egK7x/Il; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D9x0h2nRczDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2021 04:18:42 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 106H3ar6109758; Wed, 6 Jan 2021 12:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=M/SBYHXcgvsk1w6Hu6jpEFpQcPfShH2iy/FzNLOSEP0=;
 b=egK7x/IlF/700xzdthFHC3bFAhleg+ciY6KGJ3phHMJXTlM2yU0nuRl2YtA2bXXn+gJK
 +g/eR/wCvUk+hFYl4mRTPg/E66ZKI6SFKaHDsgzqvo082Q5gCZD0aJU13ctjV2D9uGhk
 pxyVtkR+gFVIICsNr2YnTxWlBGwMCrW9bDXGcCu6Rm0vTFa9q4tjyK9NWaI7kkJJaHt3
 /dPg0tKhOMsp37keQO0XcvEpfdOZ4zMAymITgpiDlVrKawv56FPx5iTjAUccrlDrf90W
 rfEtRXo+ksmZfZYHf0JfP20xWILXVidjZWLaSS08knWEQTDCwGVJK3MeMmgbGTKqew97 zQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 35wgk41rwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Jan 2021 12:18:39 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 106H2t8Y002359;
 Wed, 6 Jan 2021 17:18:37 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 35tgf96cgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Jan 2021 17:18:37 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 106HIbgW21103012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Jan 2021 17:18:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40797AC05F;
 Wed,  6 Jan 2021 17:18:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B285AC05E;
 Wed,  6 Jan 2021 17:18:36 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.27.90])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  6 Jan 2021 17:18:35 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] ibmvfc: complete commands outside the host/queue
 lock
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20201218231916.279833-5-tyreld@linux.ibm.com>
 <20210104222422.981457-1-tyreld@linux.ibm.com>
 <yq1v9caekxl.fsf@ca-mkp.ca.oracle.com>
From: Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <861462bb-7688-f32d-1613-e1a13928abbe@linux.ibm.com>
Date: Wed, 6 Jan 2021 09:18:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <yq1v9caekxl.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-06_10:2021-01-06,
 2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060101
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
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 james.bottomley@hansenpartnership.com, Brian King <brking@linux.vnet.ibm.com>,
 brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/5/21 8:42 PM, Martin K. Petersen wrote:
> 
> Tyrel,
> 
>> Drain the command queue and place all commands on a completion list.
>> Perform command completion on that list outside the host/queue locks.
>> Further, move purged command compeletions outside the host_lock as well.
> 
> Please resubmit entire series instead of amending individual patches.
> 
> thanks!
> 

No problem. I wasn't sure since it was simply adding a "static" keyword. I'll
send a v2 out today.

-Tyrel
