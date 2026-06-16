Return-Path: <linuxppc-dev+bounces-22697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC90DCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:20:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfjfk44JBz3brH;
	Tue, 16 Jun 2026 20:20:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781605214;
	cv=none; b=J8T2DRfeSDOupkl/v2O/7G0OEzJCyLMROOE38+xHjQFLk+71eyr/bPxBokTh1jbKcZU16fG3CZA0cCrK2TJyzVK08DRG0sTRzqDXpXMH/K4MbajSFPMSKJXa4ncCTh2FXjw8tLs/mKKuE1NGKCINmiMBIcqibcj2hdQSssBPdmotV2GkG9clgZMc4bf79nWDNOcuhJxYluSZKf3LAllTiz9sbXxoMFL3fw/0DuiQY4U6uDDLyfw2Td4QhMzhJIm/+Ap4C/9JCFHYU8SI2Q0ZlhLyOgU5EWcTM0BbQb4JiyptmH+jIWpN/BvockkFaYlSU/MSUoTphQ6WUQlH4e5tag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781605214; c=relaxed/relaxed;
	bh=leZj3rK2dppKjVH7khAQagbiy4ZGSOxEnZls1iDMDSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdJCusommVaJI71483lqlZqWYmfHYL6Z5np2apWwZnCU7W7H/GFwEEn462dyC2n8mHTyTLZhuPdYL7b7BPwaSBbs7C646maR1Ow9Rz9JmB7DfZiCLK/WtA5kSPAZgjK+5ZZcMGN+M2dAfhO64WfUNaRLvS0SHaxN3www3k9KlKZiYiiKj8xpPSTL/p6CLWyUlHjWhbKsHf1ERHv3S/81PE4KrCyvVOeE4g+SBAnfgZnc/XfdeTnBy685ChVj6UsgBchZNybpo+TqV1Xqw62RILWBS8hvQyjtK7TrJ0juLCatn8m1xGQ7X+20Rb7R20yv+OFin/jNhAJ+d3LE0kjieg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U9fM0kXd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U9fM0kXd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfjfj1Mz8z30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 20:20:12 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZrk1135440;
	Tue, 16 Jun 2026 10:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=leZj3r
	K2dppKjVH7khAQagbiy4ZGSOxEnZls1iDMDSo=; b=U9fM0kXdvpXea56M2BNfVI
	CjUTXCk372SMGjwLiVdYAt5Yxq1YuVw+elw0XbgO8ff4uyNJfsg6s0SxQAZjjUqp
	+O6fAmQjr1e3q1QyxjQK+Rv8rSYtqTqPn6H1YIdPdyNYv+RIcDrtaaniw9IPiQmK
	1Ww4w4FKtxkk7bp4cyqqBYZLbm7vtg6uwmmhNUELmndfRCMrquvvLWpWOd8W29Tr
	LZZE842Q2Lmi9YdRAo0YOqmONxRBPBKaY+I+I7K23cz2xKt1sJcGs4lF3PQwXJN/
	K/mFw0sFtehNVAxrgZGHdR8O1h/hSKKaXvLrrBF8IlcTGAEtEgFKawIkNfg4quUg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0mjdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 10:20:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GAJxhf010380;
	Tue, 16 Jun 2026 10:19:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y2kh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 10:19:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GAJQHm3605208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 10:19:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B655B5805D;
	Tue, 16 Jun 2026 10:19:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B25B05805A;
	Tue, 16 Jun 2026 10:19:52 +0000 (GMT)
