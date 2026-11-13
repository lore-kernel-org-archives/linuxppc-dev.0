Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE4606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lj4NdmBV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQq7x459dz2xnh;
	Fri, 13 Nov 2026 18:46:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794555981;
	cv=none; b=BC0FDFWCHh49c4gnYxsTU8wsXY5hvA1oN19WkeGfifhgdwNjdo7uw7tLwa3ExheY7A7VX3xgYdJ/raujcG0DZJ8WsFsczFpZxjX8RLwgdt15j17X5HIeD4KMwMRYd/mPAlOMcXrPEMGpRE1AVlz8wmOBqsDBD6a1C0Y9EtDBmLZZCJdRWoCH8xY4me4N6OMvQyZGPPbiQpCvg7B/2nBDFdAM5B131VLsIqsdMTt/4YpVRs1f5W8GcO+/DfyPlzE6rD/62ij+9xazOlXQiVSofe64v5MG2pPH4mA3fMArIrWLWt175niAfkAWIb+WS/zDdUi+9oPaK2U41SIXvCv/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794555981; c=relaxed/relaxed;
	bh=NNFrSaFiZGWo2MAIc2ZSt7Lu2TpA/9uN4I2ONI0kRdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGZH8F9C17Lna/Lj0fe/VEwkptZ/JoUNdEIG5efJszM+8ARtgwC/leGlMJ2myZul1jRY+Hzv1D7t78uX4oAOfVZRtLm6ZaAAoNliw0U/VF3Oz9jhGLF4UoVlULIrBd8Gp5hRkW7UJae2RdQRx3yM7gXqoDIl8iiCwcmiGawpOgF5taWYInfj/7TiVx81degus5bAbl6bGv8jxiRF4Lcs0Y3CZbT6o/NE1zFfEEedqLRQOWSE8itemtcvePYPuctFnqu6C8gcDf3+oydbswNHX5enb3fMBUYnONDPXaLRTNcoBavG5raw4uNqULZgoeNfdqdz+zAanZn+TZVBAZeHmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lj4NdmBV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lj4NdmBV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQq7w1mw9z2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 18:46:19 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD7FiZf2173333;
	Fri, 13 Nov 2026 07:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NNFrSa
	FiZGWo2MAIc2ZSt7Lu2TpA/9uN4I2ONI0kRdU=; b=lj4NdmBV164u8ztpib3Doj
	OLDlVAF4g/jTBETmqbRhuOXp8OPa34EgnDvTaW8j3pZQ3XSKptcWIimWAFx1DaOc
	VTxMobayKgOqtH8ncF4JlfIi+7b8PNdclF/sl3ffvAdG5Wm99L3rA9NSyTF8cVQu
	wU+V79mycD6sJ989bzg+uO62cY2j9rYblDlynbQ1qsctHqO5W/Jouoe0nWHMqctJ
	1ABkhtgWd4m13hiKYJPsGueh3mjioiwQpCSwYbjt/6saNQExWsoweo+F8vVR76Xd
	FhlFKSWkSx1v40Afe0jSVlgCWn9SU4WH6MwlaCQ95FtFEJmfXFV2PAB7kBchjDsw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv94r1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:46:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD5KDJZ1776746;
	Fri, 13 Nov 2026 07:46:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85b6t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:46:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AD7k2Tn30147034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 07:46:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBBD920043;
	Fri, 13 Nov 2026 07:46:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D119B20040;
	Fri, 13 Nov 2026 07:45:58 +0000 (GMT)
Received: from [9.39.16.227] (unknown [9.39.16.227])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 07:45:58 +0000 (GMT)
Message-ID: <8a88f1bc-2ff5-4d6d-8f7c-1182b256d855@linux.ibm.com>
Date: Fri, 13 Nov 2026 13:15:57 +0530
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
Subject: Re: [PATCH v3 2/3] KVM: PPC: BookE: Load FP and Altivec before
 enabling the interrupts
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com, mkchauras@gmail.com
References: <20261112130913.4124175-1-sshegde@linux.ibm.com>
 <20261112130913.4124175-3-sshegde@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20261112130913.4124175-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX6fgTPRPDx9AN
 Jmipqjb8YSZHtegR7QmsfOx+znWRAPn0IzZCQzcx1Yb3mraWpRpHKf+DqA7jWsPBCHP6N0nbCgq
 MRjudsQnzbBCUYl9EsC/ClvQ+Qc06NA=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af6c03f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=7zvpPTbqLWkq6IA-fN0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O8kOlERyROXO3xBswdO-Z0TxPGYUQD1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfXxyxZfZezlFxr
 IVZI5Z/UPOltHvj+C8fiUvlpRFmgh9bCGgAzbjEbLK9kulv2PCllZfR+V2Uw/h0WwBI1CdmlSqH
 XmLQuVHcmlF9T5fMHD8qYpy8FALCWuGZAnMvM2iTKuLs47tnFh1ZUt4vp3k5JYN20EAF6IH5enc
 UR8MPgql/cj2eXqFSGm2rz3xNYGGsPtlfcXGYMdDjxEdz/DOGueUo17gwjuDCUggsEEs19QXMmk
 gbNeEK03QWOz6+JcHteiSLL38s9GNd6Rc/Nuvk1U2m92pDjss7T0rNGDviayoxUocFOW9mDKoBb
 m3vIFgbqJ2uk/dyaTDDG4AK0nWSNMPMIAoNNi4KRegmVJyiDmq007lBNYlDFi7IhMyt53Q4ZUJz
 wbbOTfIf3Dkibp4PVEfjpBat4uCI0fgCa5s5hSk31+5jF9wlZZYR+4J/KdWrwJcvEEUmCLQZKL4
 meFFxjeJjl2U/Wzla0g==
X-Proofpoint-ORIG-GUID: 1nyDaK8FP75mDiLpG1vaYqvVshQ8bL45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130030
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shrikanth,

On 12/11/26 6:39 PM, Shrikanth Hegde wrote:
> Christian reported that booting preemptible kernel on FSL Cyrus+ board
> causes boot hang.
> 
> The logs pointed that system was busy in printing below warning.
> 
> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
> Modules linked in:
> CPU: 3 UID: 1000 PID: 4884 Comm: qemu-system-ppc Not tainted 7.3.0-rc1-powerpc64-smp-preempt #1 PREEMPT
> NIP [c000000000003338] .enable_kernel_fp+0x30/0x78
> LR [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> Call Trace:
> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
> 
> Which is...
> 
> void enable_kernel_fp(void)
> {
>          unsigned long cpumsr;
>          WARN_ON(preemptible());
> 
> And...
> 
> Though irq's are hard disabled after kvmppc_prepare_to_enter, but
> kvmppc_fix_ee_before_entry enables the softmask's IRQ state.
> That causes the irqs_disabled to return false.
> Hence leading to the warnings.
> 
> Fix it by re-ordering the code to load the FP and Altivec
> before enabling the softmask IRQ state.
> 
> Suggested-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kvm/booke.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 13ad4cf5fa71..aed7b476b7eb 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1404,10 +1404,9 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>   		if (s <= 0)
>   			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>   		else {
> -			/* interrupts now hard-disabled */
> -			kvmppc_fix_ee_before_entry();
>   			kvmppc_load_guest_fp(vcpu);
>   			kvmppc_load_guest_altivec(vcpu);
> +			kvmppc_fix_ee_before_entry();
>   		}
>   	}
>   

This address my previous comment, feel free to add Reviewed-by Narayana 
Murty N <nnmlinux@linux.ibm.com>

thanks,
Narayana.

