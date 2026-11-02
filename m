Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAA606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P2qMmQj5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ5NP2dTWz2yST;
	Mon, 02 Nov 2026 20:03:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793610229;
	cv=none; b=WbH9i38bC3IRMCvDLLD8MU6uxMgscn4a7HUlcpU4rA5vCfMgZSPDzKUD+Y1OTIZU6PB5I4woO5OFIgmfyE6CHbWwaIZTXrje5IbZabIPpiQkK9UPYcuRh3+yVeUX1/cO4wQ1Cr6nWuAVgwXebZvvIOmtE8KJ4JFTxnKOeX1E07Ekf71X8fodedvnrycFJQlrEAC0CnL4knvvbegiYSPxjr48EKyZIuFt7l2pAPad7/79wR6pVnc1wTbTtJdEe2SKjWca7/42aTFZk138nPe5X3mZ5116Vwlvm0x6S7SksWo25p1sfWFRTwP4IgwADyJIAzKx2tRoIKN4hRhgNnBp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793610229; c=relaxed/relaxed;
	bh=m1zvCruayUhHboin3zC+yeWKCtDoDEDlkJlz+MHWjfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf2f/26iKCUPyd01LDMzC/tvMwLwDH07b69BX6pg20I+o5f6LYypWoHvDg0JwuYrdTbsuOYGfXwKgDNOATvqUGcfDEROalV6NjRd8r4Gq3I3uX4psmMb7lyyA2ZHA/bSjTxLt717VshMa2n1kVubt5Ijn4BK39wHlqmYbJMZoKH0lN+r/oa5PTyWMJ+EmOncR/+Lk97iDPflwECuZj5qTzYfCQz+mmehKP8u6TXqnwhe97GjkRogt/rNbEBD+7iliAi2oaA9zrmQGE7KkiIyidgCLXdb56BklZjv+dOYSg1qwT0EQCeW+mS6nF36+UB7Hw68uknfuGiBBC36ee3gTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P2qMmQj5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P2qMmQj5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ5NN2L7Qz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 20:03:47 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24E9DQ1880646;
	Mon, 2 Nov 2026 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=m1zvCruayUhHboin3zC+yeWKCtDoDE
	DlkJlz+MHWjfE=; b=P2qMmQj5Mqym9+ZivkqWoVAfzTUqqO7waB32STjEB5nQuj
	oPVSJIjT6InF6xqTvyxXix1NJ8/Ld5FU86dRQb04mz+6jdegN9qmMK1azFegA+Pg
	37DjczyG7MyVSFsw/M0Izy+bj9oM4wYYns+Rn5p4CMEV0U7pl940wRS2k5vxzKZO
	d+9upI+EE5ME5moOYPEA7C2ZFK4eczk2FlSnzgT135xWdL8Ew0ZtdOxd/TCl5XQ7
	GyDw8WwwDlYx0bBGm9z0oX9Ek5NvfXZnw1LYdwAAtduC/H5/QOr6T8HU7mNEOPBB
	wkq44hgGivsDQSAPtMHzsHul2Z6De4dWBHlxk2gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826fksk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:03:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28El823364311;
	Mon, 2 Nov 2026 09:03:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfmvr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:03:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A293XgB29753720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 09:03:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9ADF20040;
	Mon,  2 Nov 2026 09:03:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88C0920043;
	Mon,  2 Nov 2026 09:03:30 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.25.78])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 09:03:30 +0000 (GMT)
