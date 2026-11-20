Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DA606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lwlsAq1z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW5Hy3Wx7z2yDm;
	Fri, 20 Nov 2026 17:38:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795156686;
	cv=none; b=O13JaXYbMeR+AG00cOpvzZXn6P9MbaJAGVLiXgpldoQqsOg34YBOTWg/ZFKVOTnC2uFV3qG4GhOChMbsYrJgCDSyVQSV5IQszbWoTmj/7F0wjHuUDQk94o63PZ2Y1uYwWLM7HeU8mVVfwsfvMspEN/SWVRLbsaMCEN+ArDg1Z5i4M6IDVI24TgbzM0CdmmNK4/Ob8WHe7pzCcPCSdkXagTOj01elMiEMcJsR4jQotbeLK5f+KgQBhVkCR6PBotXgm6IQfg3CvRqxKliyNiXeHX+yHOWLxOLOYA+a0A7SkOF2twXFwTaRnnXi9JjeyxNnOo9FzUlau2AXfPnyyG5BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795156686; c=relaxed/relaxed;
	bh=KlgdLS6lLR/eC6h44A9+4iXGKMpi6PhPSLwpGMzFKIo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PkGywOKaRwAKR3R+bsxFd7HVUfCGehMozd5ThGeowmQB9Qx6gByb85m0wPT67xuOjbKT2a7CmAtnx2kutCzJsTRuDgxveIsQ8b6apmSkjPKdjGVtl+XUzy3NENrIf0nObDz6kRg1Xhx8EG93Su9088dlQOQCnE8vXgXOoXb2eKhvjPRfAW3Hb3Zma2dl1tQhAL9JgmNmnjQkHG9FkOMgORoKpJ2JquIeduP27rHMLZUi38b3/NvRNhh4KVaCcRdGGTFoDCOqGi58RhBNGX86o1philgh3ki6viz2k4/RUHMDmtxXfa+ysstkQYX1sHiA1iW2KcrVwPlpvj0sTGTnHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lwlsAq1z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lwlsAq1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW5Hx38Pmz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 17:38:04 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uPRw1965244;
	Fri, 20 Nov 2026 06:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KlgdLS
	6lLR/eC6h44A9+4iXGKMpi6PhPSLwpGMzFKIo=; b=lwlsAq1zvEKxYrobUzL7KW
	sWJL9LunPRDhfSgsq0qcgVtYErk4YtkOj8tnyivmHl0IYNdi1Oj2XoqNvK8Etl21
	ph7YARCR/DIcczpi1MbD1R/MHr4a04GdwoMHXt4UHWvBnCQS6Ul8M3Lumz0HX//N
	SJSsCqxFe5UQj95IqwoXnAEWr7zGqXft53Q9hfOMAwa8T86f77DYvY6uVg68gv5Z
	BMjGF/K8ort+zpPv2jT2WkmzJuD0ge8acZMYUm2SbYYPV7e3N1W5MPdM/hk3ZtZQ
	eaQjscLidbZ7ly+yYK9Agk1FpsiqzUfK2p3mIuP3yHRwhNF6fJbq4iNzYKRBCWsw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x694c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 06:37:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3Z2873627449;
	Fri, 20 Nov 2026 06:37:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xegng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 06:37:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK6br5F20513370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 06:37:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F8058054;
	Fri, 20 Nov 2026 06:37:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA49E5805D;
	Fri, 20 Nov 2026 06:37:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 06:37:52 +0000 (GMT)
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
Date: Fri, 20 Nov 2026 12:07:52 +0530
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, npiggin@gmail.com,
        chleroy@kernel.org, sshegde@linux.ibm.com, oss@buserror.net,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix missing of_node_put() calls
In-Reply-To: <1p8gkw46.ritesh.list@gmail.com>
References: <20261119075827.45823-1-jyoti@linux.ibm.com>
 <1p8gkw46.ritesh.list@gmail.com>
