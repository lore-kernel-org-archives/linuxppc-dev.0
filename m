Return-Path: <linuxppc-dev+bounces-27891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022F9C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 05:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpqDc52wyz2yHT;
	Tue, 22 Sep 2026 15:59:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790056768;
	cv=none; b=Lj01CbgXXJ0KwMWazbZ1T7jGpWRY4eQFVBn/DwK+RxPY9RVTrLXaddDaIAU5eFE1OuFVNxqfv8BTp6ycjFAXFc/pLU0luegKYK4Kb5aaD1CpcrYkHhyXZtex3MYPB2liFrcuM1AZBhDb+3GSVbAqWoQEL7y8WyLDobcvspO+Lo+LTo06S8xdtmM1NP/wVW50DkDKNnxk0bhqdUCvbOtwO/kaNTDzIHj+J8CgcqdXTW5ty7K0ocGpeKTFD/bMVw5Sfv7P+V9bqJ4PGkCUM0Yq/hKRnms8WP/OcAtmkwgn3/ueUYecGZS69pylnaAE+gwog2zpMdoMhW6vMUWpypgKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790056768; c=relaxed/relaxed;
	bh=/CgOOAFoHJJXq8KyAObLLcMnmhG5iWqYQKZpygX589c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbcZ9ztXISnafge3ZT4sSlJmejPFO2pmVdQ2K0Cfb1Aa+sqfgFeJnAzYOBEGZxv8fYe9DEDrttym9wWxt4Ny+eepuItaYPh4pCYYaDtWKTV+mm0Utvg4zqQgff9XHlvVxYB5RuEmAbV0MV41Gmgv2ZqbPdNexFguuRklNurhcJtqLWncdPl8A3GbutD2jY00updUFsdYry4mFGeBUmhTwjgV7K4Dv9jE+sKpY8xBWXnPY5oHbEr9cu7zqmXUvlaIK8baGcgXBdWQcn9uO9j6sZcibMFvQMw7iE18gFDj0u0V0bqDjlHZJ6xEcHEkOnPSJwT6D5m+NuhjnpfiSTo//g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jmGcaSdS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jmGcaSdS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpqDb3m4dz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 15:59:26 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M06N0r2982139;
	Tue, 22 Sep 2026 05:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/CgOOA
	FoHJJXq8KyAObLLcMnmhG5iWqYQKZpygX589c=; b=jmGcaSdSp5/a2s4vAd1li8
	OyoNRmQ4CSzozDg8ltJhVIaLEkw9kKs7aTHeVNODSO7yuj0gISi+Y4Hr8DyAeEWW
	hH8DF/cPluPCrpDtphMi1fASm//iDrFCeMAKD4RyZsvSy2BiJpok0yIhChLJ0Qr0
	q5EH9LCTvHfrkodU1M5ROIcYOPWtwoFPjM1Z51M88vcTYppBIYmAgbd5CtT3ncH5
	TQMWuF0e88BQt9s37b/gy2mGeiBpk9YjyK7yTmXf/gNR7nUFNcaE6yfByEPocrpz
	fSDfTzA6lk7FaR7xI+FrerVQ2KUHouzol3cYUm9VHyKVTsySo/Qg65BgOIJ93eQA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv3x9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 05:59:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5UjLG2085698;
	Tue, 22 Sep 2026 05:59:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq8n77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 05:59:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M5xHwf47383020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 05:59:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F3720043;
	Tue, 22 Sep 2026 05:59:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61AA920040;
	Tue, 22 Sep 2026 05:59:16 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.19.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 05:59:16 +0000 (GMT)
