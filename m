Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F6C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:26:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FD02184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FD02184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4491J36nDdzDqLV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:26:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4491GG6M7qzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:25:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4491GG0bwkz8vsS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:25:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4491GG0FRFz9s5c; Thu, 28 Feb 2019 16:25:10 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 4491GF3dL4z9s5R
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 16:25:09 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S5JRPp141382
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 00:25:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qx61qybx4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2019 00:25:06 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 28 Feb 2019 05:25:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 05:25:03 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S5P2a619595278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Feb 2019 05:25:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 229734204B;
 Thu, 28 Feb 2019 05:25:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33A9642049;
 Thu, 28 Feb 2019 05:25:00 +0000 (GMT)
Received: from [9.85.71.224] (unknown [9.85.71.224])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 05:24:59 +0000 (GMT)
Subject: Re: [PATCH 00/18] Add FADump support on PowerNV platform
To: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
 <1551240037.jlygjm8fzm.astroid@bobo.none>
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Thu, 28 Feb 2019 10:54:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551240037.jlygjm8fzm.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19022805-0016-0000-0000-0000025BD6E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022805-0017-0000-0000-000032B641E9
Message-Id: <a44bc048-f0db-40a7-b9ea-4105587efd95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280036
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

Hi Nick,


On 27/02/19 9:48 AM, Nicholas Piggin wrote:
> Hari Bathini's on February 22, 2019 3:35 am:
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
>> ---
>>
>> Hari Bathini (18):
>>        powerpc/fadump: move internal fadump code to a new file
>>        powerpc/fadump: Improve fadump documentation
>>        pseries/fadump: move out platform specific support from generic code
>>        powerpc/fadump: use FADump instead of fadump for how it is pronounced
>>        powerpc/fadump: enable fadump support on OPAL based POWER platform
>>        powerpc/fadump: Update documentation about OPAL platform support
>>        powerpc/fadump: consider reserved ranges while reserving memory
>>        powerpc/fadump: consider reserved ranges while releasing memory
>>        powernv/fadump: process architected register state data provided by firmware
>>        powernv/fadump: add support to preserve crash data on FADUMP disabled kernel
>>        powerpc/fadump: update documentation about CONFIG_PRESERVE_FA_DUMP
>>        powerpc/powernv: export /proc/opalcore for analysing opal crashes
>>        powernv/fadump: Skip processing /proc/vmcore when only OPAL core exists
>>        powernv/opalcore: provide an option to invalidate /proc/opalcore file
>>        powernv/fadump: consider f/w load area
>>        powernv/fadump: update documentation about option to release opalcore
>>        powernv/fadump: use backup area to map PIR to logical CPUs
> The need to map firmware identifiers like PIR to Linux numbering comes
> up in a few places, OPAL msglog, pdbg debugger, etc. I wonder if we
> could have Linux register its logical CPU numbers with OPAL after it
> boots. Would that help with your usage?

The logical to PIR map of crashing kernel is needed in the capture kernel
(the kernel booted after crash to save the dump) that processes the register
data provided by f/w. Not sure if the logical to PIR map would be guaranteed
to be the same for both the crashing kernel and capture kernel.

Actually, I don't see any value-add in using the logical to PIR map in processing
the register data provided by f/w. pSeries isn't doing that and has been reliable.
Intention was to get inputs from others on whether it is worth it..

>>        powerpc/fadump: Update documentation about backup area support
>>
>>
>>   Documentation/powerpc/firmware-assisted-dump.txt |  208 ++--
>>   arch/powerpc/Kconfig                             |   23
>>   arch/powerpc/include/asm/fadump.h                |  190 ---
>>   arch/powerpc/include/asm/opal-api.h              |   58 +
>>   arch/powerpc/include/asm/opal.h                  |    1
>>   arch/powerpc/kernel/Makefile                     |    6
>>   arch/powerpc/kernel/fadump.c                     | 1199 ++++++++--------------
>>   arch/powerpc/kernel/fadump_internal.c            |  297 +++++
>>   arch/powerpc/kernel/fadump_internal.h            |  250 +++++
> I don't have much knowledge of fadump code, so I'll nitpick instead :P
>
> Why are you calling it fadump_internal, what's internal about it? You
> have the framework for the ops table etc here, which makes the platform
> code have to #include "../kernel/fadump_internal.h", and suggests it's
> not so internal. Seems like it would be fine just to go in
> include/asm/fadump.h and kernel fadump.c?

Intention was to use that file to put common code used by platform specific code
on both pSeries & PowerNV. How about fadump_common instead of fadump_internal
to put that in perspective?

>
>>   arch/powerpc/kernel/prom.c                       |    4
>>   arch/powerpc/platforms/powernv/Makefile          |    3
>>   arch/powerpc/platforms/powernv/opal-core.c       |  602 +++++++++++
>>   arch/powerpc/platforms/powernv/opal-fadump.c     |  670 ++++++++++++
>>   arch/powerpc/platforms/powernv/opal-fadump.h     |  116 ++
>>   arch/powerpc/platforms/powernv/opal-wrappers.S   |    1
>>   arch/powerpc/platforms/pseries/Makefile          |    1
>>   arch/powerpc/platforms/pseries/pseries_fadump.c  |  535 ++++++++++
>>   arch/powerpc/platforms/pseries/pseries_fadump.h  |   96 ++
> These hopefully could just be called pseries/fadump.[ch]? Or maybe
> rtas-fadump if you want to be like powernv.

I was trying to mimic the naming convention of other files in
dir arch/powerpc/platforms/pseries. Fine with rtas-fadump as well..

Thanks
Hari

