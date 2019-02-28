Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EEC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:03:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAC22171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAC22171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4490nb4tBMzDqB4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:03:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4490ls5YbkzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:02:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4490ls41F5z8t60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:02:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4490ls3f4Fz9s9T; Thu, 28 Feb 2019 16:02:17 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4490lr4Mm3z9s47
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 16:02:15 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S4xBPX029401
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 00:02:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qx4pg9vkf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 00:02:12 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 28 Feb 2019 05:02:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 05:02:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S525qq52035596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Feb 2019 05:02:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB5744204C;
 Thu, 28 Feb 2019 05:02:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04FAA42041;
 Thu, 28 Feb 2019 05:02:04 +0000 (GMT)
Received: from [9.85.71.224] (unknown [9.85.71.224])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 05:02:03 +0000 (GMT)
Subject: Re: [PATCH 00/18] Add FADump support on PowerNV platform
To: Daniel Axtens <dja@axtens.net>,
 Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
 <877edlaola.fsf@linkitivity.dja.id.au>
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Thu, 28 Feb 2019 10:32:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <877edlaola.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19022805-0016-0000-0000-0000025BD52A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022805-0017-0000-0000-000032B6402A
Message-Id: <df2f1198-ecfd-be2a-c947-bf469fcb8981@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280033
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


On 27/02/19 9:07 AM, Daniel Axtens wrote:
> Hi Hari,


Hi Daniel,


>> Firmware-Assisted Dump (FADump) is currently supported only on pseries
>> platform. This patch series adds support for powernv platform too.
>>
>> The first and third patches refactor the FADump code to make use of common
>> code across multiple platforms. The fifth patch adds basic FADump support
>> for powernv platform. Patches seven & eight honour reserved-ranges DT node
>> while reserving/releasing memory used by FADump. The next patch processes
>> CPU state data provided by firmware to create and append core notes to the
>> ELF core file. The tenth patch adds support for preserving crash data for
>> subsequent boots (useful in cases like petitboot). Patch twelve provides
>> support to export opalcore. This is to make debugging of failures in OPAL
>> code easier. The subsequent patch ensures vmcore processing is skipped
>> when only OPAL core is exported by f/w. The next patch provides option to
>> release the kernel memory used to export opalcore. Patch seventeen adds
>> backup area (an area populated before crash and used in the capture kernel
>> to setup vmcore file robustly) support on PowerNV platform. The remaining
>> patches update Firmware-Assisted Dump documentation appropriately.
>>
>> Note that the quantam of increase in robustness due to patch seventeen may
>> not be worth breaking backward compatibility for older kernel versions.
>> Would like to hear thoughts from others on it.
>>
>> The patch series is tested with the latest firmware plus the below skiboot
>> changes for MPIPL support:
>>
>>      https://patchwork.ozlabs.org/project/skiboot/list/?series=78497
>>      ("MPIPL support")
>>
> If I want to test this, is there some userspace tooling that will
> extract a fadump from a rebooted system and allow me to examine it as I
> would with a kdump (e.g. with crash)?  I did look at
> Documentation/powerpc/firmware-assisted-dump.txt but it seems to only
> cover the kernel layer.

This patches export two dump files: /proc/vmcore (kernel), /proc/opalcore (OPAL).
If you are only interested in kernel dump, then passing fadump=on to the kernel
and enabling/starting kdump-tools/kdump service, shipped with distro, would ensure
dump is captured to /var/crash dir and rebooted but please be aware that the
script would not copy /proc/opalcore to disk yet. Need to update scripts once this
changes make it upstream..

Thanks
Hari

