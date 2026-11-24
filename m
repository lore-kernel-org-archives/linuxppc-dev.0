Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA6606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YhPQP3eV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYgcZ2MQpz2xNT;
	Tue, 24 Nov 2026 22:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795519886;
	cv=none; b=LZD2EVvXf5iaBQDf+UGs+L2IskgfvjAKo3QMG8LQUwrutFlsts3dkgaaMdvwzhCMX9PmtW1LxZU5C03DFtbm5j2Nf1faZRst7M5ku5KBVsG3AgQDw3EKMiVSEfuK275YewHX6NehG4Fdsc6uBaP0m3b+46wRWQnRuW5lVhyc2Dq9ofxJcy4Tne/iGT6VBr4rE0lyyAQVbPqfl9HG2qAk5oOf1N0xf0LwND6oDeWjD8S+MWoe+6iv8Ty4O7Cpu8NzaQ5HthcH4ecKfrjt6oPpZcVW5tz2Ofm2yAQ2BDUdJ4Wnx8Dr85i0aw2LmMgsMnt2z2JYaGCA+Jms0GljK1m/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795519886; c=relaxed/relaxed;
	bh=bchnnE9POzl5YmBnyDD/UmWF64NOv7cDBQ3Ldu7Wbkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzEdTnrCs2yqQH1uuNwphKaLfOe2MiorAMqUrYbLpAFwgBHOKjVSlS8ap1MvpiPjDb5hn3fgP5FJ0a1Ib+ehGYZgDzhcy396FHJByy5FUjMbKH51r0JEc1B3vhDhCzD/SPeV1jINOIjUeMkgtMuqlA+BPjzHaid0SMnWTZL+qI+l2BaZcVUrHoxs/dl0JfNTzZn3bby//uyLlARExBGvknCt0wCM5IS9wYYM5Yy7C++wXWUOiKpvkc7CvC4fOZhyDU97HrZHNOCabOijXReu3lLnLUJN4g4FXpcXYLgs6ioeTsd5uIJWs9sWVqTjHALuiitrZ5+xabiUMcggMtQygg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YhPQP3eV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YhPQP3eV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYgcX5xdPz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 22:31:24 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4h33980098;
	Tue, 24 Nov 2026 11:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bchnnE
	9POzl5YmBnyDD/UmWF64NOv7cDBQ3Ldu7Wbkc=; b=YhPQP3eVOC3b//zEplJEa3
	dQA0Q8y7LhG+O1hhNpJ9HiO2agEA/1mD5lwCh6MftOrzFfocCUW00OJK5FbG9Dek
	BLWivEZA+wxYJDy10jbVdOAtpa9veg4kz7IOLq+ooHhcA+GT/R7aSarq9GULQbqS
	hBP9dh7kpVkNuV08DjaBETi54w0XEyqLhdBNnqT5sQXtIr6GpwR/dF79VMKCMTLz
	G2gSMJlgB/lDltRSdjoMjGbnL8XfrZNIhoJYwTWpqxgndZ0UVoq5+uXOTRmXcAUU
	2b6zjNs7xpNXR2VDC11dT2xRAfAet4d+vn23WL+qle5POxqUsh/Ngkhq/btccpEA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4evw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 11:31:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4Fg03362858;
	Tue, 24 Nov 2026 11:31:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayj30j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 11:31:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOBVEg425625332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 11:31:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB92320040;
	Tue, 24 Nov 2026 11:31:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA1C2004B;
	Tue, 24 Nov 2026 11:31:13 +0000 (GMT)
Received: from [9.123.4.64] (unknown [9.123.4.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 11:31:13 +0000 (GMT)
Message-ID: <07b4a247-6313-4124-bab1-feb84738238e@linux.ibm.com>
Date: Tue, 24 Nov 2026 17:01:12 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/powerpc/eeh: eeh-basic breaks the device hosting
 rootfs, ext4 goes read-only and the test harness crashes
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, nandinih@linux.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <9113e399-ddd0-405e-9abb-69a9785c726c@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <9113e399-ddd0-405e-9abb-69a9785c726c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MyBTYWx0ZWRfX3XhT5p5kO0yi
 8t6CesB4yHBC4i6BE1545ycSJVS7KxOVczy5epaPkZB1MHZLVe8TKrs5xsCcZOBzKmzH7JYQHs3
 dwDBmjgH2pTHafop9xXtjz0YtMfrK8s=
X-Proofpoint-GUID: V28uYCeAv5bMiPw2ESc0rLLKxq-DVgD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MyBTYWx0ZWRfX1Urck6RB/Q3A
 Bh54lG02Ett1DmPsR/mQhRo+4kH+45NN3XG9fLxTtr6a8sxthDIiSyYUUa6eIF8yr48mxqxJ3Cq
 LIu+CPu4uPDwWnqGL4MMAlXWNIOFHIRnZoxhO0tgdBxn/5dTtAPakt/QzQoLzojitAL4B9QzmP0
 SuWeBS9apjeFvg5KxPpFcvzqCXFiGETyi6SDvSa3kPoQ5MmGP7mwcLa4lXe5W/3Mwd2RgpQ7IMH
 5w2D7SEocyJdv3RlmJYaSR/Ob6W7CoglywJayy8j7jDc3TinHJ9730vKQ25wVcetLMibCabJcIu
 9XL95G9wts2J4sBLirDUhXtF1JU4Rr07W3BeyM/A5hl0ZbloXNMA4ted3G2MMsTHtnxKMPkwOIB
 gw3bHWd6oQEVAqcc0O0ZM/+J/I3b0WkNWJDjXa1J+OqopavixwHukHvGoMS7rd/pmBPTEeRgyPq
 kmtQoD6TRhrOq70QaSw==
X-Proofpoint-ORIG-GUID: V28uYCeAv5bMiPw2ESc0rLLKxq-DVgD-
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b057587 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6EctlgBVgvUV7dFz:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=iLn-Ndydp9YEVDFGA9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240043
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Venkat,

On 12/11/26 11:36 AM, Venkat Rao Bagalkote wrote:
> Hello!!!
> 
> IBM CI has hit a failure that takes down the test harness, While running 
> the powerpc EEH selftest on a bare-metal POWER system.
> 
> The selftest injects an error into the PCI device that hosts the root 
> filesystem. The filesystem goes read-only and the run dies.
> 
> [ 1112.079091] EEH: Frozen PHB#3-PE#1fd detected
> [ 1112.079905] aacraid 0003:01:00.0: aacraid: PCI error detected 2
> [ 1112.140830] I/O error, dev sdb, sector 3906906472 op 0x1:(WRITE) ...
> [ 1112.140957] Aborting journal on device sdb2-8.
> [ 1112.140977] EXT4-fs error (device sdb2) in ext4_dirty_inode:7656: IO 
> failure
> [ 1112.176664] EXT4-fs error (device sdb2): 
> ext4_journal_check_start:98: ... Detected aborted journal
> [ 1187.736385] aacraid 0003:01:00.0: aacraid: PCI error - slot reset
> [ 1217.244306] EXT4-fs (sdb2): Remounting filesystem read-only
> [ 1220.583495] aacraid 0003:01:00.0: aacraid: PCI error - resume
> 
> We need to make appropriate changes to selftest, so that it skips the 
> adapter, if rootfs is hosted on it.
> 
> 
> SetUp:
> 
> System: IBM 9006-22C (POWER9), PowerNV, bare metal
> Firmware: skiboot-v6.8-45-g8246de863
> Kernel: 7.4.0-rc2+, upstream master at 067c5c24cef2 ("Merge tag 
> 'page_alloc-for-7.4-rc2'", 2026-11-10)
> 
> 
> Issue1: Selftest should skip the adapter that host the rootfs
> 
> eeh_can_break() already skips ahci, for similar reason, but has no check 
> for a device that backs /. A friendly LLM has suggested
> 
> below change, which I tested and it works.
> 
> 0003:01:00.0, Skipped: hosts the root filesystem
> 
> Other adapters are tested as before and the run completes
> 
> diff --git a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh b/ 
> tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> index 70daa3925dcb..f9db1f9be05a 100644
> --- a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> +++ b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> @@ -62,6 +62,42 @@ eeh_test_prep() {
>       echo 5000 > /sys/kernel/debug/powerpc/eeh_max_freezes
>   }
> 
> +# Print the resolved sysfs path of a block device followed by the paths of
> +# every device stacked underneath it (dm, md, etc).
> +eeh_blk_sysfs_paths() {
> +    local sys="$1"
> +    local s
> +
> +    realpath "$sys"
> +    for s in "$sys"/slaves/* ; do
> +        if [ -e "$s" ] ; then
> +            eeh_blk_sysfs_paths "$s"
> +        fi
> +    done
> +}
> +
> +# Succeeds if the root filesystem lives on a disk behind any function 
> of the
> +# slot containing the given PCI device.
> +eeh_hosts_rootfs() {
> +    local slot="${1%.*}"
What if the PE contains multiple PCI devices that do not necessarily 
belong to the same slot?

Since EEH isolation and recovery happen at PE granularity, injecting an 
error into another device belonging to the same PE could still affect 
the device hosting the root filesystem.

Shouldn't we traverse all the devices belonging to the PE and skip error 
injection if any of them hosts the root filesystem, rather than limiting 
the check to the functions within the same slot?

> +    local majmin src sys
> +
> +    # Use the last "/" entry so an initramfs rootfs entry is ignored.
> +    majmin="$(awk '$5 == "/" { mm = $3 } END { print mm }' /proc/self/ 
> mountinfo)"
> +    src="$(awk '$5 == "/" { for (i = 6; i < NF; i++) if ($i == "-") s = 
> $(i + 2) } END { print s }' /proc/self/mountinfo)"
> +
> +    if [ -e "/sys/dev/block/$majmin" ] ; then
> +        sys="/sys/dev/block/$majmin"
> +    elif [ -b "$src" ] ; then
> +        # e.g. btrfs reports an anonymous major:minor
> +        sys="/sys/class/block/$(basename "$(realpath "$src")")"
> +    else
> +        return 1
> +    fi
> +
> +    eeh_blk_sysfs_paths "$sys" 2>/dev/null | grep -q "/${slot}\.[0-7]/"

Perhaps we could use eeh_pe_config_addr along with the PHB identity to 
identify the devices belonging to the same PE and skip the entire PE if 
any of them backs the root filesystem.

Thanks,
Narayana Murty.

> +}
> +
>   eeh_can_break() {
>       # skip bridges since we can't recover them (yet...)
>       if [ -e "/sys/bus/pci/devices/$dev/pci_bus" ] ; then
> @@ -78,6 +114,14 @@ eeh_can_break() {
>           return 1;
>       fi
> 
> +    # Breaking the device that hosts the root filesystem makes I/O fail
> +    # during recovery, which can abort the journal and leave / read-only
> +    # (and kill the test harness). Leave it alone.
> +    if eeh_hosts_rootfs "$1" ; then
> +        log "$1, Skipped: hosts the root filesystem"
> +        return 1;
> +    fi
> +
>       # Don't inject errosr into an already-frozen PE. This happens with
>       # PEs that contain multiple PCI devices (e.g. multi-function cards)
>       # and injecting new errors during the recovery process will probably
> 
> 
> 
> Issue2: Some adapters take longer time to recover.
> 
> 
> Once the rootfs device was skipped, the run completed, but with the 
> default 60 s wait three adapters were reported as Failed to recover!,
> and the summary was 3 devices failed to recover (6 tested). Checking the 
> PE state afterwards showed them healthy .
> I re-ran with EEH_MAX_WAIT=240, and all of them recovered:
> 
> Result with the 240 s limit: 0 devices failed to recover (6 tested).
> 
> BRCM/Mellonox/Intel Adapters took 78s/77s/75s respectively to recover. 
> So I think its better to increase default timeout to 120s.
> 
> diff --git a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh b/ 
> tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> index 70daa3925dcb..1f1d1c8d73bc 100644
> --- a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> +++ b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> @@ -110,13 +110,13 @@ eeh_one_dev() {
>       # is a no-op.
>       echo $dev >/sys/kernel/debug/powerpc/eeh_dev_check
> 
> -    # Default to a 60s timeout when waiting for a device to recover. This
> +    # Default to a 120s timeout when waiting for a device to recover. This
>       # is an arbitrary default which can be overridden by setting the
>       # EEH_MAX_WAIT environmental variable when required.
> 
>       # The current record holder for longest recovery time is:
> -    #  "Adaptec Series 8 12G SAS/PCIe 3" at 39 seconds
> -    max_wait=${EEH_MAX_WAIT:=60}
> +    #  "Broadcom / LSI SAS3008" at 78 seconds
> +    max_wait=${EEH_MAX_WAIT:=120}
> 
>       for i in `seq 0 ${max_wait}` ; do
>           if pe_ok $dev ; then
> 
> 
> Please let me know, if the fix for the two issues are good enough, I can 
> send a formal patch.
> 
> 
> 
> Regards,
> 
> Venkat.
> 


