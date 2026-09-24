Return-Path: <linuxppc-dev+bounces-28114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB4DC9831D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 12:53:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrDKf6Jj0z2yD3;
	Thu, 24 Sep 2026 22:53:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790230667;
	cv=none; b=fmqdu6U8dO1juqn17/tHpwjP5D4Lb+LCBhOzbYPgN6XiMtfqIEeu3ij1InvSpvMXhBBOW52IfZWnWpSO5FXGiADCIW8L1SMfBUkpihnz58XvH5nSNLoXCb0dZ3S3MGgvam4AtBVVBJZzaQKeHkmwS5XD8JPBBKKu5CbKeRG37Xv7RU9p4BsMk/gfJ5pUz18wXF29Pu/CikXrXj+spr0TlCw5folXJPnmI//e/TD2jYCxQf7xZC6YdSfeN6tpSzNF+6QfGiuBG3MVcqRdiHov+RBH/RErPKkPqlHMhk+bb0Bsw3n7ZyoDzh0rQ7u+yK2/y4l7m2tfjvXaRNOsjJEosw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790230667; c=relaxed/relaxed;
	bh=6c3fNl6wYoqHgVUfRJCa5O7Gu1Skwm4zRTVcLTAxX7I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nQif2WfHn8jAgjxKRnOjHJ7rWc5I7PA+VDuOUTQxeeG3jjSLDyp8OmC2xKqd3NNoYp+Dp2MxJ5AYrMvCbYoFQFR0PN58JV0hNPRuZ5sg+X2HfdVBrIGjDqd8ZJ3+QndWX5Yj76s2wNpLnM3S+KNqWdlC8F8B5o1W6HoyRJoKmeWW58JqComaZQ7y3+nk8DkNh5km2Jfffidp/TIhWiRiBXsNt1UxYyCikSkWW3ZKFsXCTSUuXWRBR4d4NU7fLxkYIFrLSHMqP8Rjr3j2cIXNwku5qAiML9AHBTex2RX6As0QH5wz6/rM94DkNj818EDBZRoQzdVDHZr/PSnZ9fLbHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YCbAgOeR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YCbAgOeR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr3Xm0ZXTz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 16:17:43 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bRtp1372031;
	Thu, 24 Sep 2026 06:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6c3fNl
	6wYoqHgVUfRJCa5O7Gu1Skwm4zRTVcLTAxX7I=; b=YCbAgOeRZa5zO8MmHR4d/f
	WRrDzmcR1ilgzxzDbscaCQE2G9Q0uwoisQQ2ar3HR/d/E8lh5/4tpgvXD9ea9hsz
	GdxdFgr/OGQPUrfVURkx7RWKbh9KtUhhiUn3+Q9yATHsGFS2K0tmFZGQk9lWJKrr
	sPs0yZpebYk16FhTuj5IsTRZS9yRToXbdPCNPkfFEMwzJVamQTMkJdfyDWe9qtXp
	X03S/HpmMJGAhNgxdfTLQXyaKt/OMu1Ed9s7vziJ7Xtmls7k0NWOuMqScle8WKZX
	x3M0Bc5OrLGLJYBuvo+BOiOJadTijFILld2tQF0RlzG9sqYajpfzns3FZaKpMluA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdveq23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:17:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lYTN1554285;
	Thu, 24 Sep 2026 06:17:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qmdf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:17:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O6HJAK29098710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 06:17:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C95965805A;
	Thu, 24 Sep 2026 06:17:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF1058054;
	Thu, 24 Sep 2026 06:17:19 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 06:17:19 +0000 (GMT)
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
Date: Thu, 24 Sep 2026 11:47:18 +0530
From: jyoti <jyoti@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix missing of_node_put() calls
In-Reply-To: <20260924061132.178744-1-jyoti@linux.ibm.com>
References: <20260924061132.178744-1-jyoti@linux.ibm.com>
Message-ID: <5cef10ab1610113fe162cec1dffd97f3@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AUAeOOyOcIWhtjDTb4CPAnq8BtHcnHsH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfXzqApml3K5ivd
 NXojZlewn/zknhWQHac554D3yJRXiXyuDaEf+xvh7HWS+Rvg4fE93c5lsVUkGS8z3QsX3Wez3kf
 DeKbkxOqt3yOCgVL7v3o/46OMePx1wI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab4c072 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ENoAIOW7Q9U8ZCHd3F0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: iIagjr1qgKHDxksdBxsDZrFvd4XQj2bK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX/BR6uAGUXV3w
 CO0FlDBTwzg7AcCppnfLC88kSLa0D9PsUQq+WOnBV31JbZVtoBL8ZqnxeZon4craz/lR4nx/dsx
 UKWr4PvXMVI9ek33A6C1fh29fJSkBeqIaEzO+6BXE72cL+3y153yK/rBahgZecLzr4CDpf5ZKGA
 PFQS75lMsb/X+PVauf/8Jm5zEmz7zHMi7hMGlQHmBtSMmzQ3HEXeAB8VwpRT/EseT90zoykgORo
 epcKfOgnMI/ALUrX5nx6Z2o1O23LOKRFDobrjkS8e+QBT7VmWIcsB3enxo6/YiPatw+j+3LPLum
 H3g7S2g3fKAvwHrsVBDEF9yKLHMWzij7y4LVXGbn7KBEGXx09PzJ75ogvMp0YBJb1P888EZFgyV
 84EhYfmBVwQa9IR5MZtwzHOoYt9USriX+kCptRA7OapP8biFVdW81xm7WSeg2q5zSaFAK9gzUig
 ucBbzdLCXxbPc8XambQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240026