Message-ID: <2f9d03e7c3f9d94f2b5a8423fe81de7a@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1advrjIimjHZ-0nePPXVk37qw9fbhKAU
X-Proofpoint-GUID: hpKP3oYPsqoAyLvRnjIry37pthar5Q-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyNSBTYWx0ZWRfXxXmWqmqGobGW
 +nKvpEBlUge5t6P0TGKolHPHjGGVmxGuAVwwrf97KuAj9OT3NJ78KFH993iadVoekhxiPgkkVNj
 zvzJXod10YLTA/CVZwTAdFrV4ZBGfd7rAf1LPcGFobeshzJkLNFPr7LuvMRVYNgV1rTNB7yIIEE
 zRgTWsbaVXjYaKQrpbGYnpFmSTqKx89a+sLICZRBBNmocWIJSI89uloxa8UaFhJ3j3SOQpryl1+
 VGKRIfhkrpAxZlHPcfLGry+pBCkUjmpyERslJLsEQhNI+F7EWZR5aAJwxRz0FpxY+b11j+hXhp4
 2tN6NskUGLYenr//r5nKzWBDdNPHypCFojChkRsy6xxfrnVF0IuDvH29pbOlO8s3qeMFh/A5cSw
 diRE9dv2uxzO/Q7fW5/ue+U8o0ZYXmLOKP5VON8Q7gvXujZ7flT7WVC8T0H51d4vyvAOe+AKvN6
 8F+i11HkSzvWGFeQAZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyNSBTYWx0ZWRfX7by71n4Re0D9
 tOttySVehvDZ2y62PKjLpoIEAEHq3zFn9GoAeAPB1BoMAi/3rt8HYqKUi8RUNBTgrkX/94mNhYy
 jmQCKImc98iueFiH6jlNKu8W2S6I24c=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6affeac4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6xbVsh9zSzqLEicigfAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200025
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-20 09:11, Ritesh Harjani wrote:
> Jyoti Gupta <jyoti@linux.ibm.com> writes:
> 
>> Several PowerPC code paths acquire device tree node references but 
>> fail
>> to drop them on error paths, early exits.
>> 
>> Add the missing of_node_put() calls across PowerPC platform to ensure
>> proper device node reference counting.
>> 
>> These changes prevent device node reference leaks and improve overall
>> resource management in PowerPC code.
>> 
>> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
>> ---
>> Changelog:
>> v1 -> v2:
>>  - Rebased onto latest upstream.
>>  - Dropped the powermac/smp.c hunk: there is no leak there. The loop
>>   iterator drops cc on continue/advance and the existing code puts it
>>   before the break, so the added of_node_put() calls were a double 
>> put.
>>  - Added Suggested-by tag.
>>  - Link to v1 - 
>> https://lore.kernel.org/all/20260930182304.341123-1-jyoti@linux.ibm.com/
>> ---
>>  arch/powerpc/kexec/file_load_64.c            | 1 +
>>  arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
>>  arch/powerpc/platforms/44x/warp.c            | 1 +
>>  arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
>>  arch/powerpc/platforms/86xx/pic.c            | 1 +
>>  arch/powerpc/platforms/pasemi/setup.c        | 1 +
>>  arch/powerpc/platforms/powermac/pci.c        | 1 +
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
>>  8 files changed, 10 insertions(+), 2 deletions(-)
> 
> Mostly minor nits. Otherwise largely looks ok to me.
> 
Thankyou for the review.
>> 
>> diff --git a/arch/powerpc/kexec/file_load_64.c 
>> b/arch/powerpc/kexec/file_load_64.c
>> index bd80c5fb1b1f..8d4d6a51c046 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -204,6 +204,7 @@ static int add_usable_mem_property(void *fdt, 
>> struct device_node *dn,
>>  	if (snprintf(path, NODE_PATH_LEN, "%pOF", dn) > (NODE_PATH_LEN - 1)) 
>> {
>>  		pr_err("Buffer (%d) too small for memory node: %pOF\n",
>>  		       NODE_PATH_LEN, dn);
>> +		of_node_put(dn);
>>  		return -EOVERFLOW;
> 
> Instead can we use goto out and use the common cleanup defined in this 
> function?
> 
Agreed.Will fix in v3.
>>  	}
>>  	kexec_dprintk("Memory node path: %s\n", path);
>> diff --git a/arch/powerpc/platforms/44x/iss4xx.c 
>> b/arch/powerpc/platforms/44x/iss4xx.c
>> index ef883d97fe15..ef92b4656d17 100644
>> --- a/arch/powerpc/platforms/44x/iss4xx.c
>> +++ b/arch/powerpc/platforms/44x/iss4xx.c
>> @@ -74,6 +74,8 @@ static void __init iss4xx_init_irq(void)
>>  #endif
>>  	} else
>>  		panic("Unrecognized top level interrupt controller");
>> +
>> +	of_node_put(np);
>>  }
>> 
>>  #ifdef CONFIG_SMP
>> diff --git a/arch/powerpc/platforms/44x/warp.c 
>> b/arch/powerpc/platforms/44x/warp.c
>> index 6f674f86dc85..49afd60b1c30 100644
>> --- a/arch/powerpc/platforms/44x/warp.c
>> +++ b/arch/powerpc/platforms/44x/warp.c
>> @@ -183,6 +183,7 @@ static int pika_setup_leds(void)
>>  				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
>>  				       led->name, error);
>>  				of_node_put(child);
>> +				of_node_put(np);
>>  				goto err_cleanup_pins;
>>  			}
>> 
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_8259.c 
>> b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
>> index cb00d596ad80..9b7283038892 100644
>> --- a/arch/powerpc/platforms/85xx/mpc85xx_8259.c
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
>> @@ -52,6 +52,7 @@ void __init mpc85xx_8259_init(void)
>>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>>  	if (!cascade_irq) {
>>  		pr_err("i8259: Failed to map cascade interrupt\n");
>> +		of_node_put(cascade_node);
>>  		return;
>>  	}
>> 
>> diff --git a/arch/powerpc/platforms/86xx/pic.c 
>> b/arch/powerpc/platforms/86xx/pic.c
>> index 9ca36de23532..4cbcc16b1009 100644
>> --- a/arch/powerpc/platforms/86xx/pic.c
>> +++ b/arch/powerpc/platforms/86xx/pic.c
>> @@ -58,6 +58,7 @@ void __init mpc86xx_init_irq(void)
>>  	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
>>  	if (!cascade_irq) {
>>  		printk(KERN_ERR "Failed to map cascade interrupt\n");
>> +		of_node_put(cascade_node);
>>  		return;
>>  	}
>> 
>> diff --git a/arch/powerpc/platforms/pasemi/setup.c 
>> b/arch/powerpc/platforms/pasemi/setup.c
>> index 7a961f2a228f..a82855752e58 100644
>> --- a/arch/powerpc/platforms/pasemi/setup.c
>> +++ b/arch/powerpc/platforms/pasemi/setup.c
>> @@ -272,6 +272,7 @@ static __init void pas_init_IRQ(void)
>>  	opprop = of_get_property(root, "platform-open-pic", &opplen);
>>  	if (!opprop) {
>>  		pr_err("No platform-open-pic property.\n");
>> +		of_node_put(mpic_node);
>>  		of_node_put(root);
>>  		return;
>>  	}
>> diff --git a/arch/powerpc/platforms/powermac/pci.c 
>> b/arch/powerpc/platforms/powermac/pci.c
>> index d71359b5331c..8bc56a70b4c8 100644
>> --- a/arch/powerpc/platforms/powermac/pci.c
>> +++ b/arch/powerpc/platforms/powermac/pci.c
>> @@ -938,6 +938,7 @@ void __init pmac_pci_init(void)
>>  	/* pmac_check_ht_link(); */
>> 
>>  #else /* CONFIG_PPC64 */
>> +	of_node_put(ht);
> 
> After this reference to ht, I think we can drop __maybe_unused during 
> ht
> declaration. I guess it must be added since on PPC32 it won't get
> used and so compiler could complain for an unused variable.
> 
Agreed. With of_node_put(ht) now used on both PPC32 and PPC64, the
variable is no longer set-but-unused on PPC32, so the annotation is
redundant. I'll drop __maybe_unused in v3.

Thanks,
Jyoti Gupta