Received: from [9.123.5.244] (unknown [9.123.5.244])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 10:19:52 +0000 (GMT)
Message-ID: <4e833bec-67ae-4b78-9a50-e1b9dec4029a@linux.ibm.com>
Date: Tue, 16 Jun 2026 15:49:51 +0530
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
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260609053327.61563-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ssxtHnp9XDQ82a9ERUY-Y7uqrOY5-PLM
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a312350 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=axLRmrs6qUeeLGenWJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwNCBTYWx0ZWRfX23ltbBjlvVhP
 Qt5ip716LpemTB6CjMgVzEJiGWWfTGMFXj3lpsIx+mb7ymMjAERmqYcENv1TP0O0Pph50ZxgxCx
 IoOUw4yThGVPZmpwyharEbyxJynUj8LjDuvB1G19MFL4mRBov1MvxjN1WgOJFXvI6S8PIvua9xH
 a0gXxa5Fytirw5o+SlxLDmmYyW2y5seWC0NQZnuGxxgmd11+K1L0jEmvVmPr6w41oHAW/XGn91l
 PAO6Qe7iqleWmBBEr+fURInQaH73UWZud+Rlx6nRNHh9CWlsazabzuSM04tjkqAcoPnN2jSCHtk
 +f0nzNSgrwGIEuYa4hXKaWZ/Ni9eQFBB+TYCmFPWICZK5DjnkPMiQEKPtGSGtQmTZKufj4qEulX
 qr68Q3Td7BXcH+dM41MDDYpsHSe2R88dB2PqDsYpTHS16evV6GsnEl8gMCmC1v5abV7KjwxfcpN
 WRintkREdL2mqjm6BEg==
X-Proofpoint-ORIG-GUID: QTAuDiPiDmHcO7D9oxIeAYTNcBDb7pC5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwNCBTYWx0ZWRfXzZ0ovuFU6wmS
 UcQOFEURU1QWeTqb6f73PiXzGuOo4aBkWxHVplotK9BeBkYTIP/4w/B+mR4BwDlozsrMHL69T1v
 OdzaOQxJeKn1nSNdyok4veE7cgBc+fA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160104

Hi Amit,
I have tested this patch and it is working as expected. Here is my 
analysis :

After applying the patch all the scenarios works perfectly fine and as 
expected.
i) Bringing up P11(Power11) guest on P11 host :

Guest lscpu output after bringing up the guest

   localhost:~ # lscpu
      Architecture:                ppc64le
         Byte Order:                Little Endian
      CPU(s):                      10
     On-line CPU(s) list:       0-9
   Model name:                  Power11 (architected), altivec supported
     Model:                     2.0 (pvr 0082 0200)


ii) Bringing up P10(Power10) guest on P11 host:

Guest lscpu output -

   localhost:~ # lscpu
   Architecture:                ppc64le
     Byte Order:                Little Endian
   CPU(s):                      10
     On-line CPU(s) list:       0-9
   Model name:                  POWER10 (architected), altivec supported
     Model:                     2.0 (pvr 0082 0200)


iii) Bringing up P11 guest on compat P10 host:

KVM guest fails to boots with P11 PVR when Host is in P10 compat mode as 
expected -


Calling ibm,client-architecture-support...qemu-system-ppc64: warning: 
kernel_irqchip allowed but unavailable: IRQ_XIVE capability must be 
present for KVM
Falling back to kernel-irqchip=off
error: kvm run failed Invalid argument
NIP 000000007daf9790   LR 000000007daf1b7c CTR 000000007daf1b44 XER 
0000000020040000 CPU#0
MSR 8000000000103000 HID0 0000000000000000  HF 6c002000 iidx 3 didx 3
TB 00000000 00000000 DECR 0
GPR00 8000000000003000 000000007e581e20 000000007db26c00 0000000000000000
GPR04 0000000002e10c80 000000007df80000 0000000000200000 000000007df80000
GPR08 000000007db6e5d8 000000007e66b5d8 000000007db6e5d0 0000000000003000
GPR12 8000000000000001 0000000000000000 0000000000000000 0000000000000000
GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20 0000000000000000 0000000000000000 0000000001883676 000000007db21cc0
GPR24 000000007db66000 000000007e66b508 0000000001883676 0000000000000003
GPR28 000000007db6e5e0 000000007db224b0 000000007daf274c 000000007db76000
CR 20000402  [ E  -  -  -  -  G  -  E  ]     RES 000@ffffffffffffffff
  SRR0 000000007daf9790  SRR1 8000000000102000    PVR 0000000000820200 
