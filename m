Return-Path: <linuxppc-dev+bounces-22928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096DBCD98F2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl5Z53Hkyz2y71;
	Tue, 23 Jun 2026 23:31:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782221485;
	cv=none; b=e87WJMxXbm4ZXIZbFaYRHZEOkNNJNd5sAUhkgo73+E+1HIwOjNaiItXtBxph4/137aRHMFSonEASmPXrqpB5vkF102jX6ToYpLfR2zGdU8tAHUSxOLxIoIm4Eud18ITig7MomFaPEKTWl4l+5qKfBuv6zGhGDKaTS9j5BbWncZcSkcLxtEmPx0ryNVK6rELFWjVf/MRsUJdCB1FP2L2k8zHKbRnmAza9vYTqfCoAQko/Rnm9/iab9Qq3tE5nCwevPpyGwQ8JZdr0RYUHmK5sIbawrJDLhyOdhQWpfmNpI/NcFt9xQhKuICYtf8IKNS87pSqMg2Y4bBzZ8OLIDGyh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782221485; c=relaxed/relaxed;
	bh=dr6MM2lRuKJstCiaPb90WhPj0j9hFXb3KiqDaaE/Wdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnMtwsJwaEYufdLi+d8XUuf0m8gr9kb3E/GMkmArV0IRajvLMJLf9zzgirTdbeEnIdrUGpb4zOarq36/fBUcAq+3yZOsXklKpUqPXdPoJCqNo1W1xq25fsjH9oJTQpc4QTtpR9cH7sGW7hYg1BKR5Xt+K03nP2YXreApNRC1eqluue8+McMc0KtAWUOMR1IAWy9vnNxEz62cHZ3BqbUd7PHw1rONn5bSVbfrwFyxI3F1uHP/YG1udbouZy/+E7bmBzH4o5opog1UMhvZZf7CfAhwn5g/nI6TsB0IRp49caGoMKfKjkQWdDr0a5hSZhsSaDstcJ2HgOHDrRNNAzyoiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=alQjfazA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=alQjfazA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl5Z04KQkz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 23:31:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmkaN1806137;
	Tue, 23 Jun 2026 13:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dr6MM2lRuKJstCiaPb90WhPj0j9hFX
	b3KiqDaaE/Wdg=; b=alQjfazAIeGgmD20NLNhWc73V0fM+WRdLOL8e+1FmLDi6u
	XMjQO7ldDQQMpjOAF8i/jXjvf7cV6KSR0GgY69UIa+epBJqOGS7FlDfNmZGrCEJW
	D+NSWiaNsHgvK5kQ5nJBXTQAQnlOZfax0GaLVCZWx34DK0foCU31RLslIm3C3tYR
	ZySH/rNyEKo8eFkMPheXvMnc6a3V2yLIWSZrw/qKoIAL3zZzrc9EXQbnHPTy3b9J
	DHd9mLkq/kA5nQBA1BG9+Ttb85OwNJzPDGGWrAKtAQGjuT7fHWxizaXhprFG7Qk3
	X0eovrSPDc8eZQ+vD2BSbAF3+xAsnja2opK3zsDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9geq39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:31:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJhsT022167;
	Tue, 23 Jun 2026 13:31:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwbjgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:31:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NDV0VQ26018096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:31:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6982004D;
	Tue, 23 Jun 2026 13:31:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E98C020049;
	Tue, 23 Jun 2026 13:30:57 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 13:30:57 +0000 (GMT)
Date: Tue, 23 Jun 2026 19:01:02 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v4 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260623184241.8e374888-21-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-4-amachhiw@linux.ibm.com>
 <875x3fcb3x.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x3fcb3x.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nyXU7o40VOo8V5yxqrQUWxvc1L-b6MUf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXwdK4yZxg3rk7
 p1REKI3j15iK+1IcH68V/NHd5FUz51uGZWnP2yKdhyRqEh6Gn6Uf8gRWS0qRmfWTX5dwl2E2gN5
 gSVzjM0shOSyLVLs1By3dO+pYwUSp8U=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a8a9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Zaj4I9ly_lfmcsfu6SgA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX1DwwukmerMBb
 Q79TOapNAChYjRlG6GepV10vYtXPVT3wsC/LEm9FDRzoxXksVuI2Ke4bXXSgM4FeEceFV8N8ygq
 J1dkhQtZuNnw4OwxMXOa2Gdx8BwtBlKsLEHmmH8VXjXavMK0pjXf8gPErojMuC1oQKBj8tGImd5
 PzGitMI25rfiIGmnD8bZDRMH4569BLPmYV7YS6BVrLQRDjN58l2LeDfktx+Dt1szeMDIJ7rd9RR
 pqA+3CTFGr385Dfg7eHhhssOiOdoL2fCi+HRtXszc9EL5tiwmkLOjwWMVXDHxYrD+9GObSvQQoY
 Nxsvz3UPCwS0yzQDs7ckgURs0+Rov7PGBV5BjfmVT4ZaL7O3k7F7GZ/7w1oceWRUC3ii6gz5+B4
 rHNNAfXhDSGOHWx5PFhzPbHbWcM/QFPGNcAbDfhdUNQkqaNGpKIBaLvPXCDuBXnf1XH+ztFIJ3a
 O4r/u/L0uDFsoXGZBGQ==
X-Proofpoint-ORIG-GUID: iBMXzw_zgg5xWl3ffCuCfpbV8dWDmbLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230109

Hi Vaibhav,

Thanks for reviewing this patch. Please find my response inline.

On 2026/06/19 11:42 AM, Vaibhav Jain wrote:
> Hi Amit.
> 
> Thanks for the patch and incorporating V3 review comments. Further
> review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> > hypervisor (L0), the guest runs with the expected processor
> > compatibility level. However, when booting a nested KVM guest (L2)
> > inside the L1, QEMU derives the CPU model from the raw host PVR and
> > attempts to run the nested guest at that level, instead of honoring the
> > compatibility mode of the L1.
> >
> > Extend host CPU compatibility capability reporting to support nested
> > virtualization on PowerNV systems (PAPR nested API v1).
> >
> > For nested API v2 (PowerVM), compatibility capabilities are obtained
> > from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
> > information is not available on PowerNV systems.
> >
> > For nested API v1, derive the compatibility capabilities from the L1
> > guest by reading the "cpu-version" property from the device tree, which
> > reflects the effective (logical) processor compatibility level. Map this
> > value to the corresponding compatibility capability bitmap using
> > KVM-specific constants.
> >
> > Introduce a helper to translate CPU version values into KVM_PPC_COMPAT_CAP
> > bits and integrate it into kvmppc_get_compat_caps(). The implementation
> > applies masking to ensure only supported processor modes are exposed.
> >
> > This allows userspace to query host CPU compatibility modes on both
> > PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index f674386df62c..375e7a7fa9f8 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -6523,15 +6523,50 @@ static bool kvmppc_hash_v3_possible(void)
> >  	return true;
> >  }
> >  
> > +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> > +				      unsigned long *capabilities)
> > +{
> > +	switch (cpu_version) {
> > +	case PVR_ARCH_31_P11:
> > +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
> Do you need to do 'break' here instead of falling through. Since P11
> host can support P10 and P9 compat modes

I had addressed a similar comment from Harsh in v1 of the series here:

  https://lore.kernel.org/all/20260507202740.96fb259f-22-amachhiw@linux.ibm.com/

The current implementation with break statements is intentional. This
function (kvmppc_map_compat_capabilities()) is called only when booting
a nested KVM guest (L2) on **KVM on PowerNV**.

When the L1 KVM guest is booted in a compat mode, L2 is supposed to boot
with the **same PVR version** as that of the L1, which is already taken
care of with the current changes. If L2 needs to boot with a different
*lower* compat mode, it would use max-cpu-compat, which takes a
different code path for setting the compat.

Even if I included all lower compat modes in the compat caps **APIv1**,
I don't think we'll be using those lower compat bits unless we wanted to
block a specific older compat for a given pvr level - which neither we
are doing in this series nor we may want to put such a restriction for
APIv1.

Please let me know if you think otherwise.

> 
> > +		break;
> > +	case PVR_ARCH_31:
> > +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> > +		break;
> > +	case PVR_ARCH_300:
> > +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> >  
> >  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> >  {
> > +	struct device_node *np;
> >  	unsigned long capabilities = 0;
> > +	const __be32 *prop = NULL;
> >  	long rc = -EINVAL;
> > +	u32 cpu_version;
> >  
> >  	if (kvmhv_on_pseries()) {
> > -		if (kvmhv_is_nestedv2())
> > +		if (kvmhv_is_nestedv2()) {
> >  			rc = plpar_guest_get_capabilities(0, &capabilities);
> > +		} else {
> > +			for_each_node_by_type(np, "cpu") {
> > +				prop = of_get_property(np, "cpu-version", NULL);
> > +				if (prop) {
> > +					cpu_version = be32_to_cpup(prop);
> > +					break;
> > +				}
> > +			}
> > +			if (!prop)
> > +				return -EINVAL;
> > +			rc = kvmppc_map_compat_capabilities(cpu_version,
> > +								&capabilities);
> > +		}
> should you check for 'rc' error here before assigning 'capabilities' to
> 'host_caps->compat_capabilities' . I understand it will be set to '0'
> due to its initialization at the top of the function. But would be
> better to make it more explicit

Sure. The return value rc is checked by the caller but more error
checking is always good I guess. :) 

I'll add a check for rc something like this (or something similar):

  if (rc) {
  	return -EINVAL;
  }

  host_caps->compat_capabilities = capabilities &
					KVM_PPC_COMPAT_BITMASK;

Thanks,
Amit

> 
> >  		host_caps->compat_capabilities = capabilities &
> >  							KVM_PPC_COMPAT_BITMASK;
> >  	}
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> >
> 
> -- 
> Cheers
> ~ Vaibhav

