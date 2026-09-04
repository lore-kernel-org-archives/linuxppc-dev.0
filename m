Return-Path: <linuxppc-dev+bounces-26543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61653C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:59:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbsPv4sVnz2yr2;
	Fri, 04 Sep 2026 19:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788515971;
	cv=none; b=VhDC6hYzBDJe02pQQN+stHBAJdlcs+Cpbv11gRUuKHNDx+zeRQGCiy2p9PXiOI2g+WXCN0YXlyGn1U0X3Hi68hKl/Urh6J/cZ2yXl56a974BzDvf7QWUd/MILJMhq6N0k66AOatVBHc7uBWi0BfcBGPnuYe6ayzEG7GCpFPeCKcV/CeE+5ssjuie1VF7k1Prk+3U/losSTgthrK7oifovykVqNt3paasE6ZZJD1mUXAcxvoCgm17ulgWUXajSCRmQdZJ3sy/105JMH4d6KdR63asDJhnneBSdhhR/QpMPQS9z8nzDyWbous5ogNc7Clz6+uLGdZFFmUzss/qGbw8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788515971; c=relaxed/relaxed;
	bh=8nqIR/QD/inWJg6L+3YpBkQLzaaJAlX3TaSuCtey8kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewR0fhe0D4C1BTCwg0tRWUPrXFE4CrCzT/uaM5u49n2ZYEQ97Bu7NcRZlm1t8iLS0nEbeOueRlelzGcAQQs4DWmAEifavFgzQCj12QRCGQNCPcN0PIZTJ3JdI0L7PaPEwr8ssNnLrEg4hcEwP+jquXTlpPl3n1LAr6akf0SOIB3MmCZrke0A2kGBUnxViOeL9XAOjOwT5euXpysukIUF8kbvLKbXU5HhdRKrrhzQ4vQMV12lgTE4LcWep9ypZkeHwMrKyAcSMMDHCSR3Ul5skY9e9T2SZojoAq9LQvPImGim5u/0CIdFW6BMfT3Cma+c160b86OgJGh740y7IhqUKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=srE2W8XY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=srE2W8XY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbsPt5jYqz2y2b;
	Fri, 04 Sep 2026 19:59:30 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464MxE3254190;
	Fri, 4 Sep 2026 09:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8nqIR/
	QD/inWJg6L+3YpBkQLzaaJAlX3TaSuCtey8kc=; b=srE2W8XYJEher29Xt3be2E
	H+yjPl7iuUOzWnt1W5fThz3gmbyIHMrEHgqJopGlsMRjU536qIBlPrRgrwkMrm74
	dcvNL0gNOPvMwQzOrYVlYnso/xbxwOifWpjKqilNCrEy59yofzYOyntSgQzig3l4
	lWSGU0PH3+ECq4mcadztPSehy48aFot2r7SWFhs+10QAM3UtrsyCSR0xePA+ftD8
	ijqPW/zPJnoiGw/aTmLad3O/Wr9408DJAEkKBggb1qMyp5ebQEFvkAabMQCnVIgh
	0LYDzSghjGTPvFV95Qsp+iVOr8UhZqpkDRzmVJP+RuJ5HH81k7ttFIfm7Z9zs8WQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rt0p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:59:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849uGVN025012;
	Fri, 4 Sep 2026 09:59:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjavrve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:59:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849x83C46203384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:59:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B35420043;
	Fri,  4 Sep 2026 09:59:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5166620040;
	Fri,  4 Sep 2026 09:59:04 +0000 (GMT)
