Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:14:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0D32073D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0D32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vgNW07DKzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 23:14:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vgKB1fDSzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 23:11:25 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16C5BoG075153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Feb 2019 07:11:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qfxgdbjd6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Feb 2019 07:11:22 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 6 Feb 2019 12:11:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 6 Feb 2019 12:11:18 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x16CBH8a52691074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Feb 2019 12:11:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5935AE05D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:11:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A965AE056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:11:17 +0000 (GMT)
Received: from [9.126.27.63] (unknown [9.126.27.63])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:11:17 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/perf: Use PVR rather than oprofile field to
 determine CPU version
To: linuxppc-dev@lists.ozlabs.org
References: <20190206063024.8489-1-rashmica.g@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 6 Feb 2019 17:41:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206063024.8489-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19020612-0016-0000-0000-000002531D84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020612-0017-0000-0000-000032AD266B
Message-Id: <3085b26c-d4af-1f41-c6b6-9d523290e843@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060096
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 06/02/19 12:00 PM, Rashmica Gupta wrote:
> Currently the perf CPU backend drivers detect what CPU they're on using
> cur_cpu_spec->oprofile_cpu_type.
>
> Although that works, it's a bit crufty to be using oprofile related fields,
> especially seeing as oprofile is more or less unused these days.
>
> It also means perf is reliant on the fragile logic in setup_cpu_spec()
> which detects when we're using a logical PVR and copies back the PMU
> related fields from the raw CPU entry. So lets check the PVR directly.
Nice work. I wanted to do this for some time now
but never got to it. Thanks for doing this.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
> v2: fixed misspelling of PVR_VER_E500V2
>
>   arch/powerpc/perf/e500-pmu.c    | 10 ++++++----
>   arch/powerpc/perf/e6500-pmu.c   |  5 +++--
>   arch/powerpc/perf/hv-24x7.c     |  6 +++---
>   arch/powerpc/perf/mpc7450-pmu.c |  5 +++--
>   arch/powerpc/perf/power5+-pmu.c |  6 +++---
>   arch/powerpc/perf/power5-pmu.c  |  5 +++--
>   arch/powerpc/perf/power6-pmu.c  |  5 +++--
>   arch/powerpc/perf/power7-pmu.c  |  7 ++++---
>   arch/powerpc/perf/power8-pmu.c  |  5 +++--
>   arch/powerpc/perf/power9-pmu.c  |  4 +---
>   arch/powerpc/perf/ppc970-pmu.c  |  8 +++++---
>   11 files changed, 37 insertions(+), 29 deletions(-)
>
> diff --git a/arch/powerpc/perf/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
> index fb664929f5da..e1a185a30928 100644
> --- a/arch/powerpc/perf/e500-pmu.c
> +++ b/arch/powerpc/perf/e500-pmu.c
> @@ -122,12 +122,14 @@ static struct fsl_emb_pmu e500_pmu = {
>
>   static int init_e500_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type)
> -		return -ENODEV;
> +	unsigned int pvr = mfspr(SPRN_PVR);
>
> -	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500mc"))
> +	/* ec500mc */
> +	if ((PVR_VER(pvr) == PVR_VER_E500MC) || (PVR_VER(pvr) == PVR_VER_E5500))
>   		num_events = 256;
> -	else if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500"))
> +	/* e500 */
> +	else if ((PVR_VER(pvr) != PVR_VER_E500V1) &&
> +			(PVR_VER(pvr) != PVR_VER_E500V2))
>   		return -ENODEV;
>
>   	return register_fsl_emb_pmu(&e500_pmu);
> diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
> index 3d877aa777b5..47c93d13da1a 100644
> --- a/arch/powerpc/perf/e6500-pmu.c
> +++ b/arch/powerpc/perf/e6500-pmu.c
> @@ -111,8 +111,9 @@ static struct fsl_emb_pmu e6500_pmu = {
>
>   static int init_e6500_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -		strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e6500"))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if (PVR_VER(pvr) != PVR_VER_E6500)
>   		return -ENODEV;
>
>   	return register_fsl_emb_pmu(&e6500_pmu);
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 72238eedc360..30dd379ddcd3 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1583,16 +1583,16 @@ static int hv_24x7_init(void)
>   {
>   	int r;
>   	unsigned long hret;
> +	unsigned int pvr = mfspr(SPRN_PVR);
>   	struct hv_perf_caps caps;
>
>   	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>   		pr_debug("not a virtualized system, not enabling\n");
>   		return -ENODEV;
> -	} else if (!cur_cpu_spec->oprofile_cpu_type)
> -		return -ENODEV;
> +	}
>
>   	/* POWER8 only supports v1, while POWER9 only supports v2. */
> -	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
> +	if (PVR_VER(pvr) == PVR_POWER8)
>   		interface_version = 1;
>   	else {
>   		interface_version = 2;
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index d115c5635bf3..17e69cabbcac 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -413,8 +413,9 @@ struct power_pmu mpc7450_pmu = {
>
>   static int __init init_mpc7450_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if (PVR_VER(pvr) != PVR_7450)
>   		return -ENODEV;
>
>   	return register_power_pmu(&mpc7450_pmu);
> diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
> index 0526dac66007..17a32e7ef234 100644
> --- a/arch/powerpc/perf/power5+-pmu.c
> +++ b/arch/powerpc/perf/power5+-pmu.c
> @@ -679,9 +679,9 @@ static struct power_pmu power5p_pmu = {
>
>   static int __init init_power5p_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
> -	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if (PVR_VER(pvr) != PVR_POWER5p)
>   		return -ENODEV;
>
>   	return register_power_pmu(&power5p_pmu);
> diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
> index 4dc99f9f7962..844782e6d367 100644
> --- a/arch/powerpc/perf/power5-pmu.c
> +++ b/arch/powerpc/perf/power5-pmu.c
> @@ -620,8 +620,9 @@ static struct power_pmu power5_pmu = {
>
>   static int __init init_power5_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if (PVR_VER(pvr) != PVR_POWER5)
>   		return -ENODEV;
>
>   	return register_power_pmu(&power5_pmu);
> diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
> index 9c9d646b68a1..9659b781f588 100644
> --- a/arch/powerpc/perf/power6-pmu.c
> +++ b/arch/powerpc/perf/power6-pmu.c
> @@ -542,8 +542,9 @@ static struct power_pmu power6_pmu = {
>
>   static int __init init_power6_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if (PVR_VER(pvr) != PVR_POWER6)
>   		return -ENODEV;
>
>   	return register_power_pmu(&power6_pmu);
> diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
> index 6dbae9884ec4..79f05a7f28c6 100644
> --- a/arch/powerpc/perf/power7-pmu.c
> +++ b/arch/powerpc/perf/power7-pmu.c
> @@ -447,11 +447,12 @@ static struct power_pmu power7_pmu = {
>
>   static int __init init_power7_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if ((PVR_VER(pvr) != PVR_POWER7) && (PVR_VER(pvr) != PVR_POWER7p))
>   		return -ENODEV;
>
> -	if (pvr_version_is(PVR_POWER7p))
> +	if (PVR_VER(pvr) == PVR_POWER7p)
>   		power7_pmu.flags |= PPMU_SIAR_VALID;
>
>   	return register_power_pmu(&power7_pmu);
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index d12a2db26353..81a5142efab0 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -382,9 +382,10 @@ static struct power_pmu power8_pmu = {
>   static int __init init_power8_pmu(void)
>   {
>   	int rc;
> +	unsigned int pvr = mfspr(SPRN_PVR);
>
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
> +	if ((PVR_VER(pvr) != PVR_POWER8E) && (PVR_VER(pvr) != PVR_POWER8NVL)
> +			&& PVR_VER(pvr) != PVR_POWER8)
>   		return -ENODEV;
>
>   	rc = register_power_pmu(&power8_pmu);
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
> index 0ff9c43733e9..6b414b8bedfd 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -438,9 +438,7 @@ static int __init init_power9_pmu(void)
>   	int rc = 0;
>   	unsigned int pvr = mfspr(SPRN_PVR);
>
> -	/* Comes from cpu_specs[] */
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
> +	if (PVR_VER(pvr) != PVR_POWER9)
>   		return -ENODEV;
>
>   	/* Blacklist events */
> diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
> index 8b6a8a36fa38..5832de10e073 100644
> --- a/arch/powerpc/perf/ppc970-pmu.c
> +++ b/arch/powerpc/perf/ppc970-pmu.c
> @@ -492,9 +492,11 @@ static struct power_pmu ppc970_pmu = {
>
>   static int __init init_ppc970_pmu(void)
>   {
> -	if (!cur_cpu_spec->oprofile_cpu_type ||
> -	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
> -	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +
> +	if ((PVR_VER(pvr) != PVR_970) && (PVR_VER(pvr) != PVR_970MP)
> +			&& (PVR_VER(pvr) != PVR_970FX)
> +			&& (PVR_VER(pvr) != PVR_970GX))
>   		return -ENODEV;
>
>   	return register_power_pmu(&ppc970_pmu);

