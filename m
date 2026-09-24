Return-Path: <linuxppc-dev+bounces-28104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA9CC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 09:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr7mM5Ly2z2yD3;
	Thu, 24 Sep 2026 19:28:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790242083;
	cv=none; b=LIgzXIewP5l015yBcsaRJ6QosihzK0epZQ9uUeTtrihgqA6jVJve8B1Ofnv23j49vxDkH3NyZqJXlLiXEgbmSpxaff4L4U/0pmy9xhONCvpkD+3UQ5KtPCoj6i8YSSiOVXro0/Yq0JD3IyDsNwWnoVEbwGJu67EqG1XV40/fOb4BUM49QqvsqKMW7hxxFwC2wekAlmAliO1rDbTIExnDeyovFxPVsrNDKHW9DvadpURojcjf2tIoOLODBqsA0wAiREpFiuRF/FZYIFI/go8AmxIPJQeFgdaqGeUpGPgOsHOsxsknlf2+Z/c/4b7l3Lbsojz+7USV0JpmShHz3FZQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790242083; c=relaxed/relaxed;
	bh=8EIliPWS3vQNKUWI5NYc16lj8iiQWxkDmdxvx+OHURQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi3Q2/WB2DlGYFyp+WAb75V7R4i+5VyqOWbgCe6LurShHdtqdSHLqWpBGL3g6+2lIycyG5iyFDLt2Gluqs0J6QqOcHPSU4pJFsq2RhTrqll3BDdVfXUtz4itGbz7YMthNGhmeP9Uj/XZYtNfM2HnTJux0ylVQCIEQktgyokqN6vgWk7MiSkOtTzY7zMBdsyoKradbQnK3ojQrhhoq6Mu5hED7AdwBXJrJX9Rkp/ZM3PBeWsHL0S3T86Z2zWluqF47yDFP7J5s0iZVB5BFb3Z8YIAQZZonUuCoVltaafhBTd3NK87HuUuJ9jQ9MoiHDnpXUlhCApyu3nteR7JUZv1YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NoWkz9sk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NoWkz9sk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr7mM0Fvqz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 19:28:02 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bPHC1333890;
	Thu, 24 Sep 2026 09:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8EIliP
	WS3vQNKUWI5NYc16lj8iiQWxkDmdxvx+OHURQ=; b=NoWkz9sk9MvFGQ9vSLsHEz
	sr7VBx++JzyirHuOdCb5738Aw7a4SGGJDg062LNnhv5Bnh043hxQB4lz1eR6pbIm
	i+zl3nDrU+JPE0k/JMHcFwi7m5eXLNdSpz9luY0okmBeXQQaMHE5CBuyOKA5bYya
	+wmENq6HCMXxh/hsXaEIN+5GY4z0jfVhtr051LO8A3YEW/JIIlIQF6EqqKUWPtIS
	LeS9G60BulQ//B69VHIo9Wj7ATYOyePqo1KA7fzuKv+aRBzdgasp04MHFyXFz/Pr
	xkTliQ7Xz0lwwJadwZrTp3AnnEZJ375PK1cE32B/9rT9LawuucCUurzgaI0KJlTw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsg2vy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 09:27:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5llnw1497500;
	Thu, 24 Sep 2026 09:27:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8vvu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 09:27:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O9Rerg49283582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 09:27:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79FF920043;
	Thu, 24 Sep 2026 09:27:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE99D20040;
	Thu, 24 Sep 2026 09:27:38 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 09:27:38 +0000 (GMT)
Date: Thu, 24 Sep 2026 15:05:39 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <20260924145126.cf1c0ae1-37-amachhiw@linux.ibm.com>
Mail-Followup-To: Jyoti Gupta <jyoti@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com
References: <20260924063010.188642-1-jyoti@linux.ibm.com>
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
In-Reply-To: <20260924063010.188642-1-jyoti@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4ed12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=t5kBZIPNrCX0i9atMZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CYWfs2TQ_bkK6aRbuwngX2EMlKDe7bm4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX/pO93khs/A77
 11t6TRw2FV07TbFYmGGzZEuO4Aagb5dCQuAOv8oStX0yV/U5D82E+Off5jWHf/DZI8uol4hw7/3
 q3BQ78sIbh9qXDQzSI83ZW/QJITLDP4zdqcUrhsiLVuVylxZIWm4YeKpJ/v2JvXoh+3A8qZNdCa
 vZBUCSocR3S8jzPBVOTs5tpEmtWC4MI74gyaDkPj2DK/j5Yr/MZu/6F/pVcH8jXCq9yTs2D/UsL
 oZYWviDyDGS5cW1MdsyMDIQmAB1skQYMOOgLySE/SyuuBdsrJjKlZLSQzK4Ry7tMi7VZilovNuU
 BWYpXvtk70Cqn90a3NzQMHVISOAE+qn77HWBIocys1EdQOxkHcAfkzI3pVXkQPBMLN0eOhm5wMA
 jM5rf5/67++OgIDLIh+kwvpGq1vKjcX1Z29vIIdzMpPoRaJly9D2Fr0Ho0d+Fv5iXOMro91E9O2
 g2k0Yhn5ZElz3a1TAyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX6ZsfKc7oK+MX
 bY2t7lSXvwORJNqzEfgUZwp6dBejrG/sUXKlb6DJjZFk3ultUNW6Ydgn+HDckvnlR4TivLGQ3+N
 f9Sj8AuDpYZIF+m6pEz1c4X5QEnACPM=
X-Proofpoint-GUID: skpA3d26DByPMjxKXBb7rs2ik8ItQnzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240038

On 2026/09/24 12:00 PM, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Initialise mpic to NULL and free the bitmap and the mpic in the common
> error path before dropping the device node reference. The register
> mappings are not released here.
> 
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>

I see a couple of problems with this patch:

1. The patch does not apply.  Both "git apply" and "git am" fail on this patch.
   I think the context lines around the irq_domain_create_linear() call have
   tabs converted to spaces, which causes the context match to fail.

      ❯ git apply ./20260924_jyoti_powerpc_mpic_fix_memory_leak_of_mpic_on_error_paths.mbx --check --verbose
      Checking patch arch/powerpc/sysdev/mpic.c...
      error: while searching for:
      						 intvec_top,
      						 &mpic_host_ops, mpic);

      	/*
      	 * FIXME: The code leaks the MPIC object and mappings here; this
      	 * is very unlikely to fail but it ought to be fixed anyways.
      	 */
      	if (mpic->irqhost == NULL)
      		goto err_of_node_put;


      error: patch failed: arch/powerpc/sysdev/mpic.c:1488
      error: arch/powerpc/sysdev/mpic.c: patch does not apply

   Please regenerate with:

     git format-patch -1

   and verify with:

     git apply --check <patch>

   before resending.

2. The mpic_setup_error_int() leak is not actually fixed.  The commit message
   says both mpic_setup_error_int() and irq_domain_create_linear() failure paths
   are fixed, but the former still does a bare return NULL:

     if (fsl_version >= 0x401) {
         ret = mpic_setup_error_int(mpic, intvec_top - 13);
         if (ret)
             return NULL;   /* <-- still leaks mpic and mpic->protected */
     }

   This needs to become:

         if (ret)
             goto err_of_node_put;

Thanks,
Amit

> ---
>  arch/powerpc/sysdev/mpic.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 6e8fa94985f3..e777b33f170d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  				const char *name)
>  {
>  	int i, psize, intvec_top;
> -	struct mpic *mpic;
> +	struct mpic *mpic = NULL;
>  	u32 greg_feature;
>  	const char *vers;
>  	const u32 *psrc;
> @@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  						 intvec_top,
>  						 &mpic_host_ops, mpic);
>  
> -	/*
> -	 * FIXME: The code leaks the MPIC object and mappings here; this
> -	 * is very unlikely to fail but it ought to be fixed anyways.
> -	 */
>  	if (mpic->irqhost == NULL)
>  		goto err_of_node_put;
>  
> @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	return mpic;
>  
>  err_of_node_put:
> +	if (mpic)
> +		bitmap_free(mpic->protected);
> +	kfree(mpic);
>  	of_node_put(node);
>  	return NULL;
>  }
> -- 
> 2.55.0
> 
> 