Date: Mon, 2 Nov 2026 14:33:27 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, nnmlinux@linux.ibm.com,
        amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <auhH-WvGCCyH3bpT@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261005084534.1588611-1-gautam@linux.ibm.com>
 <4ie3w72g.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ie3w72g.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0XLex7mZ7na53NJdxB24aY6HhzAUWF-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfXzOzK/Dv8md67
 HOrl+VHRLB/K0FFNPeWiuDrA8ViFEdVY7/wOYgXe3IMoxq9AF6kNk8ZxRjF41gKUGF7a84WI7U9
 ivQX+vUqrj6Z/NlQh8L7w/DHO685b23nofohdrJVudHqTIQzskFmhn1aTVYhPZElN2A6RvGesij
 8yUzSh0bOuyUa40S8Zz05ZS0O5thwFAElN4Q48T3fr3Y0zt6XXCktGLmapyUL3PX0OBlxSks+Ks
 NcYpVIzCmGg4VQiulxUxkEW2j/3B3Ekjy5AvCoz9TeQ0KGvEIr27T2/WMiEvUgsKLXUQWRdk3H/
 u1Uvf5xrUYUzZjw8iGjm3/TMC7dh/iwDsazH8MNGQLaT/Pv2SF+jc1yJYwhK70+4QSlrcFkBXL6
 QK+0tfbOe1s/maclj6bvaGNM5gQUIPVMDIDHjUdvnIom4quVXwa0uxKYvuJzVrpymdicnkFCPEr
 9tWYxFdiLl+v97U4eNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfXzIokJFQevH8F
 ucgQW+IpH5BUC2ImAmukgOEDyeqTp2INlrS0oTRv+cIBKglF8ifrWAM5sAE0r6E5NGZnEqehuoV
 2UPqNPY/XDnioE2jeqUm/TYUnhWJ//o=
X-Proofpoint-GUID: BVQJacYERLayZ0Ufz2Rlq9C92b8wglK4
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae851ea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=VnNF1IyMAAAA:8 a=_AprYWD3AAAA:8 a=g82gFZNCn_a7IaLBBk8A:9
 a=CjuIK1q_8ugA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020034
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 08:48:15PM +0530, Ritesh Harjani wrote:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > A huge number of spurious interrupts can be seen immediately after a KVM
> > on PowerNV guest boots up in XIVE mode.
> >
> > $ cat /proc/interrupts  | grep SPU
> > SPU:     223705     192439     273526     147623   Spurious interrupts
> >
> > This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> > Handle pending exceptions on guest entry with MSR_EE"). The root cause
> > is that once LPCR_MER bit is set, it is supposed to be reset by
> > software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> > not exit back to the host until the decrementer expires or there is an
> > hcall, etc. This is because KVM on PowerNV guests have support for
> > native XIVE, so they are not dependent on host for interrupt emulation.
> > Due to this behaviour, a huge number of spurious interrupts are seen
> > since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> > vCPU exits to the host.
> >
> > Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> > available (currently in case of KVM on PowerNV only), as the XIVE hardware
> > can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> > functionality is not required. This reduces the number of spurious
> > interrupts drastically.
> >
> 
> Make sense. 
> 
> > Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> > Cc: stable@vger.kernel.org # 6.8+
> > Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> > Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> 
> 
> > ---
> > v4:
> > 1. If interrupt mode is changed to XICS during guest reboot, MER should
> > be used. (Amit)
> >
> > v3:
> > 1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)
> >
> > v2:
> > 1. Handle the case where xive_interrupt_pending() is true and also the
> > external exception bit is set. (Narayana)
> >
> >  arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
> >  arch/powerpc/kvm/book3s_hv.c       | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad..9178406dc365 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
> >  }
> >  
> > +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu)
> > +{
> > +	return kvmppc_xive_enabled(vcpu) && vcpu->kvm->arch.xive_devices.native;
> 
> I was checking the code and I am not sure whether we need to also check
> for "vcpu->kvm->arch.xive_devices.native"?
> 
> Can you explain why do we need to check for xive_devices.native pointer
> to be non-NULL? Because if we don't need this then it simplifies the
> code as we can directly use kvmppc_xive_enabled(vcpu) helper.

Yes you are right. I wrongly assumed that kvmppc_xive_enabled() returns
true when kernel-irqchip=off. I was printing the logs for
vcpu->arch.irq_type for every scenario and I guess I must have looked at
the wrong logs when I wrote this solution. Will send a v5.

Thanks.

