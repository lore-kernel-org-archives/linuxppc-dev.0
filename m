Return-Path: <linuxppc-dev+bounces-24917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CBDC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 02:48:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8KfM4cDtz2yN8;
	Tue, 28 Jul 2026 12:48:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785206923;
	cv=none; b=Kj69ZBiJyCZIVm55PX/XCFZ4cQTkVDVFqMUicf2ik82O81VjTc8mtQTEDFA7D1rkJvOn/gvo4K0alN/38eACCn2fTzqhSTax3ilq4prfSQR3f2Spt347JD1ViYLRax4u8My3TVBAhhi4dvg3coy+zX7+A4dr7MJDJwITnpWt7utIm483BJCa4NWe41JZgOn+SLJFpcxX3ce1e5Ho8NUaXzT2oQ5/ZrGCGBzSXyXJVZSkvFOqCNuLEY8ZL3N3yEG1LKfHcRsIf9IwCrtFJSO9zDIQP6Q1ACbXPavtIQFocWr9KXsVX0430BzsqGRWkpKy57TKdz4A/KqO37MfgcFV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785206923; c=relaxed/relaxed;
	bh=bgHtuzFNZq1OJi7PxvleOvtsa7u04+xYp/hMYQgzOc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSEDGxbViB1RvqQZrto+pP4qVjtrTrRjxSVs14YanUHB9eJIVp02qaAy2Gd9uyFIjJR37gWFGL88iIXX9RCvODFFXTBGGSG13iQKq/nPYBE7Udc2o2pXgMIy4dEubEDiyN7Byb7cOM+b+7pMK8yY6Ng+Ra2gJux0tLJZ196Z/dAY0zu6gx/YTUM5u5TDh13Abo77CKxKp9yprITEty487VBHRq0KWRtgGJzkxVfGNucBzUY6bJyrL+i7ZogkFEkIF2Hq9QOuS7ZZ+Gn7i4jOb85grxlv2OUrKujOqpzBgjG2ncQuGZ0yXqahWlPV6E4Ha9iPdaxJa+p/JkRGR69KbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bLLk1KND; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bLLk1KND;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8KfL3kgwz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 12:48:41 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0murp3676671;
	Tue, 28 Jul 2026 02:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=bgHtuzFNZq1OJi7PxvleO
	vtsa7u04+xYp/hMYQgzOc0=; b=bLLk1KND44vVvsNI9aysAOQrSNpI1qb3fWZ24
	32mX1mCJv4kce0s6+YmkgCp0gLRMxV6LmD7ZlXd9igxH+kjtMpaA+jdPI/BHhiI+
	iYHLVKmB+QvLzQfBoLP7Vo9IQqq4JNgLWFdXaDhxLQp8CzLcNmLLOxFjhGh7HLD/
	hMrwBVNEBLlut4vVlKjQIIoDXHU6hVFVM2zEGnkLCDZjOaasxZNUvfs4niyKO7we
	GXZZwJy4RE/8Xp/SzCAcX8PChCsU2GLuWeowH07byvCvhTF6GfEspsQDdiyVLDCe
	HU0a2Gmdriq4VNqFrewsI2/JObFGXajo+TaIsfzxhRFVRv1OQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0njjt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:48:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S2fGBk015823;
	Tue, 28 Jul 2026 02:48:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq84bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:48:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S2m3US50528680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 02:48:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BBE20113;
	Tue, 28 Jul 2026 02:48:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5497D2010F;
	Tue, 28 Jul 2026 02:47:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 02:47:53 +0000 (GMT)
Date: Tue, 28 Jul 2026 08:17:52 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, namcao@linutronix.de, peterz@infradead.org,
        sshegde@linux.ibm.com, kees@kernel.org, lgs201920130244@gmail.com,
        ynorov@nvidia.com, nilay@linux.ibm.com, clg@kaod.org,
        benh@kernel.crashing.org, miltonm@bga.com, mkchauras@gmail.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH v3 3/5] powerpc/xive: propagate IPI init errors to
 prevent use-after-free
Message-ID: <amgYWAAGZ61VTXDc@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-4-gouhao@uniontech.com>
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
In-Reply-To: <20260727104215.184786-4-gouhao@uniontech.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyMyBTYWx0ZWRfXxCakQBzBBlmX
 q8agonSiPGJjz/LmHLx3ycqNYmCThgdME9lzD8vAMvLO594mJMLJvgPe6/qUijQFJYsfj2DYUpv
 1DR5d6BqVv2r8+lroHc5fAwdOeagg8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyMyBTYWx0ZWRfX+OyqpLh9NLAl
 ofMjq2eFv98woXjcM3TYdwOypdXryuB8TZB1bHLh1gP578U1Tu/yQruuAI0gULiu8U15/k2HNHL
 XSQ8rNU42oEJhwxA6Xz0awMs7f9cXVup2O0FMQlZj7+DKxFIQmeAQN2BcwwuMPMCOqbMjvH7fEA
 xWkYFpvhBS86G+V76Fu2WpDlfdUxhVpSBxlrcVygo3Fd0oBeGOSaCGi5rArqvBDLsD19fPCRDWF
 Chhgj87ZNJ2yGt6NlcJ8G29iJgSIwIx7Q4s7rmDd4zZTQ+EOW+oVe+lrgf2WqrCmAM3M5ZMwF7J
 T1Sp7exlLnUh4e7pTatxVWfoa1ua/RX1Ml2VYSo+CnLo2qmGVo/ltCeb7D+v/AMxXQo9p18E4em
 4OlO9WTEDrI1hc/hAzjR3IMRkFq0ixjqD9u/Lw0l/rXroSSVApbkyfVCAOM2jcwE1CQ0gFc04z4
 hZlATCBlVdU+mlgC1JQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a681869 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iHwBjlyiAAAA:8
 a=17DdLGIAOLS4Yo6TFyEA:9 a=wPNLvfGTeEIA:10 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-GUID: vymvvCLMhHgYXi4iRNVcI9tHbi2RQIEK
X-Proofpoint-ORIG-GUID: t9H38BJXyhs6Lt0eNyeBb0YRB_gOynOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280023

* Gou Hao <gouhao@uniontech.com> [2026-07-27 18:42:13]:

>  
>  static void __init pnv_smp_probe(void)
>  {
> -	if (xive_enabled())
> -		xive_smp_probe();
> -	else
> +	if (xive_enabled()) {
> +		if (xive_smp_probe() < 0)
> +			return;
> +	} else {

If xive_smp_probe() fails and we return from here, what is the IPI mechanism
that is going to be used?

Before the patch, we were not configured for IPI and we would fail.
Now we have not configured IPI mechanism, so what are the consequences?

Should we try disable xive_enabled() and try xics_smp_probe() instead?

>  		xics_smp_probe();
> +	}
>  
>  	if (cpu_has_feature(CPU_FTR_DBELL)) {
>  		ic_cause_ipi = smp_ops->cause_ipi;
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index db99725e752b..14cd0634eeca 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -194,10 +194,12 @@ static int pseries_cause_nmi_ipi(int cpu)
>  
>  static __init void pSeries_smp_probe(void)
>  {
> -	if (xive_enabled())
> -		xive_smp_probe();
> -	else
> +	if (xive_enabled()) {
> +		if (xive_smp_probe() < 0)
> +			return;
> +	} else {
>  		xics_smp_probe();
> +	}
>  
>  	/* No doorbell facility, must use the interrupt controller for IPIs */
>  	if (!cpu_has_feature(CPU_FTR_DBELL))
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 9f80c16be23f..bbe7c85274ea 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1267,15 +1267,17 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>  
>  int __init xive_smp_probe(void)
>  {
> +	int ret;
> +
>  	smp_ops->cause_ipi = xive_cause_ipi;
>  
>  	/* Register the IPI */
> -	xive_init_ipis();
> +	ret = xive_init_ipis();
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Allocate and setup IPI for the boot CPU */
> -	xive_setup_cpu_ipi(smp_processor_id());
> -
> -	return 0;
> +	return xive_setup_cpu_ipi(smp_processor_id());
>  }
>  
>  #endif /* CONFIG_SMP */
> -- 
> 2.20.1
> 

-- 
Thanks and Regards
Srikar Dronamraju

