Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5Gq5RgZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMnnL4KBkz2y2K;
	Sun, 08 Nov 2026 20:34:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794130486;
	cv=none; b=PjlII5ehdrk+wT9ON0gpSMEK50YieqMkDI8VvcyEE0603z/SRCVhXdjkn5M0VthVlYrfAuCJP1wavV0dympEHStRlnp8X49+d5bYcDgxYp7Mm/aYdESCqu59gBJAvg4KWBu36K/UvB3sTSXg+YNu4elj9rFLd45WO8dTFsXDjf4g/Mlvn6CaGjOCsV+XRqdFNwXVASdy3cBeZoNergg7khAza0WdF5d6R51FgR5/G10pqTD04VgqxRSRjeU6/MxnzlOGYSeuKA+p96Q1Or1ccni1VsQtTGQS6UcjQGPkH0dAzWj2RvRxCfdrf5C8zGEu3lQeQ/1iLM0utuXnKlvpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794130486; c=relaxed/relaxed;
	bh=26mdlMVJY/cCagL9S9DgkIy3gT2A9gcY1ogtAJRX8+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2KrVqrqYZuFGuz2RlZf+vu+KDikcowyNjlEi6zc/+jyVs6W8Dmi4Tpmh3HoAZMYxqzbjvLHONYayYNLsk8PTzu4uiC6wRjPatGsyD/g0vME87xMYF9/W5EyZ+TaMJBrV5+WRwiGVlPsKP1fqjEuiW0ReapyXBUbf59huTxrygTxlWIDsBtRJehzrxkIUNVdBjB4XzJWMp4N6BMfscZm/7sBDa5se0gzRuaubH5pSxgsVHgFXXaqMZ11AgPzMw7sxdJmXYodNKvceCEHRynDwQ84HzeaPbqVewGyeyFH8mmh/LQgDFvRLpv5NrSevy7dtn11gX4CWyfO6eU/98DV2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5Gq5RgZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5Gq5RgZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMnnK2BJlz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 20:34:44 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A87iX853944789;
	Sun, 8 Nov 2026 09:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=26mdlM
	VJY/cCagL9S9DgkIy3gT2A9gcY1ogtAJRX8+o=; b=c5Gq5RgZxdtde19j+ldiu7
	qUPj8Hcyz+4M/yKrvg4PSJwws9J/Sz28XFeTebERCG9SHk2g4tI3Fxdi2w3ubouF
	Zlh/xnP4JG/GTS/Hj+4wr2f7njVxD0+hayPcpCMrfRg+2AOzSss1XTBMUbevaMPZ
	9X3f12T+L/RWxcEi1OR3Rc5WnfnsV8VKeYwbUYXkd5IHSoHBl6xO5U3sLRfhvYnC
	Xb78b5ZZ2EHyT6uAZ7P4L+bDd0fPBFi1FqBAy4Y40+hMFP2TcrQ7+ruYOlMyZHNo
	WRmop5LsNDWbwfrAJd5LtrQp/sVSEsos8A4+kqpYPorUmciQej8a5riq9jfDhUuw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumue2um-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Nov 2026 09:34:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A87ns221117441;
	Sun, 8 Nov 2026 09:34:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfs6mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Nov 2026 09:34:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A89Y8R455181806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Nov 2026 09:34:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9078F25C83;
	Sun,  8 Nov 2026 09:33:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CDD24EA1;
	Fri,  6 Nov 2026 08:59:13 +0000 (GMT)
Received: from [9.43.97.220] (unknown [9.43.97.220])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 08:59:12 +0000 (GMT)
Message-ID: <b361a5d7-d107-4fbd-a08f-1c89d71e3886@linux.ibm.com>
Date: Fri, 6 Nov 2026 14:29:11 +0530
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
Subject: Re: [PATCH] powerpc/crash: Add only the onlined CPU's node to the
 crash FDT
To: Vishal Chourasia <vishalc@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sshegde@linux.ibm.com, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
        pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
        seanjc@google.com, sourabhjain@linux.ibm.com
