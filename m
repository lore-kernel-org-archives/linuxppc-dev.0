Return-Path: <linuxppc-dev+bounces-26545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACD1C624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:05:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbsXd3LsMz2y2K;
	Fri, 04 Sep 2026 20:05:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788516321;
	cv=none; b=fI29Q8v3MVG/31hgUyCHsTWYf15Gpnqjscy9XfDy6kTmzSW1J6uSmD3B2JXEU0jCGUIZ2sdwHiKYu8IZXkUsJBzx17PHDWUzukL3/wddVt0wa3P+Y541f5Fi2yYy172iWMueMHCf5ILF5Mwzc8jKZbdtZ7Go4o7owtZBUxthbOncrOUq/vIss8Ax3p2UZjQyxRGGLJcgfPkt0n08z01i1JD/kooOBp6f1+HTWebxmIGigpUfweflsbmiaKl7/iLvRBWALBa8qtVxkuzQ+scp1wUvSZ+C01I6uLBATGJ6pWoryHBPxtqsLCfZwULW69ks7CiEsk7HM0KwIRDHIsvNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788516321; c=relaxed/relaxed;
	bh=Tt278+PuJiVNKdTw+nz7DMikcJ69J4GTQ6t7C0y8U+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEFHMgQc6FuQj9FTEtYNOEJ2xMRVRbJ9dUmPcHu84TxOUBYo4T3BlM2XUVkurCv4ol/PzMkZQ6INHwOOoqvAigmgGlUrN/YN3aDj+f9Dab0akKmfVqFAqdbAb4rg38nH9eC7C7HZ2dLytaUZnamytujs8LvD4DDTcw5kPaGtgWrJmGywq+D6mIe4J9YP118OqRQHsle3hbym5E0qe4pt6B2FQyi0fkcF++aDvGL7Kcek2QwKy8uDYb5O4DWPpR4fgrV5f1X5ZtWBOuRvY5Ba3ybCVgBmYH03ZpeEgFmnGLYtoeycJjJL3Py4QQ+QATOxRs/2YhPXL92CmvHAdj+iDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KgdFHgVr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KgdFHgVr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbsXc3dCdz2xpn;
	Fri, 04 Sep 2026 20:05:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464ja33994215;
	Fri, 4 Sep 2026 10:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tt278+
	PuJiVNKdTw+nz7DMikcJ69J4GTQ6t7C0y8U+0=; b=KgdFHgVraRBGutUHIIWY8A
	+geGIDR/JOdloJNmmmaiOQnD6GJVJTlErfetaAnXyQ8brn2kT2KuN2EJvdoX2CGn
	him4bg3tsDTCNa66fb27mcB84c4suDLozowq6qvPMybUymkDXbB0349hwFwcAMWh
	gXZYuTrq+EXDFYI0iWMp0X08vOqq8lfp6hjtE6i6rtnVZBoWKZ/wcS87bFxz6dNp
	cjJwFZ2rmsUu/LtCrJdWfl/vxylzC34+c+Eu9nq84Czr2Uky3+BYKlFY/zUdap13
	09iKmWczSXi+3sEEQ904S4wbNj7gl92R2iJuyQuJ+3eguda7Rj97da81cPkH4AxQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue9hxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:05:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849uXc1025129;
	Fri, 4 Sep 2026 10:05:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjavsu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:05:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684A4tCE29164116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 10:04:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B92A20040;
	Fri,  4 Sep 2026 10:04:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41E02005A;
	Fri,  4 Sep 2026 10:04:51 +0000 (GMT)