VRSAVE 0000000000000000
SPRG0 0000000000000000 SPRG1 000000000000ff10  SPRG2 0000000000000000  
SPRG3 0000000000000000
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  
SPRG7 0000000000000000
  CFAR 0000000000000000
  LPCR 0000000000020400
  PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000



iv) Bringing up P10 guest on compat P10 host:

Guest lscpu output -

   localhost:~ # lscpu
   Architecture:                ppc64le
     Byte Order:                Little Endian
   CPU(s):                      10
     On-line CPU(s) list:       0-9
   Model name:                  POWER10 (architected), altivec supported
     Model:                     2.0 (pvr 0082 0200)
     Thread(s) per core:        1
     Core(s) per socket:        10
     Socket(s):                 1
   Virtualization features:


Please feel free to add:

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you,
Anushree Mathur

On 09/06/26 11:03 AM, Amit Machhiwal wrote:
> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>    KVM-NESTEDv2: couldn't set guest wide elements
>    [..KVM reg dump..]
>
> This situation should be detected earlier and rejected by KVM. Without
> proper validation, if userspace ignores the error, the guest may continue
> to boot in Power11 raw mode on a Power10 compatibility host, which should
> not be allowed.
>
> Introduce a validation mechanism that detects unsupported arch_compat
> values early in the guest initialization path. When an unsupported
> arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> checks this flag and returns -EINVAL, preventing the guest from running
> with an invalid processor compatibility configuration.
>
> With this, when a Power11 arch_compat is requested on a Power10
> compatibility mode host, the guest fails early during boot with:
>
>    error: kvm run failed Invalid argument
>
> This provides a much clearer failure mode compared to the previous
> behavior where the guest could boot in Power11 raw mode (if userspace
> ignored the error) or fail late during H_GUEST_SET_STATE.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v3:
> * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
>    vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
>    PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> * Added Reviewed-by tag from Vaibhav
>
> Changes in v2:
> * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
>    userspace ignored the error, by adding validation in kvmppc_sanity_check()
>    to ensure early failure during vCPU run [Found the issue after posting v1,
>    also reported by Gautam.]
> * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
>    fresh reviews
> * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
>
> Changes in v1:
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>    - Based the PVR validation on cpu features
>    - Fixed hcall name typo
>    - Stable backport
>
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>   arch/powerpc/include/asm/reg.h |  1 +
>   arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
>   arch/powerpc/kvm/powerpc.c     |  4 ++++
>   3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 3449dd2b577d..7472b9522f71 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1356,6 +1356,7 @@
>   #define PVR_ARCH_300	0x0f000005
>   #define PVR_ARCH_31	0x0f000006
>   #define PVR_ARCH_31_P11	0x0f000007
> +#define PVR_ARCH_INVALID	0xffffffff
>   
>   /* Macros for setting and retrieving special purpose registers */
>   #ifndef __ASSEMBLER__
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..f9380ef65750 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>   			guest_pcr_bit = PCR_ARCH_300;
>   			break;
>   		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>   		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> +				arch_compat = PVR_ARCH_INVALID;
> +				goto out;
> +			}
>   			guest_pcr_bit = PCR_ARCH_31;
>   			break;
>   		default:
> @@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>   			return -EINVAL;
>   	}
>   
> +out:
>   	spin_lock(&vc->lock);
>   	vc->arch_compat = arch_compat;
>   	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
> @@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>   	vc->pcr = (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
>   	spin_unlock(&vc->lock);
>   
> -	return 0;
> +	return kvmppc_sanity_check(vcpu);
>   }
>   
>   static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37..98de68379b18 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>   	if (!vcpu->arch.pvr)
>   		goto out;
>   
> +	if (vcpu->arch.vcore &&
> +		vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
> +		goto out;
> +
>   	/* PAPR only works with book3s_64 */
>   	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
>   		goto out;
>
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce


