Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32087606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P3agtGr/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbTZW6Zm8z2xGw;
	Fri, 27 Nov 2026 21:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795773955;
	cv=none; b=TmGHbnyjZK3SQMt3i/nxZOotABJZZCj/wGndcQFyq0FOtYjuAYs4frqu/ahIrQeKg6oJuBKvjUmJwedywl0E2RrAKnc+kAuUJ3pqq9lPALC+srXBhA1s0cXiCB87ayVnTMsTtDnLehKpBFp4NcfDw2BBrjpgAipGOxvj4qUuebWthbdvcpAuvyf7oyt+Cjp+FznKwbyqi84njPzUKEiiMGSuRQ0P9S163PzxiTejwbp4RO4wFbwGMo3HJztP6YWc5lmOsNfwo4/NrLS40YM/m0n0Y9JtCsM+VCQs2/VWtdU8pYCURWAlOZB/8ANbv7Q9KXlF2lz7iJ5jV5ykR02gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795773955; c=relaxed/relaxed;
	bh=4sUtHkEAgz2Bzeie97BrPsCB0u2qEGYsKwyaUvKGuaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCN5KXi3wXRuSPy1tZD66ooP63mPQk8wEB4Qs0Yt13chc16S6g6xPQWZZ400yV1qq6CUoB+cW5150aPLMWAMfimA/gyu+9E1TIPGQRIk4klg8hNy+FC0R/DvhEAo6Ol1RRA5xMdTKREep6re19U0Dink88mVYOIrXxZoJCqUyxD0fwso43KTmBsiDuhmPdp2K7Tf0Ok4q1lSSBm5Nv5I9R7GvmWLUmiDU0/neng/kfD3veIfv4y/iYU7YNL7YNDmZhWFeE5MO1lJjBd0gQrm74AHSHP/lX821XuWK7yVzdrzPUqwPHXibjAD+SwPgvtkSYYewimitzugFrjnf5unuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P3agtGr/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P3agtGr/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbTZW0kqdz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 21:05:54 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7YjhH1236336;
	Fri, 27 Nov 2026 10:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4sUtHkEAgz2Bzeie97BrPsCB0u2qEG
	YsKwyaUvKGuaY=; b=P3agtGr/Tb5vAxhGYNalRfAfYCY3JAS+VZ9ZzBOLbLFP/D
	RQU7nAoms7iACyO/06vDUgZGcXYDfYFnyQ8C5oIwnkrDMg+iRPX/nip6tk8jmXfR
	eiGgYEFm0PlGWC22TNnzXuQl8H+evIbrQ5IPDNFauSfdWK4FeAj/J4NzNVylRdje
	y7AeksALd2mczoIdz4HDVCEVfhRpsSocxiDuq93g93doIDydzKTkVPkJ1myZHixy
	gsCtfxdySwpa77JtLoCWc1DKPl6tyL/YelTfi0ieLrDJLbsiOh30JWG++xda5hg0
	Oac3hE0xYuL9M4HggKS+pvqnXtGJxguvYP35hfUw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4vbnc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 10:05:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7K2PH2385215;
	Fri, 27 Nov 2026 10:05:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa9s88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 10:05:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARA5JVW43254218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 10:05:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 804912014D;
	Fri, 27 Nov 2026 10:05:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D4D20146;
	Fri, 27 Nov 2026 10:05:16 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Nov 2026 10:05:16 +0000 (GMT)
Date: Fri, 27 Nov 2026 15:35:14 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, chleroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if
 perf_pmu_register() fails
Message-ID: <awlVyNGoCPys6lFX@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
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
In-Reply-To: <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX+JjBivEm+mg9
 wIVe5z7/J5UzxA5fsTT9cn9E0IPGY5vlSE2eT0YvLUeNyu5wNHcRLxuOgbNFtjiEEZNhDNDNviC
 wQJkWz0YBUGEV1UftKn378QATlvlsRI=
X-Proofpoint-GUID: Gae63ZoM4M0MEZcwXONP_BTOUFUriXXx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX1o3JZ4DF8G+L
 6E+ojIrguBU1/WbA5RuRe9xA0OzkMy1ePrdhuDzqEuBiEHBWDgunVdwHf0sY++VqCnn3QhNirKY
 2wdVXCZcb1u4ZJFJ3I83n1M08XtFvT3nanffCiRiCZ/nL65YMtAr36MUkH7JWJ0AC9bVLtGHaAC
 EhDfn5fiBlhP9oPQbX+qecftvUhnHatzomTK6J5JvU7rIvpASeR9rVOc0LiSR3MLJSdigLyHdu4
 8Lvykwta2NFW9iCFRDW5X3M8KkrKRQjvPXuE74GcwOKvl2DTR9cTAdAAmygYYt0x70+0k3UtADk
 EZBLc1kjO9177JvpR0LwtuRD2+9szvP/FmHWBL6JugYfzGQDW0eSwo8+FakylLxDwt0RmlDHKWG
 BoMFNXSr1lpf7+uEuyx2yzaCmQ9U807xNpOVuMNlYKzajU0Dl2WDXH7/9gbl19sQpqvRxaFZ2Hw
 T2FKhjYuB8UADc1J8UA==
X-Proofpoint-ORIG-GUID: AOBb8rh6oP4nLjFdaCov8rvSaCx3sRDZ
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0955e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=wwyHm5RKODv18j-RS84A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270040
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:21:53PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
> gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
> perf_pmu_register() fails we return without freeing them.
> 
> Call kvmppc_cleanup_hostwide() on that error path.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index a58634f656e9..ec05b4855736 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
> 
>  		/* Register the pmu */
>  		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
> -		if (rc)
> +		if (rc) {
> +			kvmppc_cleanup_hostwide();
>  			goto out;
> +		}
> 
>  		pr_info("Registered kvm-hv pmu");
>  	}
> --
> 2.39.5
> 
> 

Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