On 2026-09-24 11:41, Jyoti Gupta wrote:
> Several PowerPC code paths acquire device tree node references but fail
> to drop them on error paths, early exits.
> 
> Add the missing of_node_put() calls across PowerPC platform to ensure
> proper device node reference counting.
> 
> These changes prevent device node reference leaks and improve overall
> resource management in PowerPC code.
> 
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
>  arch/powerpc/kexec/file_load_64.c            | 1 +
>  arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
>  arch/powerpc/platforms/44x/warp.c            | 1 +
>  arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
>  arch/powerpc/platforms/86xx/pic.c            | 1 +
>  arch/powerpc/platforms/pasemi/setup.c        | 1 +
>  arch/powerpc/platforms/powermac/pci.c        | 1 +
>  arch/powerpc/platforms/powermac/smp.c        | 2 ++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
>  arch/powerpc/sysdev/mpic.c                   | 4 ++--
>  10 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/file_load_64.c
> b/arch/powerpc/kexec/file_load_64.c
> index bd80c5fb1b1f..8d4d6a51c046 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -204,6 +204,7 @@ static int add_usable_mem_property(void *fdt,
> struct device_node *dn,
>  	if (snprintf(path, NODE_PATH_LEN, "%pOF", dn) > (NODE_PATH_LEN - 1)) 
> {
>  		pr_err("Buffer (%d) too small for memory node: %pOF\n",
>  		       NODE_PATH_LEN, dn);
> +		of_node_put(dn);
>  		return -EOVERFLOW;
>  	}
>  	kexec_dprintk("Memory node path: %s\n", path);
> diff --git a/arch/powerpc/platforms/44x/iss4xx.c
> b/arch/powerpc/platforms/44x/iss4xx.c
> index ef883d97fe15..ef92b4656d17 100644
> --- a/arch/powerpc/platforms/44x/iss4xx.c
> +++ b/arch/powerpc/platforms/44x/iss4xx.c
> @@ -74,6 +74,8 @@ static void __init iss4xx_init_irq(void)
>  #endif
>  	} else
>  		panic("Unrecognized top level interrupt controller");
> +
> +	of_node_put(np);
>  }
> 
>  #ifdef CONFIG_SMP
> diff --git a/arch/powerpc/platforms/44x/warp.c
> b/arch/powerpc/platforms/44x/warp.c
> index 6f674f86dc85..49afd60b1c30 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -183,6 +183,7 @@ static int pika_setup_leds(void)
>  				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
>  				       led->name, error);
>  				of_node_put(child);
> +				of_node_put(np);
>  				goto err_cleanup_pins;
>  			}
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> index cb00d596ad80..9b7283038892 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
> @@ -52,6 +52,7 @@ void __init mpc85xx_8259_init(void)
>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>  	if (!cascade_irq) {
>  		pr_err("i8259: Failed to map cascade interrupt\n");
> +		of_node_put(cascade_node);
>  		return;
>  	}
> 
> diff --git a/arch/powerpc/platforms/86xx/pic.c
> b/arch/powerpc/platforms/86xx/pic.c
> index 9ca36de23532..4cbcc16b1009 100644
> --- a/arch/powerpc/platforms/86xx/pic.c
> +++ b/arch/powerpc/platforms/86xx/pic.c
> @@ -58,6 +58,7 @@ void __init mpc86xx_init_irq(void)
>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>  	if (!cascade_irq) {
>  		printk(KERN_ERR "Failed to map cascade interrupt\n");
> +		of_node_put(cascade_node);
>  		return;
>  	}
> 
> diff --git a/arch/powerpc/platforms/pasemi/setup.c
> b/arch/powerpc/platforms/pasemi/setup.c
> index 45792ecd5dfd..b016e27b20ee 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -274,6 +274,7 @@ static __init void pas_init_IRQ(void)
>  	opprop = of_get_property(root, "platform-open-pic", &opplen);
>  	if (!opprop) {
>  		pr_err("No platform-open-pic property.\n");
> +		of_node_put(mpic_node);
>  		of_node_put(root);
>  		return;
>  	}
> diff --git a/arch/powerpc/platforms/powermac/pci.c
> b/arch/powerpc/platforms/powermac/pci.c
> index d71359b5331c..8bc56a70b4c8 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -938,6 +938,7 @@ void __init pmac_pci_init(void)
>  	/* pmac_check_ht_link(); */
> 
>  #else /* CONFIG_PPC64 */
> +	of_node_put(ht);
>  	init_p2pbridge();
>  	init_second_ohare();
>  	fixup_nec_usb2();
> diff --git a/arch/powerpc/platforms/powermac/smp.c
> b/arch/powerpc/platforms/powermac/smp.c
> index 88e92af8acf9..82c5f49576c5 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -591,11 +591,13 @@ static void __init 
> smp_core99_setup_i2c_hwsync(int ncpus)
>  				pmac_tb_freeze = smp_core99_cypress_tb_freeze;
>  				name = "Cypress";
>  			}
> +			of_node_put(cc);
>  			break;
>  		case 0xd4:
>  			pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
>  			pmac_tb_pulsar_addr = 0xd4;
>  			name = "Pulsar";
> +			of_node_put(cc);
>  			break;
>  		}
>  		if (pmac_tb_freeze != NULL) {
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index bc6926dbf148..c4f7348aa035 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -637,16 +637,16 @@ static unsigned int
> pseries_cpuhp_cache_use_count(const struct device_node *cach
> 
>  	for_each_of_cpu_node(dn) {
>  		tn = of_find_next_cache_node(dn);
> -		of_node_put(tn);
>  		if (tn == cachedn)
>  			use_count++;
> +		of_node_put(tn);
>  	}
> 
>  	for_each_node_by_type(dn, "cache") {
>  		tn = of_find_next_cache_node(dn);
> -		of_node_put(tn);
>  		if (tn == cachedn)
>  			use_count++;
> +		of_node_put(tn);
>  	}
> 
>  	return use_count;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..6e8fa94985f3 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct 
> device_node *node,
>  		if (fsl_version >= 0x401) {
>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
> -				return NULL;
> +				goto err_of_node_put;
>  		}
> 
>  	}
> @@ -1493,7 +1493,7 @@ struct mpic * __init mpic_alloc(struct 
> device_node *node,
>  	 * is very unlikely to fail but it ought to be fixed anyways.
>  	 */
>  	if (mpic->irqhost == NULL)
> -		return NULL;
> +		goto err_of_node_put;
> 
>  	/* Display version */
>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {

