Return-Path: <linuxppc-dev+bounces-19429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135B0EDB7ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 10:26:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqj5h5CTTz2yZ3;
	Tue, 07 Apr 2026 20:26:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775557560;
	cv=none; b=k4cjzGAAeI8dqAp3hZ/QQdQ7wKUAnx1BYMivHybJ4YGQ1W73vmSgJpzw6QZilMjXgpL1RbkePzPi2lW8gQH287O7z1rZgElZjs2k5yRHVoaxlbibIMu4prFDZL8rlACwN1Kip7bfitvTQhNxXfPwAtVA5Fu6MFKsTVfFnJ6hX5mnFHDYI7KQefHqJWZSlJXoQsIRNAPw66gzhRjsPcKbPnvwH8PPQcP1ORZrCj5x5J5SeuMznfOc1/scqcj+jwzBFBBwd2EUPwhVfbOSTXSXSaHH7b3DOXvCi3cs9WKCzrMc2zP29Dh2YPD2t8wR5dI4j2mIdE7cDdd0LM5fV3arXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775557560; c=relaxed/relaxed;
	bh=bfupogbSrvICbNA4Xn2CBYXq7EonCBIRKJtB0E8oOa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNh3Sxor0RRxI6rNYuNrxZnRj5A9L6z3ekKHhhjCa9b40prFDlXBK70sG0XBxPElvB/DvgnSnKKCd2k3P5VJ1Q/2mB7WAqU25zIhY+rgZZRF0xqsZgmN7AjG5BjjgPsjLYOsTN0F75km1ZNNBVP9vB8ZaW6zOEYkw9xUOl+kBuZ6ou17RRNvl13taPe4jIuttw0b9STt/+qMaNGYokA9pTMdOH1ZhwpjoW9o6TFJfARqYEAeXaeH6A0LnosK+R+wRLgBl3RRuPiob8v4xmhwgVbW1I5i/OkCPpMyMrx2OWnRz8h6g21cW5nXOl4jPO3UJOi40hYzoUca/Bcot7PwYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D5Ld5yEn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D5Ld5yEn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqj5g5YHvz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 20:25:59 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlkNL2297413;
	Tue, 7 Apr 2026 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bfupog
	bSrvICbNA4Xn2CBYXq7EonCBIRKJtB0E8oOa4=; b=D5Ld5yEn4xDbQAbCnJvArQ
	trAJUFHqwr93aySkpGbOmwvULi1nQzOxmEz5yWXew7XGYBuetlP91eTSLo+1mU0b
	/zA0qlB3e9tjuOpPJfmOuYotU5FD8XJejl1v6w61NUYGG7Eys0boj3HHs+923XS3
	6OpwaTMygJOwnwkUtrbytSx2TpA/6elvrkA87/JtMhTEctC8uewYqmwckJsHckqX
	FYlptLEy9Rtf83QqvjsKeY9+Sfokh5Q2JQRvC/6C4Khy8XnfaWQakhBxqL/CP3L+
	I/a4hcASPqz7dklAq4l2w9omP2ww4OrG3Ot2tAadcyT1FC91XreczxaF+o1pMuWw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ft67b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:25:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63790uPe018961;
	Tue, 7 Apr 2026 10:25:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9a69y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:25:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637APhnh27984302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:25:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D7920081;
	Tue,  7 Apr 2026 10:25:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 383072007E;
	Tue,  7 Apr 2026 10:25:40 +0000 (GMT)
Received: from [9.123.2.84] (unknown [9.123.2.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:25:39 +0000 (GMT)
Message-ID: <0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com>
Date: Tue, 7 Apr 2026 15:55:39 +0530
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A."
 <nysal@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
 <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
 <3075019f74969b25e3ab7f6b3f51ee54ed455aaf.camel@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <3075019f74969b25e3ab7f6b3f51ee54ed455aaf.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4dbac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=pFwa8OfPkI_SxIOsDfEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e93R3A4-PaQEdUT4GO1bkncKkQNMvnig
X-Proofpoint-GUID: tZo00FbT1O6yzT-ZHDsKizeVmOQvpLO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NSBTYWx0ZWRfX2XlIBXRDjbHB
 kFFfAeMRmPh+EtYmQD+I+/PV+zKtqxjR/gUksewlBa6sbBLEVJuHc0BZi1e+p1MoHYXhjWucx//
 UMyYilQQUXBefGIo5HWqbZftSFgvwz1ZIt6XZ6IMNFDjBTw0G4heq7sHfAxFqCh909WCy+mRcDo
 xtWWqfI6Dv2KJUnvFeoSWqPBoN7ZJr5HLc+yC7WLsdgL/GjnwYwrmG1U7rivYEITbT7z+z4Xrhz
 +XeMQwrsCkJ2p7mVUbhNyXHXbgu5Keup0rCcAAPuOMDGVIauwE+hk2TDbx8rXF7STvfXUVXUrVH
 dJU/wINYWXzrjmIbxMffopjaCX2UObaRzZ37lqjJ4JsP36KH5GQVQnc1eddyaBQDfRTfnfIqDsz
 GJfbre8upbkvYyrIkEGv3ChU45ZfM3INKby7Hsbhw88QbamKFU7OvL+J8duhM06u94PbcLmWGXY
 e/kqDuyDOZpkaC9qDOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070095

On 07/04/26 15:49, Shivang Upadhyay wrote:
> Hi,
> Thanks for your review.
>
> On Mon, 2026-04-06 at 14:22 +0530, Vishal Chourasia wrote:
>> Hi Shivang,
>>
>> Thanks for working on this issue.
>> A few questions and concerns about the approach:
>>
>> 1. Was this issue only observed with QEMU-based virtualization, or
>> does
>> it also reproduce on PowerVM/phyp? The commit message and sample logs
>> don't clarify this. If this is QEMU-specific, I think we should fix
>> this
>> in QEMU rather than working around it in the kernel.
> Currently this is only happening in Qemu (both tcg and kvm mode). But I
> think this should be reproducible on phyp also. Ill confirm wheather it
> is really the case or not.
>
>> 2. The approach taken here moves away from the PAPR interface. The
>> kernel currently uses H_SIGNAL_SYS_RESET_ALL_OTHERS, which is the
>> architecturally defined hcall for this purpose. Replacing it with a
>> per-CPU loop that checks internal kernel state (paca cpu_start)
>> breaks
>> the clean abstraction between guest and
>> QEMU's sPAPR implementation should behave the same way. The
>> hypervisor
> Yeah it is a valid concern about ownership for this resets. Ill try to
> see if this fix is possible in qemu itself.
>
>> (QEMU) should maintain a list of CPUs that have been
>> activated/online/started and given to the guest. When
>> H_SIGNAL_SYS_RESET_ALL_OTHERS is called, QEMU should only reset those
>> CPUs that the guest has actually started. Unless the guest makes the
>> RTAS start-cpu call for a CPU, QEMU should not include that CPU in
>> the
>> set of CPUs to be reset.
>>
>> I think discussing this would help determine the right fix location.
>>
>> Can you refer to the following commit in QEMU to see if help in this
>> case.
>>
>> commit fb802acdc8b162084e9e60d42aeba79097d14d2b
>> Author: Nicholas Piggin <npiggin@gmail.com>
>> Date:   Tue Mar 18 15:03:48 2025 +1000
>>
>>       ppc/spapr: Fix RTAS stopped state
>>
> Thanks for this reference. cpu->quiesced state was introduced in this
> patch, for modelling "RTAS stopped" state.
>
> as per the commit message:
> A KVM spapr guest boots with all secondary CPUs defined to be in the
> RTAS stopped" state. In this state, the CPU is only responsive to the
> start-cpu RTAS call.
>
> So, we should be able to use this to check wheather cpu is started or
> not. Only other concern here would be about phyp's implementation for
> this.

Yes, something like this.

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c

index 032805a8d0..8c51372cf8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1105,6 +1105,9 @@ static target_ulong h_signal_sys_reset(PowerPCCPU 
*cpu,
                      continue;
                  }
              }
+
+            if (c->env.quiesced) continue;
+
              run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
          }
          return H_SUCCESS;

>
> Thanks.
> ~Shivang.
>
>
>

