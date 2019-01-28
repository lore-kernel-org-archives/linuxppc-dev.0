Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCDBC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:36:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EBB2148E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EBB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p9dk5B7BzDqJY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 00:36:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p9bV1pS9zDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 00:34:45 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SDTTng081199
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:34:44 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qa1bjm3by-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:34:43 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 28 Jan 2019 13:34:41 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 13:34:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SDYctj1180076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 13:34:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBE2311C052;
 Mon, 28 Jan 2019 13:34:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BD0611C04A;
 Mon, 28 Jan 2019 13:34:38 +0000 (GMT)
Received: from [9.145.43.137] (unknown [9.145.43.137])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 13:34:38 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] cxl: Add support for disabling CAPP when
 unloading CXL
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20190125051131.29351-1-vaibhav@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 28 Jan 2019 14:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125051131.29351-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012813-0008-0000-0000-000002B6FBDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012813-0009-0000-0000-000022233A93
Message-Id: <91b238a5-03ef-b3fb-8036-4696a6c84233@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280105
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Vaibhav,

I think there's value in there, as I'm hearing Mellanox would prefer to 
start from a "clean" state, as in pci mode, when they load their driver 
after a card FW update.

However, I'm pretty reluctant to make it the default behaviour. It's not 
like we haven't had our share of problems on reset before :-) 
Furthermore, for non-mlx5 case, we don't really have a reason for this.
I'm thinking we could activate it through a per-adapter property, on 
/sys. See comment in one of the patches.

   Fred


Le 25/01/2019 à 06:11, Vaibhav Jain a écrit :
> Recent updates to OPAL have implemented necessary infrastructure [1] to disable
> CAPP and switch PHB back to PCIE mode during fast reset. This small patch-set
> uses the same OPAL infrastructure to force disable of CAPP when CXL module is
> unloaded via rmmod.
> 
> References:
> [1]: https://lists.ozlabs.org/pipermail/skiboot/2019-January/013063.html
> 
> Vaibhav Jain (2):
>    powerpc/powernv: Add support for CXL mode switch that need PHB reset
>    cxl: Force a CAPP reset when unloading CXL module
> 
>   arch/powerpc/platforms/powernv/pci-cxl.c | 71 +++++++++++++++++++++---
>   drivers/misc/cxl/cxl.h                   |  1 +
>   drivers/misc/cxl/main.c                  |  3 +
>   drivers/misc/cxl/pci.c                   | 25 ++++++++-
>   4 files changed, 91 insertions(+), 9 deletions(-)
> 