References: <20261104053848.1381005-1-vishalc@linux.ibm.com>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <20261104053848.1381005-1-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAzNiBTYWx0ZWRfXx7pUdwHhJFGz
 yCTjm5dI5XqXlRiYqUY/9zcvBG16CagNbNgfUlOt3H8iDhVBPHe8mTcvex7NOhUDJ6In1nQG886
 vMelCwX268psW3gI2gStrmWfShcpt50=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af04214 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=WK97a0cl3x871QaWk5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gGX8h1OsfJFICuAbGlI8T9wEWLmMFXFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzNiBTYWx0ZWRfXzlg6L82NvpKt
 5EDxA821838PbQ/WML3iKPSslEaxlJuJegrrmXyRbqyUs3Niyt+woF4cmDjLSOzDL1Ejor2pNi8
 fhrwD+W7OdQdDIYb42n70K+pe/UhiTMMcgGziiHE2QcshyVkUjgn4Lqel6OKWt5L8RI+VKWj5b5
 oLsApvVHeY851pPP3H+lLl3Ls5OM1IKgiWm/d19U0YfUMImbwri0b99SoRFaU2BIuhBK/66sZJa
 PtedTTvJ7t24lraI9mfweW6OrXDs0ThKWtJVbykQxC3Rhd2GnTeyWNLYRMIFDWeLH99oXGpdhk7
 e2MdIBrNnuXoGakDNtAcALjavGjRvARrR5a6pQ4RnrxVPuEJ/VKuFHgQmhO6R3E6zyndtAVZojH
 uxfybuIAq9GnUEEkk5Dd267aD9UySuTNjxBIdhpFlPWM4C1c+t9+gGyGyQZwKMESWsrewgtDF8h
 a2jPZYvFYxYPXM77tzg==
X-Proofpoint-ORIG-GUID: DAss56jNuKtoIAlVmp3D2uTiX8ErBuW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080036
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

On 04/11/26 11:08 am, Vishal Chourasia wrote:
> A CPU coming online never changes the nodes that are already in the FDT,
> so add only the node of that CPU. update_crash_fdt() looks up the device
> node of the onlined CPU and does nothing if the FDT already has a node of
> that name, which is the case when an offlined CPU comes back online. Only
> when the node is missing, the crash image is invalidated while the node is
> created with fdt_add_subnode() and its properties are copied from the live
> device node with fdt_setprop(). All of this is done directly in
> update_crash_fdt().
>
> fdt_add_subnode() inserts the node as the first child of /cpus, which is
> the same position a node attached to the live device tree takes, so the
> FDT keeps the order of the live tree.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   arch/powerpc/kexec/crash.c | 65 +++++++++++++++++++++++++++++++-------
>   arch/x86/kernel/crash.c    |  2 +-
>   kernel/crash_core.c        | 11 +++++--
>   3 files changed, 64 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 775895f31037..ca37006bddea 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -18,6 +18,7 @@
>   #include <linux/types.h>
>   #include <linux/libfdt.h>
>   #include <linux/memory.h>
> +#include <linux/of.h>
>   
>   #include <asm/processor.h>
>   #include <asm/machdep.h>
> @@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
>   }
>   
>   /**
> - * update_crash_fdt - updates the cpus node of the crash FDT.
> + * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
>    *
>    * @image: a pointer to kexec_crash_image
> + * @cpu: the CPU that was onlined
> + *
> + * The node is added as the first child of /cpus, the same position a node
> + * attached to the live device tree takes. Nothing is done if the FDT already
> + * has the node, for example when an offlined CPU comes back.
>    */
> -static void update_crash_fdt(struct kimage *image)
> +static void update_crash_fdt(struct kimage *image, unsigned int cpu)
>   {
> +	struct device_node *dn;
> +	struct property *pp;
>   	void *fdt;
> -	int fdt_index;
> +	int fdt_index, cpus_offset, node_offset;
> +
> +	dn = of_get_cpu_node(cpu, NULL);
> +	if (!dn) {
> +		pr_err("No device node found for CPU %u\n", cpu);
> +		return;
> +	}
>   
>   	fdt_index = get_fdt_index(image);
>   	if (fdt_index < 0) {
>   		pr_err("Unable to locate FDT segment.\n");
> -		return;
> +		goto put;
>   	}
>   
>   	fdt = __va((void *)image->segment[fdt_index].mem);
>   
> -	/* Temporarily invalidate the crash image while it is replaced */
> +	cpus_offset = fdt_path_offset(fdt, "/cpus");
> +	if (cpus_offset < 0) {
> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
> +		       fdt_strerror(cpus_offset));
> +		goto put;
> +	}
> +
> +	/* Node already present, e.g. an offlined CPU came back online */
> +	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0)
> +		goto put;
> +
> +	/* Temporarily invalidate the crash image while it is updated */
>   	xchg(&kexec_crash_image, NULL);
>   
> -	/* update FDT to reflect changes in CPU resources */
> -	if (update_cpus_node(fdt))
> -		pr_err("Failed to update crash FDT");
> +	node_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
> +	if (node_offset < 0) {
> +		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
> +		       fdt_strerror(node_offset));
> +		goto out;
> +	}
>   
> +	for_each_property_of_node(dn, pp) {
> +		int ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
> +
> +		if (ret < 0) {
> +			pr_err("Unable to add %s property: %s\n", pp->name,
> +			       fdt_strerror(ret));
> +			break;
> +		}
> +	}
> +out:
>   	/* The crash image is now valid once again */
>   	xchg(&kexec_crash_image, image);
> +put:
> +	of_node_put(dn);
>   }
>   
>   int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
> @@ -625,10 +665,11 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>    * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
>    *				     necessary kexec segments based on the hotplug event.
>    * @image: a pointer to kexec_crash_image
> - * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
> + * @arg: struct memory_notify handler for memory hotplug case and pointer to the
> + *	 cpu number for CPU hotplug case.
>    *
>    * Update the kdump image based on the type of hotplug event, represented by image->hp_action.
> - * CPU add: Update the FDT segment to include the newly added CPU.
> + * CPU add: Add the node of the newly added CPU to the FDT segment, if missing.
>    * CPU remove: No action is needed, with the assumption that it's okay to have offline CPUs
>    *	       part of the FDT.
>    * Memory add/remove: No action is taken as this is not yet supported.
> @@ -636,13 +677,15 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>   void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>   {
>   	struct memory_notify *mn;
> +	unsigned int cpu;
>   
>   	switch (image->hp_action) {
>   	case KEXEC_CRASH_HP_REMOVE_CPU:
>   		return;
>   
>   	case KEXEC_CRASH_HP_ADD_CPU:
> -		update_crash_fdt(image);
> +		cpu = *(unsigned int *)arg;
> +		update_crash_fdt(image, cpu);
>   		break;
>   
>   	case KEXEC_CRASH_HP_REMOVE_MEMORY:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e6f23933a6df..1660f26f3a44 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -441,7 +441,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>    * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>    * @image: a pointer to kexec_crash_image
>    * @arg: struct memory_notify handler for memory hotplug case and
> - *       NULL for CPU hotplug case.
> + *       pointer to the cpu number (unused here) for CPU hotplug case.
>    *
>    * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>    */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf899..53d4f2c1760c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -651,6 +651,9 @@ int crash_check_hotplug_support(void)
>    * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>    * excluded from SHA verification by default if the architecture
>    * supports crash hotplug.
> + *
> + * @arg is a struct memory_notify pointer for memory hotplug events and a
> + * pointer to the unsigned int cpu number for CPU hotplug events.
>    */
>   static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>   {
> @@ -676,10 +679,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>   		goto out;
>   
>   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> -		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU) {
>   		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> -	else
> +		/* CPU events are raised with no argument, the CPU number is passed instead */
> +		WARN_ON(arg);
> +		arg = &cpu;
> +	} else {
>   		pr_debug("hp_action %u\n", hp_action);
> +	}
>   
>   	/*
>   	 * The elfcorehdr_index is set to -1 when the struct kimage

I tested the patch with the following configuration and performed 
performance and functional validation

Test Configuration:
-------------------
System         : PowerPC LPAR
LPAR Mode      : Dedicated
CPU/Memory     : 50 cores / 80 GB
Kernel Version : 7.4.0-rc1

Case 1: SMT Switching Performance
---------------------------------
We measured SMT ON/OFF times with and without the patches, with
expedited RCU enabled via /sys/kernel/rcu_expedited and the crash
kernel image loaded (kexec_crash_loaded verified).

SMT Mode | Without Patch (s) | With Patch (s) | Improvement (%)
----------------------------------------------------------------
SMT ON   |      66.331       |      6.155     |  90.72% faster
SMT OFF  |       6.402       |      6.339     |   0.98% faster

Observation:
With the crash kernel loaded, SMT ON takes significantly longer
without the patches. The patches reduce SMT ON time by 90.72%,
while SMT OFF performance remains nearly unchanged.

Case 2: Functional Validation
-----------------------------

Test 1: Crash Dump Collection
-----------------------------
After performing CPU DLPAR with the crash kernel enabled, we
triggered a crash on CPU 3 using:

echo 1 > /proc/sys/kernel/sysrq
taskset -c 3 bash -c "echo c > /proc/sysrq-trigger"

Result: PASS - The crash kernel successfully collected the vmcore.

Test 2: CPU/NUMA Node Verification
----------------------------------
Verified that the newly added CPUs after DLPAR were correctly
reflected in NUMA node 5, including the updated CPU count and
adjusted logical CPU numbering.

Result: PASS

Overall, the patch significantly improve SMT ON performance,
and both functional validation tests passed.


Regards,
Samir

