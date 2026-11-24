Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F1606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JSxXKSJ+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYd2v0Fx5z2y2b;
	Tue, 24 Nov 2026 20:35:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795512934;
	cv=none; b=nl5LNYpHQUqLqna2R/wTe36ePiYg9ML/W5HLEUEO92AEu8i2u5CoTk6cabbNe1GCtl1he3iAve/YUFECJjm+eOWnq+aJNd0rbgutf+MfLepkCz0g6Ggmzl3l3wCv5av2ob8iYqCXqA7rPxoIl9Tm4dh7YJsSI+5mlKtXiZPYjWTPMbwhjzD3MmBMNfQE64o5hwl0ayQMZYIuW2h1MnY4Elk7NnshzYzaww//7qoud0PEbLvI4BTerHiwVMGW6m7pSnZSFaRbT1bNPCpt8o7U4rSGv0AQY0bn+Njq4mPo5gmuUUhRDO+Ab0PaZL6b/hddYw1oCNYwbfPoTzO/qg669A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795512934; c=relaxed/relaxed;
	bh=D8bVNU7oB3bmU/rHoE2jYFPe9ETXZbQxDjY46ziarvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx0v3nAQznk6Br0E8iEQIrZbypjhCdjjc6rIZ3gZq1ikqT7M3dbIO4K0BV7hAsOLMM+GkGvqe5zayIEEvJs/TvzIPPsa2dLjMaPMNh0qh+j8ksfxt+BesVOl0fKT2OuH2IRcACTeCAXYx2AZ95WHOtHgQv2e/FO9fMup9EB2eKfHRchd8uCwKuPagAPfRZxDX4Nc4SjFreh2jVcL0g2KLFBrAtG68fjYFofoi78gIlhiw+cHKsy376CGSnBXh/24SEF7+vH++1OZFeOH/emsbd+47klQShqFnsDHympGk7Vo6lygwulEDFuFzRJmOsfHCTBWA2i3UDIjrnAyGzT6lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JSxXKSJ+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JSxXKSJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYd2s6BzXz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 20:35:33 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO356qX1271610;
	Tue, 24 Nov 2026 09:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D8bVNU
	7oB3bmU/rHoE2jYFPe9ETXZbQxDjY46ziarvs=; b=JSxXKSJ+eLiQOjPbYWsDck
	G0EPS8jy1wpoR6EegncLkhUwIFVUF9dWBX5mi7yKqH8985d5SpykLnR54U+lTt/8
	aopY97RvTnI2vv3NDgbFAkbwdlkbBdMLqNtVcP4A/WXTJ6C8BST9Js7eptnMjbZZ
	2XFs+BUOW8Shko8I/aW/2KUR4ZEe0gCWlxPNzxTQkB01L0homUrL2aWjipIkn2T0
	DVs52E8RDNhX9Y81zf8P6APzhoGpgrWGbnCnrdeqMsZonf+97QStl9AtxxmaEShg
	gvHwvnXXqkUjOKKSOE2TnKlZYCy87toGYh2hNsJG9wdmJzR9Vgh2XrMOlOfkYJ0A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g16mqp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 09:35:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8x5Rj3890861;
	Tue, 24 Nov 2026 09:35:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h9ynp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 09:35:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO9Z61Q28181198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 09:35:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB76E2005A;
	Tue, 24 Nov 2026 09:35:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAFBB2004E;
	Tue, 24 Nov 2026 09:35:02 +0000 (GMT)