Received: from [9.124.221.192] (unknown [9.124.221.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:59:04 +0000 (GMT)
Message-ID: <f5011bc9-a25d-4f17-92ad-874f9c580dd2@linux.ibm.com>
Date: Fri, 4 Sep 2026 15:29:03 +0530
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
Subject: Re: [PATCH v3 2/3] powerpc/numa: Allow cpu_to_coregroup_id without
 PPC_SPLPAR
To: Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20260902123458.340456-5-srikar@linux.ibm.com>
 <20260902123458.340456-7-srikar@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260902123458.340456-7-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a9672 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PsCXb9kZ0i-3r-FgQ_EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX+Q8QlbRHqaXD
 coBEywXvopz126Nsxz2xAMkDLI2vz81xKhL/bsb9s36IkKzBHlHscsX4qtp1uffJvfpQxxRkXjC
 T2pKjNIzNcj/WfWFw0MOaQ4ZFTSE6vFWpftZSQ4RbgAqRgfkvqcvg/ryPnn8Let8rZ7nSAtrLcb
 wXELFg0D8naSbBkqIh7Wy5VJmZ8NTyhL5V/zv/0DGldhfMOgf5qvCDOU4qW8oqLkYyKYE+OVNyU
 s0UUoyCHpUN7f5uO4bd8OUZD50/uVZjMrBHjC5T04EEmJs6ihP+ZiLth4P8bGYo2TZya7NW9sI1
 R8QGkCPNTwVBbJYO9IKwrc7TE6pjGj+i2/IdjGF+zGvM341d9n/Tn/rsX/3gthM8uA2Hvex6wmW
 RB4vRz1bq0nYvvmKHcnHPrBUbhcA3gHQcerCowmXgNKm5DDgu69e5TTbaJThQxe4dFqnTPW+Zoi
 7+jpcvi6Ec2+1Sp37BA==
X-Proofpoint-GUID: N46DlNS8i6lfs8EzbTz_4cu05-O-cc97
X-Proofpoint-ORIG-GUID: _qozUJlXsfigLmvO3GcBhHYHT-7fOchL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX5eV5h2vZf5MM
 OpJbEnToQb8Hx6ZA8wbDh0A8tD3AmaerG++vjmRDsY4l9+5h74oxK4ovRYYL7xKQZlr/JZx/Zr0
 5TGDnSx5hQIQ48WdeeA4OuxebjkZL64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086



On 9/2/26 6:05 PM, Srikar Dronamraju wrote:
> Make cpu_to_coregroup_id() available outside PPC_SPLPAR so it can be
> used by platforms that do not rely on the SPLPAR-specific VPHN path.
> 
> Keep the existing fallback behavior by returning the core ID when
> coregroup information is unavailable.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog from v2:
> - Handle comments from Ritesh (one hunk needed to be moved from patch 2 to
>    patch 3 to build correctly)
> 
> Changelog from v1:
> - Handle comments from Christophe Leroy; Remove extern key word in
>    declaration
> 
>   arch/powerpc/include/asm/topology.h | 15 +++++++--------
>   arch/powerpc/mm/numa.c              | 22 +++++++++++++++-------
>   2 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 44ec416fa489..02c3c9ab3ea9 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
>   extern void unmap_cpu_from_node(unsigned long cpu);
>   #endif /* CONFIG_HOTPLUG_CPU */
>   
> +int cpu_to_coregroup_id(int cpu);

nit:

I prefer extern before declaration so that i can see it is defined
elsewhere.

Other than that, rest looks good to me.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

>   #else
>   
>   static inline int early_cpu_to_node(int cpu) { return 0; }
> @@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
>   static inline void unmap_cpu_from_node(unsigned long cpu) {}
>   #endif /* CONFIG_HOTPLUG_CPU */
>   #endif /* CONFIG_SMP */
> -
> -#endif /* CONFIG_NUMA */
> -
> -#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> -void find_and_update_cpu_nid(int cpu);
> -extern int cpu_to_coregroup_id(int cpu);
> -#else
> -static inline void find_and_update_cpu_nid(int cpu) {}
>   static inline int cpu_to_coregroup_id(int cpu)
>   {
>   #ifdef CONFIG_SMP
> @@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
>   #endif
>   }
>   
> +#endif /* CONFIG_NUMA */
> +
> +#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> +void find_and_update_cpu_nid(int cpu);
> +#else
> +static inline void find_and_update_cpu_nid(int cpu) {}
>   #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
>   
>   #include <asm-generic/topology.h>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index c44a80d8fc11..5f326b005a2a 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1428,6 +1428,21 @@ void find_and_update_cpu_nid(int cpu)
>   	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
>   }
>   
> +static int topology_update_init(void)
> +{
> +	topology_inited = 1;
> +	return 0;
> +}
> +device_initcall(topology_update_init);
> +
> +#else
> +static long vphn_get_associativity(unsigned long cpu,
> +					__be32 *associativity)
> +{
> +	return -1;
> +}
> +#endif /* CONFIG_PPC_SPLPAR */
> +
>   int cpu_to_coregroup_id(int cpu)
>   {
>   	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> @@ -1453,10 +1468,3 @@ int cpu_to_coregroup_id(int cpu)
>   	return cpu_to_core_id(cpu);
>   }
>   
> -static int topology_update_init(void)
> -{
> -	topology_inited = 1;
> -	return 0;
> -}
> -device_initcall(topology_update_init);
> -#endif /* CONFIG_PPC_SPLPAR */


