Return-Path: <linuxppc-dev+bounces-28995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3C7CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 12:21:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Bzz32Ldz30HB;
	Wed, 07 Oct 2026 23:21:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791368433;
	cv=none; b=P+vagRBkgt0+ViRPXcXpio9rRNLFc8xIl1boKCTwlRAe4+7fokDgsH6XH/TxwMan9jTRHtrqKXKD4+pWJhoCFqf7XE+sYPcgc4JVE4JFX7Lv2GyiwATEIL5/FhJx4eTw7xJpWP6dJpfb9UHYdB3IhogW9sQboFtQd+tjxpDD/pAySd50B7NbsoDEUsao7sVc3ALEH2zz56nA2P+rxuQKh4rvOp+9gJRiL0jlRjG13KvdD8kLNHpvdvttkusB6XB1CepOxaQaAAncGTsrhc3Vy4CvLagBY7DDXZagS3JyfdiMi69319gigl0VDz1/eVF1v1KK3jed3sWzkTs2clkvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791368433; c=relaxed/relaxed;
	bh=YY+zk0nU+A0l4J58B95lMyurynE62aQZxet1k0dyhyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fghM3vcZT7SSMB48OzLQdJqM5pVjQh2w8is+8bXFfcW7SPQG5BmxqNdp0l4raKeeoBfL8BY/0dn7L/H+7koC2B/Y/zI87AlfVC5oJxuPNtmq6yJznDFntY/Nt+r9jljsPAr6BaMEuAK34ACnlKqtcI3eo9KtitqNzu31Ztz2hJmzXHAHN9sx89iT8ukhwoS6Xo4uMYp8pNq4FxKjn4fyzZLLbafpWXKQmZutM8r0Ti/Xs3rTDoeq6REGwjbkRqVekBykVgqQ52Dj/43B05ZH1+4lru7fWmzkVNOz5CelmtR2Mo1MAsfYilz+g4p+mYYHLBilTrJO9KyufrR2eXP1lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GSgrkL4l; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GSgrkL4l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j08Jw2ZMTz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 21:20:31 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785tAo2036290;
	Wed, 7 Oct 2026 10:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YY+zk0
	nU+A0l4J58B95lMyurynE62aQZxet1k0dyhyM=; b=GSgrkL4lWrvc6pmaE8+y72
	3rpOyQcQeaVotBo7WrK/DrqQfjwXJ5TllkjGaYOdB4XPQ4RLqVpuUv0K/WIVCAS4
	tQleEDKfRPZuE6Y6ATBMqDnfi/oKfczpmPseqIvTNJV/M0NADUh0L5gsgoMpjh8Y
	PdwpaUOB/h/NiFWwq2ttDRgTIntSkTJ9xNm255OvEzwJ5smyoRjI/XsgtrRsloqX
	0Yel3xPiwqa7Mx2/nisA8+LH8eUdeQSvLRXRm5WiOrb63ISvkF0bVkjPq7lvWEix
	QaKbmYWjHR0vwU0KVT4K9+suPp+m60MLIZj0AC3zJy0IF4vyMBcyXUsMoNu+F1CQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74vwqv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 10:19:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6977lV5s317050;
	Wed, 7 Oct 2026 10:19:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3ts2yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 10:19:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697AJqSW48431502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 10:19:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA0BF2005A;
	Wed,  7 Oct 2026 10:19:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E54D20040;
	Wed,  7 Oct 2026 10:19:52 +0000 (GMT)
Received: from [9.111.61.139] (unknown [9.111.61.139])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 10:19:51 +0000 (GMT)
Message-ID: <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Date: Wed, 7 Oct 2026 12:19:51 +0200
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
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, driver-core@lists.linux.dev,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20261001192849.74788-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ffY6TLKTpffrTfFwXFbRf4wLqXGAb6-j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX5YvUepf/U6OC
 FaGTWFpY1HrJave3vicTixr+fQ++9GqfU+3Zs3xMBvOA7U18g4ewllijqqjZRqTNSafqGvYfSI2
 wa/wcMb0rojmjOsrymp/srPPFUVCpHo=
X-Proofpoint-GUID: Tbz9hU4FADE_uXqR6VBUuc00GL4SXDgo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX00U2nwqsffsr
 JT1pX+wU2mYPlMFpB5UhX49I2QLaW5KljBowrcfIidPfJZKyN4kjMviAR0tjoJkpFtkF41hfR9F
 zHKylZ85W09CAFxl4I4ZwkQ3ueJld+uJTg1Cf6nvaHLesQoDB8D3fyDo7MoGFk0MU8QFYUVAdSu
 rk3wneyhGtd1rYsppgxJdu0ZSVI5aajd3Mw4ENg1EKDyProGlZnJHzWvmSW+25C8XbWCGdDaf80
 NTOYWtoXZVr86oeSKRXt+xAjChyINKVjCo0RF6l3mnXf1LxrLO1es0XbzuO/AFx6CyoEG1PHzpF
 kEZ4pNc1nIWQYG8GltklzFwzSwCVVZ72cr5pbYOPMAm36ByfzqkjvyVFUTWrpPMgjV0wRc3eZl/
 zqwbfDUzbowD3vBO5g8qeQ2jwDePDt5xS9f1lNMq5FJN0/U52QHOTKwggp6lmJ5oVq9w6kkzyLG
 yVMV1dy1jBmPwuMLWfw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac61ccf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zd2uoN0lAAAA:8
 a=Ljveq5rUL1csS5QuFncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070040

On 01/10/2026 21:28, K Prateek Nayak wrote:
> When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
> already parses the set of socket present on the system.
> 
> Use the socket_info to configure the sparsebitmask (sbm) properties for
> the system - namely the number of sockets and maximum threads in a
> socket instance.
> 
> arch_sbm_cpu_instance_id() traverses all socket instances to find
> a matching CPU which is not optimal but instance ID is only checked
> when the CPU is coming online. Since this is a rare event, the
> inefficiency is tolerable.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Build tested with LKP's s390 randconfig with QEMU cmdline:
> 
>    qemu-system-s390x \
>    -cpu max \
>    -smp 2 \
>    -m 2048 \
>    -kernel ./arch/s390/boot/vmlinux  \
>    -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
>    -nographic
> 
> Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
> actual spasemask setting is only build tested at the moment.
> 
> XXX: Any way around this using cross-compile and QEMU?
> ---
>   arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 1377c6f3f670..80dc51f5ce6f 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -20,6 +20,7 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/cpu.h>
> +#include <linux/sbm.h>
>   #include <linux/smp.h>
>   #include <linux/mm.h>
>   #include <linux/nodemask.h>
> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
>   	return tl_core->pp != POLARIZATION_HRZ;
>   }

topology_init_early() is called once during early boot and never again.
Considering that s390's topology can change during runtime this
implementation won't work as sbm won't be able to adapt.
On s390 max_threads_per_instance can change during runtime.

Like sashiko pointed out, this approach also does not consider
any newly added cpus.

IMHO, there is a slight redesign required so that smb_set_topology()
and smb_init() can be called each time a topology rebuild is necessary.