Received: from [9.39.26.220] (unknown [9.39.26.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 09:35:02 +0000 (GMT)
Message-ID: <a2bd3564-0990-47ab-b922-6793dd1de144@linux.ibm.com>
Date: Tue, 24 Nov 2026 15:05:01 +0530
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
Subject: Re: [PATCH 0/5] cacheinfo, powerpc: Move powerpc to generic cacheinfo
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev
Cc: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261118163639.890546-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cgxDXRLU7frcthZrm8ywv-bSA6kQLkug
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNiBTYWx0ZWRfX0G7rF0YTsorK
 VAr4IS2zpQiOBEOYkWZsLQSIS9+70PTnTdokW7iXrsRLC52kYhpCKAXPEhuWvozPEu5WZLe/YvA
 4dU1vsZ3ruMe0jWo452PCNANO6UNmw0=
X-Proofpoint-GUID: ytxi2pxdeRsI1y50fNAvczzjgJiMbVOH
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b055a4f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=lsGhJCwmx7oV3vd9AWkA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNiBTYWx0ZWRfX49CZomBWZ+tC
 pdVZlVdQXQSeAeCV/vQxvoxzldYfzMqBZGoUaWE7yCdgkja/BD0PQoeRcrmTKk7DCLzDu0Fy8M0
 usD+MvQXshMfGY9KEDvufTowBKUTqfQ40ZtNK7EZMwdp5QDZjCW+pe6haRBGYD6oL0DAyF0norU
 r0kjG5hNMFiJp0jdkHAeboI1L5tzvfeuR+5UxqI0lXdp4sL6uMWu3+dHvUUb7lK/L/SROdNJpu0
 RQTYQ6i7veRc4eKV0t3xtHIycVH941y+NZdJQ+OJ5PlV4Hd/gjO+ugiXDjikv82v6wRvNoek5Xe
 eJlsjKTwy7gq+FbldYmoqRh1dezg2J6VJ6RTTItmcdC/tLoUaOt3V8Ee+gXPv/mVduZJ7Ec2JM9
 TByPV2sT+3TXzeSN8YN8yYTMnKAv+iRfbSz03nyfNJLpVjfA5QctEqopN8Peo8F6XAviIewisvE
 e0g7XxtgBeyrjAMjGdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240036
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 10:06 PM, Shrikanth Hegde wrote:
> This is another attempt to move powerpc towards generic cacheinfo
> framework. This is spiritual successor to earlier attempts by Sudeep
> Holla [1]
> 
> The context around this time was, when trying to enable Cache Aware
> scheduling on powerpc using a llc_override kernel parameter[2], it was
> pointed out that the llc_bytes which is retreived using
> get_effective_llc_bytes fails and hence the cache aware scheduling is
> effectively a NOP, moment the process has a visible footprint.
> 
> Instead of adding more hacks around with custom arch_llc_bytes, this is
> an attempt to move powerpc to generic cacheinfo instead. This removes
> the powerpc maintaining a separate sysfs entries for all caches.
> A few modifications to the generic code is necessary due to some of the
> conventions followed in the device tree specifications. The details are
> in the respective patches.
> 
> If this approach does not work, then I am afraid we might have to fallback to
> arch_llc_bytes.

Well, though it worked for normal boot and hotplug, LPM is broken and DLPAR is likely
a problem too if the logical CPUid is reused with different device tree node.

So I am afraid it is not straightforward to port.

The current PowerPC implementation owns references to the device-tree cache nodes
and destroys and rebuilds its cache objects during LPM. It also releases cache
objects as CPUs are removed during DLPAR.

Generic cacheinfo has a different lifetime model. Its per-CPU info_list is retained
across CPU offline, and the leaves continue to contain fw_token pointers to the
device-tree cache nodes. Replacing or freeing those leaves safely is not straightforward
because scheduler and page allocator users can access them concurrently. Handling this properly
would need a broader lifetime and synchronization mechanism in generic cacheinfo.

Doing all that heavy lifting for the case of LPM/DLPAR is likely going to be overkill.
That may still be worth doing independently, but it is substantially more involved than
what is needed here.

So I am planning to resort to something like below. Introduce a new arch
specific hook (cacheinfo_get_arch_llc_info) to get the cache size and
cpus of that cache.

Hopefully should be able to send it out soon. Now would be the good to wake me up if
there is a better way!!


@@ -XXX,15 +XXX,23 @@ static unsigned long get_effective_llc_bytes(int cpu,
  					     struct sched_domain *sd)
  {
  	struct cacheinfo *llc;
+	unsigned long size;
  	unsigned int hw_weight;
  
  	llc = get_cpu_cacheinfo_llc(cpu);
-	if (!llc)
-		return 0;
+	if (llc) {
+		size = llc->size;
+		hw_weight = cpumask_weight(&llc->shared_cpu_map);
+	} else if (cacheinfo_get_arch_llc_info(cpu, &size, &hw_weight)) {
+		return 0;
+	}
  
-	hw_weight = cpumask_weight(&llc->shared_cpu_map);
-	if (!hw_weight)
+	if (!size || !hw_weight)
  		return 0;
  
-	return llc->size * sd->span_weight / hw_weight;
+	return size * sd->span_weight / hw_weight;

> 
> Note that initial draft of the work[code,changelog] was carried out by LLM.
> Provided the device tree blob and both powerpc,generic cacheinfo code.
> With few iterations, LLM did generate the right code with few tweaks.
> Only the cover-letter and Patch 5 are completely from me. Thanks to
> LLM, this series is in shape in few days otherwise would have taken
> more time.
> 
> Tested the values compatibilty on Power11 Dedicated and Shared LPAR's.
> All the values are same, except id and uevent which was not there
> before. That should help rather than hurt any tool.
> 
> This may need more broader checks on different boards/configuration
> to ensure it is same. Also DLPAR CPU add/remove is not tested yet.
> Please test and report if your board/platform shows up any different
> values in those cache entries.
> 
> [1]: https://lore.kernel.org/all/1424715500-21725-1-git-send-email-sudeep.holla@arm.com/#t
> [2]: https://lore.kernel.org/all/20261023131646.2907938-1-sshegde@linux.ibm.com/
> 
> This series is needed llc_override patch[2] series to work. A subsequent
> version of that will be sent out soon.
> 
> PS: I am working with 90% coffee and 10% sleep.
> 
> Shrikanth Hegde (5):
>    cacheinfo: Allow architectures to provide custom cache IDs
>    cacheinfo: Support unified caches described by d-cache properties
>    cacheinfo: Add teardown and rebuild helpers
>    powerpc/cacheinfo: Move to generic cacheinfo
>    sched/topology: Remove stale comment around llc_bytes on powerpc
> 
>   arch/powerpc/kernel/cacheinfo.c           | 994 +++-------------------
>   arch/powerpc/kernel/cacheinfo.h           |  13 -
>   arch/powerpc/kernel/sysfs.c               |   3 -
>   arch/powerpc/platforms/pseries/mobility.c |   2 +-
>   drivers/base/cacheinfo.c                  | 111 ++-
>   include/linux/cacheinfo.h                 |   3 +
>   kernel/sched/topology.c                   |   7 -
>   7 files changed, 194 insertions(+), 939 deletions(-)
>   delete mode 100644 arch/powerpc/kernel/cacheinfo.h
> 


