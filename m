Return-Path: <linuxppc-dev+bounces-25719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B536EC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJzm91mMCz2yvG;
	Tue, 11 Aug 2026 14:53:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786424025;
	cv=none; b=VQ5/ZBzgnO1otnA7IASMSCuFPCzB4Gmu5YGUCFL0nS5dAIIQrrDYK6VxLxiAhPlX8mTTxVOceptXbD1r1SLSe1NI5OqcYUfbjSeA2oqoqCcZO/E+i4qL+9fdFJWOUM8Z+hEKzJI4X9PnUd6GEhpJYQNrgbbX0Xg/qKxhmD20PehUxpDGvgOVuPN3BL71hQW9hdJAlYNEvXkAXMM2Y/d4v70E5X8SF9NYRfRF/BwmhATDO4T+QtUAyfjSJoBHf9017azOuHUdUcWHeHGPlU+UQoqTBvVbKuYaW1ab1HfrR4BNyWP5eyi4YqJC0TrBOdCsmKCFELchMN76FooO3E2/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786424025; c=relaxed/relaxed;
	bh=uz20XDLJ01Y33lENru859JzA8c0KdEFgFXjsz3QA39w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMoIxSUVU1RrYqotGpl7+MnTq39cqDxKfyOmCc8yFeqgrqKBrqQCJ9YEt1Xk0R1pZAAc6jgCezUHWVVqoT2thQFtBoKPrDK4CD/O33Mqlu+yAyJSWL6On4Sol4qL4577hMW+oT5sxKIASs6ky3wLu6rBFLgElnwNbJh6oSlMVI0SyDwTFuLHZufwfv31YBjerWHzuI1MbIicxDVvRvDwbDE4R42ddZk8FJibaG7o9SJ++fwOVlq09eHKLdG7AFWDSsHT/5rdJ+xC95aIlAVfgkU+wgqyH9eB+riEbM+IXF1352gfquCZG1BeHfCQ1S+lwms7MMYsz3n0YUJaqOx3Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gy9QzwTd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gy9QzwTd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJzm82cxkz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:53:43 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1anN2999512;
	Tue, 11 Aug 2026 04:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uz20XD
	LJ01Y33lENru859JzA8c0KdEFgFXjsz3QA39w=; b=gy9QzwTdg2DogRibWkmjO7
	gQeH7jTlre3WnTugCjxdxzNZU1ocIDE/cJRvgC0a9AI3BKJmlDCM3aT4pEEftecn
	UGNV4y7NWpX/LiobkjmnnkABbyLGa7wiSAGJvcf7wVkO4bQxoIjD05eHlMnF9rLm
	nF1HZxWW2W51cSI5yIz1BTla5QgTAta4HIuZc/GM0aLnKi9ft9F1bfHTJXUEcsvA
	tHvMW+VNbHepWqRhBAQoRnPdQCcnc/8VJ2BiXH95qjoh1ApbQt5jwy28aSGZ62SS
	HexgLnoAOd1zl9pdZafP7OLphez8ViM6JBMas0IvbXNVMrlwQCb338HnJntST50g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw2qym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:53:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B4fOut029529;
	Tue, 11 Aug 2026 04:53:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxyc62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:53:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B4rRrq9961908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 04:53:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E2A520043;
	Tue, 11 Aug 2026 04:53:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2066C20040;
	Tue, 11 Aug 2026 04:53:22 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.82.57])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 04:53:21 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
Date: Tue, 11 Aug 2026 10:23:20 +0530
Message-ID: <178642395406.173296.2879693080941807837.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260808161148.66673-1-amachhiw@linux.ibm.com>
References: <20260808161148.66673-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7aaacc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=BDvn-t7a7rEMPqDFjeMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LA6sxo_RISA67hFYdRaOcN7AXdgANatr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAzNSBTYWx0ZWRfXw0ry2qiISU9z
 49OfTxVCoBsf8kvekQQgmR8+y0VzUO4+E5+nk9tJj0RiIkI4AwNcPH/jdsoi75WYbAN7Baocdrz
 rZJG9kpOW41UOpFwbvUaByM6L3+aDoctT0dhIvL1D9GkH8pi+Urv7+b8yYjN6RxDGdpWKh79XSZ
 kijkk8MRllEEQqvCbd5LciiJL7u6bwqe7Co3ZFagJDjMi6618MqT83YwamB/VqZOCmtcyFUYStP
 av6ckDEKqvB4mrKU+J7UvpDvLBQLKoIv3/ffVE03Iow8eXnvqnNVpPC4DpeeMqkeAfRoA/0aD3d
 kMoI2t74vAIBZz5N4cmU/vYS0RZ/1K1K/aKn/j4eV6cjTkttJQtGCUz+G7XCA06niQZs72jsvyq
 ppAZlzbZhy6saSWIvx3NRj7o/S5kxzzOH/mcEHeJoPNT1dQd8u9y7pIv8zN8AjctFldmqE504SL
 VADKv/8LmImqaFowJuQ==
X-Proofpoint-ORIG-GUID: YER50ExlspIYVf_Aop3_3rI5pD7C4iSZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAzNSBTYWx0ZWRfX0ZQEAAwLF04R
 4IGvQD8K76Dm0Ci2t/OFVOIZcyUf/dJKH9C4YI6HJJ41PRKVHc+2OZs0Sxks6FSR5MTsX0oJQCc
 ZaXJ75gUVaQvq0Wrrbs1zyzT7iSDpuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110035

On Sat, 08 Aug 2026 21:41:44 +0530, Amit Machhiwal wrote:
> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
> 
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
> 
> [...]

Applied to powerpc/next.

[1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
      https://git.kernel.org/powerpc/c/ac3e65ddddf3128c1f0c2187889fab458fcf4a70
[2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
      https://git.kernel.org/powerpc/c/b76fb087efcdaf6eb5c2c6c5e53c763640fc4b02
[3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
      https://git.kernel.org/powerpc/c/8735048f54ec827102dcbd757a6c1c1e02613fc4
[4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
      https://git.kernel.org/powerpc/c/c1721e584244ff79a593d6f0ad0405a2e07b765a

cheers

