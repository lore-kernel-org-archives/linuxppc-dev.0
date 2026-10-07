Return-Path: <linuxppc-dev+bounces-28992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB8ACA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 11:37:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0B252Z1Dz2yqf;
	Wed, 07 Oct 2026 22:37:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791373069;
	cv=none; b=JOgAJug4g9CHCZPq4JYLGFwuzqgtc0PEDFGQ2PxH/2KOnt68DNI+skCBD0RH0SI3OB+qDxHzEIvUetokjwab1hXeWjkJs4USiqd8AkICXuoRqx3Y7p0ROP6+jTfbmGHTF1wa15s0b4BKYJF+OjVBcJpVGItTdVq6MmtHohOnBWuRwGdeclFdM0Bz0u/9ARVux4KsFG0NSUAQ2pObxJu9GTGCajAoFYZYpJNnMyvxot5HxshEMX71p1M7G3AcCBn2jOBPhJmt99+guf3Acskvf6cRWpLhHnf6tvwPpm+5e4dfkeCKSJtmDWP0H/pE9zzNEEV5cvAMb3iE7eYHgI0cYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791373069; c=relaxed/relaxed;
	bh=U/J7UOjBO+z1O2eac4K91s9ZfPCzFoXrwPCeiQFPIiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE+QOcSLkJu9ZC72bhHwwUDxEHSL9g7RU8PxryJp7Smm+J3WDn4MpyBNoNWtyf0i968Js6sdZS9U2TMtAjEsweGYkyHBl/Ksi3J24qzdcl1VqOiDi+4+I0UijAa87OP18fEQbxgrGBh5A6I27ab2Dzfr2bU9Z7A7AIFi5E+OrgeqkBun08xeoTb1/rhZZY9GaYNe6myB22+C9qWKwFb+6jLUVQV1zQIXzoPDSmSnn0dr64CVZuhJfclzefoUvulU2mPCBU+7OihEzVV2eVVnqnmTWHID696n8LBYWAxobfcNx0oOwH2+/EkaORqnaW99Bby84Vj+3hpQwcWS9V2h8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ER0YVywq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ER0YVywq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0B235t9yz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 22:37:47 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZu9n596963;
	Wed, 7 Oct 2026 11:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U/J7UO
	jBO+z1O2eac4K91s9ZfPCzFoXrwPCeiQFPIiI=; b=ER0YVywqxK0YtFzSyFtqFX
	zvShGb5yhxFsC7Hooi4U/Ao3UeKF0+h2vaE/fF8BrYhKsGpYlippfqriJpUS1zcl
	L4yrK3bekUhFYfrgw8IswDJM2wTm1ffSWPak9urjdMNcezLGpf+bDG5JHcA8QvOV
	U9rdX7N7KwuqrcL5iECCF68VkCisPqfWVuSZJuMuHggXK3JcgjVql5JXbb2jPEXK
	kPaecbFL2DY7gfxYmYU2a2xLE7izekAJeer1u243hB7Q24Lf4JhwZOsRi+lDFdxk
	Oo4VJ6WTnZnNNvN8Y73+JhaD/wM0+QUelZWCszflk/DPv9ksIkE3aeJk7L8IQvVQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn4r4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:37:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWjbE1810474;
	Wed, 7 Oct 2026 11:37:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek2jj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:37:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BbNZd47907184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:37:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35BF2004F;
	Wed,  7 Oct 2026 11:37:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 621AA2004B;
	Wed,  7 Oct 2026 11:37:20 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 11:37:20 +0000 (GMT)
Date: Wed, 7 Oct 2026 17:15:33 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v3 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
Message-ID: <20261007170655.b1f708f3-a3-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com>
 <20261006122404.99358-3-amachhiw@linux.ibm.com>
 <33uirq33.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33uirq33.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX3ELaW9YFj06B
 K9jBcOggloVYdHHMEeqDwa5jyqoDFmdOH4EKVHtbKfVPMpdxpxT9KjdPj0sIz2Xx1R3zNfta5LX
 7CYWW4yC78PWpWs6cV9K6ksSxpVHuc0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+E8Gu4yeryb1
 cLZSYgixU0RjHF9FZ/5yq3At2ANdFO4rb0DUkQio+aZxD/340skm/wUD3/1gcAG614VzDwh7vel
 1tR1d2wXfh14INb/wrBRfbioO+elMQmAvSslFGbd1qBYSmi7+HpqEwZizye2XKQ3m+XHMGdGDdc
 reyMCEBTwthnO+YUTLOxy9b52lIhQt9zSsh2+ALUypfZIuhQa25QYQ/+7SpHrTtRLCutVY4UmkN
 nbsxSv8bKfpn23Yla8q7i2+4gpLrP0NZ9w0Q+5+hG9sAiOk5dgRptm5l7LF+JQDKfAfFL03lXgf
 HxaZwHFvsojTsqHwkDX2KPFP52zk73WKjUP8oeRyrVrTlPtnW8Z0CCV0dkIgMfmBM1BMgedN6w2
 YKKB4vLGPkh+jkZA5k8m6MIRDdAl8qnd6i6LYVkoCZe01Kf0NlcRtiX0dc9dQB8YzvbY8/BN4W5
 tsmiqtuvXHqijJb106Q==
X-Proofpoint-GUID: bWhzxpoiFASM_oZAM7Szog3BGiLSTYPF
X-Proofpoint-ORIG-GUID: ze2oYH03kqgP9MBogkzN9Fd40RXx2zsn
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac62efa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=UN1UOqkggNs2FiOLugQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

Hi Ritesh,

Thanks for reviewing this patch.  Please find my response below.

On 2026/10/07 11:48 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> > preemption disabled, because it can return with HPTE_V_HVLOCK still held
> > until the caller later unlocks the HPTE.  Existing virtual-mode callers
> > in book3s_64_mmu_hv.c already follow that rule, but several paths do
> > not.
> >
> > kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
> > data-side and instruction-side faults after guest exit with preemption
> > enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
> > handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
> > handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
> > H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
> > H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
> > kvm->mmu_lock.  That raw lock choice is intentional because
> > kvmppc_do_h_enter() is also called from real-mode paths, so the correct
> > fix is to establish the proper preemption context at the virtual-mode
> > caller boundary.
> >
> > On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
> > kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
> > HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
> > enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
> > resize respectively.
> >
> 
> I was going over all the callers of lock_rmap() and try_lock_hpte() on,
> and I see that we might have missed kvm_htab_write() path...
> 
> ... after spending sometime looks like we need this diff for
> kvm_htab_write() path as well, since it calls kvmppc_do_h_remove() which
> calls try_lock_hpte() and lock_rmap(), although the race window is much
> narrower and maybe very hard to hit.
> 
> But still, could you kindly look into this and if needed please take it
> forward too. Please note that this is not tested, so hoping that you
> could take care of that too.

Thanks for catching this — you're right, that was a genuine miss.  I will fix it
in v4 by introducing kvmppc_virtmode_do_h_remove() as you suggested.

One small divergence from your proposed diff: I retained the full flags and avpn
parameters rather than baking in 0, 0.  The flags field carries the PAPR-defined
H_AVPN and H_ANDCOND conditional guards, and a future virtual-mode caller may
legitimately need them.  Baking the constants in would silently prevent that,
while passing them through costs nothing.  This mirrors exactly how
kvmppc_virtmode_do_h_enter() is structured.

I'm in the middle of making the changes and testing the same.  The v4 will be
out soon.

Thanks,
Amit