Date: Tue, 22 Sep 2026 11:29:28 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arIXVvCG1xipFnnt@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
 <20260921112538.ED7101F000FF@smtp.kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921112538.ED7101F000FF@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WDeimTp8R-6Ld2nIvyo7j80XWZb03_2F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA3OCBTYWx0ZWRfXxshE52VIu1nB
 b3a2uN2qaM6WwSpW/QKQWgg5DPfIwfyBY8ZFKcJX6Uzni5xMzm9uHMTyOfp9wTiwxz6nuip1zV3
 ghvfSoSQ7EWp5PEwqgv13113e6o3+Ac=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab21938 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=iDXJWKRIO_aAfW5byYkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=6M1ixcW_PCWoKiWyFx5v:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: WDeimTp8R-6Ld2nIvyo7j80XWZb03_2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA3OCBTYWx0ZWRfX2T5I6yil0jlD
 TJ2tRgC/SZLbS9o/qxHFi9hrx/m6Tm9UQ/zOnJhK2NxC8YjxZL/BNx6QN8EnXMc1+8jwaYdIIpb
 dnGqMnANvYiJxCs4Cc8I26ENcMkBElu+nUc1b3fFjQj6OJhmLrPRSRU+NZwdmerBJX9+adSTSOj
 lnpETUwWnmS+0KVTVQ2gucz1Qpu0aTZd3Vdah1TNlok9PBjOh1PRecCiSIm+E+t89pxAz6g0mUU
 BpeOIQ7DIVT6/dx/l9lfp8WG+f9ag6eTSO/ubbBLEK+LlQ3Ztbes7k06yefhTUKBAK5zmCxPtuj
 0JvIi+aLZ9ulWZQcqIkHy9GICCF0dqlqOKs0wYS6aPrjkwnU1pGylhfPs6/8t70XxOijX6p/i6U
 vlj0WpNCrTy4Lom3vdPXSzPhfh1hJSiopMFSNKcJN5M/i+I6PUSi/Y8Sd5Itmk0CeO6Zgq4DngF
 zfZRO8P4BQvXckhHAtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220078

On Mon, Sep 21, 2026 at 11:25:38AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: ppc: lost LPCR_MER interrupts for XICS due to XIVE state leak
> --
> 
> commit 215dda3f95780a965ce67c9c452b6f7d1948e486
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
> 
> This commit avoids spurious interrupts for KVM on PowerNV guests by not
> setting the LPCR_MER bit when native XIVE is available. It introduces a new
> helper, kvmppc_xive_native_enabled(), to check for native XIVE and skips
> setting LPCR_MER if it evaluates to true.
> 
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad4..580ad2548c2bf 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
> >  }
> >  
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> > +{
> > +	return kvm->arch.xive_devices.native;
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index dbac3573b2c89..cb2bb29451a7f 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
> >  				kvmppc_inject_interrupt_hv(vcpu,
> >  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> > -			else
> > +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
> >  				lpcr |= LPCR_MER;
> >  		} else {
> >  			/*
> 
> [Severity: High]
> Does kvmppc_xive_native_enabled() accurately reflect whether XIVE is currently
> in use?
> 
> If a VM switches from XIVE to XICS (such as during a kexec or CAS
> renegotiation), the XIVE native device is destroyed. However, the native
> pointer is intentionally not cleared:

The kexec case is not supported for guests - booting a KVM guest in XIVE mode and
kexec to XICS mode.

> 
> arch/powerpc/kvm/book3s_xive_native.c:kvmppc_xive_native_release() {
> 	...
> 	/*
> 	 * A reference of the kvmppc_xive pointer is now kept under
> 	 * the xive_devices struct of the machine for reuse. It is
> 	 * freed when the VM is destroyed for now until we fix all the
> 	 * execution paths.
> 	 */
> 
> 	kfree(dev);
> }
> 
> When running in XICS mode after this switch, kvmppc_xive_native_enabled()
> will continue to evaluate to true.
> 
> Will this cause KVM to bypass setting LPCR_MER, and subsequently fail to
> inject external interrupts when MSR_EE=0, resulting in a guest hang?

No. If LPCR_MER is not set, the only effect of that is the vCPU will have to
exit to the host for the host to inject interrupts into the vCPU. One
extra exit isn't a big deal.

> 
> Could this check instead evaluate the active vCPU IRQ routing, for example by
> using !kvmppc_xive_enabled(vcpu)?

kvmppc_xive_enabled() does not check for native/irqchip=on case. It
returns true even if emulation is used.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260921111043.49825-1-gautam@linux.ibm.com?part=1