Received: from [9.124.221.192] (unknown [9.124.221.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 10:04:51 +0000 (GMT)
Message-ID: <c11197ac-ce7b-4fba-8ea5-4f38be9f7106@linux.ibm.com>
Date: Fri, 4 Sep 2026 15:34:50 +0530
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
Subject: Re: [PATCH v3 3/3] powerpc/numa: Support coregroup on PowerNV
To: Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20260902123458.340456-5-srikar@linux.ibm.com>
 <20260902123458.340456-8-srikar@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260902123458.340456-8-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: T6fjphv16xz__ksgV9FV8DBS00VnbVoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfX517Sit4aupoC
 nxn1Z0QEMatz56EyHZQ04rLaC8dnw9KyWy3yLiuzF+ugz2RG6NryaLA0VCWmz8PwI41j8v9UVj7
 j7I/Gg4Rw/xgQqTz5PBe1eWmC8G9ah2bAOyx9Z6lxFIpt2IPIxAUhFEPp0SIA34JC+z9TIX6OrA
 GKwp/r6imREgiMJA1hI9JAJXc3n+kkWntv3HGhri2R3z089P5O2x0zUpfizch1pSLX3yKEKSlwK
 PxmQwNpqhhcgu5HwR//DpomvXS9BYvOBUg/rvMSPVAptRPdx9bBmyuQqwXXQUqBlrJgzXj982I5
 wpZLuTDzTOZU2e20SoGJo70LbGSi3LAQw08p9WF7DWfKY4eO6+VdA17aOiZQil/28Ze+50Q5PQO
 S0gJQy2E1+Fa8Bm/9wRDfkcPl0xlYUbm8UHtXJW8A0htuSTWaMul6DssWC2r+2BLhCnO0goOpH7
 xPrZXu/qq4tj9cFltEQ==
X-Proofpoint-ORIG-GUID: _VmXG-DC84mzdIuoGF-oSdXv1zxk0qIB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfX9JzXYSVCNakm
 y8kQYKBBS8BaRqieyAnY0zwa/UVsLdwWPdA2OPSzmJgJ8sWvWeP+RfR2l8ePEQqXiR+S6MSMDI2
 Wad8ns0Ff1jk1okV5thAdikHLgPZKZ4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a97ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xOIxTGQp75SbQC7pz58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040091



On 9/2/26 6:05 PM, Srikar Dronamraju wrote:
> Coregroup support on powerpc has so far been limited to PowerVM LPARs.
> However, PowerNV can also support coregroups when firmware exposes the
> required coregroup information through the associativity hierarchy.
> 

Existing firmware does expose this info already?

> Detect coregroup support by checking whether primary_domain_index is the
> penultimate domain in the CPU node's ibm,associativity property. On
> PowerNV, a non-penultimate primary_domain_index indicates that firmware
> provides an additional level for coregroup information.
> 
> This keeps the logic compatible with PowerVM systems, where
> primary_domain_index is likewise not the penultimate associativity
> domain.
> 

Could you please put the ibm,associativity on this powernv? as well
PowerVM's so that one understands it better?

> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog from v2:
> - Handle comments from Ritesh (one hunk needed to be moved from patch 2 to
>    patch 3 to build correctly)
> 
> Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
> - Handle comments from Christophe Leroy; make code more flat
> 
>   arch/powerpc/mm/numa.c | 58 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 5f326b005a2a..e97b624203ea 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
>   	return 0;
>   }
>   
> +/*
> + * If hierarchy extends beyond primary_domain_index + 1, then next
> + * level corresponds to coregroup.
> + */
> +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
> +{
> +	if (!associativity || index == -1)
> +		goto out;
> +
> +	index = of_read_number(associativity, 1);
> +
> +	if (index > primary_domain_index + 1) {
> +		coregroup_enabled = 1;
> +		return index;
> +	}
> +out:
> +	coregroup_enabled = 0;
> +	return -1;
> +}
> +
>   static int __init parse_numa_properties(void)
>   {
>   	struct device_node *memory, *pci;
> -	int default_nid = 0;
> -	unsigned long i;
> +	int default_nid = 0, index = 0;
>   	const __be32 *associativity;
> +	unsigned long i;
>   
>   	if (numa_enabled == 0) {
>   		pr_warn("disabled by user\n");
> @@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
>   	 */
>   	for_each_present_cpu(i) {
>   		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
> -		struct device_node *cpu;
>   		int nid = NUMA_NO_NODE;
>   
>   		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
> @@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
>   		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
>   			nid = associativity_to_nid(vphn_assoc);
>   			initialize_form1_numa_distance(vphn_assoc);
> +			index = detect_and_enable_coregroup(vphn_assoc, index);

nit: I don't see return value being used.

Other than that, rest looks good to me.
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

>   		} else {
> +			struct device_node *cpu;
>   
>   			/*
>   			 * Don't fall back to default_nid yet -- we will plug
> @@ -948,6 +969,7 @@ static int __init parse_numa_properties(void)
>   			associativity = of_get_associativity(cpu);
>   			if (associativity) {
>   				nid = associativity_to_nid(associativity);
> +				index = detect_and_enable_coregroup(associativity, index);
>   				initialize_form1_numa_distance(associativity);
>   			}
>   			of_node_put(cpu);
> @@ -1445,7 +1467,9 @@ static long vphn_get_associativity(unsigned long cpu,
>   
>   int cpu_to_coregroup_id(int cpu)
>   {
> -	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> +	int coregroup_id = cpu_to_core_id(cpu);
> +	struct device_node *cpunode = NULL;
> +	const __be32 *associativity;
>   	int index;
>   
>   	if (cpu < 0 || cpu > nr_cpu_ids)
> @@ -1454,17 +1478,31 @@ int cpu_to_coregroup_id(int cpu)
>   	if (!coregroup_enabled)
>   		goto out;
>   
> -	if (!firmware_has_feature(FW_FEATURE_VPHN))
> -		goto out;
> +	if (firmware_has_feature(FW_FEATURE_VPHN)) {
> +		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
>   
> -	if (vphn_get_associativity(cpu, associativity))
> +		if (vphn_get_associativity(cpu, tmp))
> +			goto out;
> +
> +		associativity = tmp;
> +
> +	} else {
> +		cpunode = of_get_cpu_node(cpu, NULL);
> +		if (!cpunode)
> +			goto out;
> +
> +		associativity = of_get_associativity(cpunode);
> +	}
> +	if (!associativity)
>   		goto out;
>   
>   	index = of_read_number(associativity, 1);
>   	if (index > primary_domain_index + 1)
> -		return of_read_number(&associativity[index - 1], 1);
> +		coregroup_id = of_read_number(&associativity[index - 1], 1);
>   
>   out:
> -	return cpu_to_core_id(cpu);
> -}
> +	if (cpunode)
> +		of_node_put(cpunode);
>   
> +	return coregroup_id;
> +}


