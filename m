Return-Path: <linuxppc-dev+bounces-28968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12660CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 13:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzdCC1JwRz30St;
	Wed, 07 Oct 2026 00:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791295127;
	cv=none; b=NfXzOqkE4TX1RQBZhjEKXVhX0u1bK3cocUjLkmoQHjvnrO6n+xh8g7YNkfemyP743UafKaaD/9M2BbIKB2vIXCzlzynHGaTex7YQSRYLZDb/jbHX5cgp8TytlBJNEWWBlVmLe3xnXnFRjp2XSXfp0yYkafeLao6zkZqNCtwBvByqiPzbwm8CwE6OBC+HAoNysnuWX1gtnB2PJimDJxVlMOrkaXfpHLype0y/CM16QmXwzWFXXWXZF1tAgtUNdZztRm/KvJG5LaFzibkquTDjJxsaz+OGkx6eUlcX68QfNfOz0sYhNpINsiDargci4gfNDmAEQRY2n4kGE7/FyQhEow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791295127; c=relaxed/relaxed;
	bh=sgIr83zOZHVl7MlkGAJxaEc21xQu1v0d31dNnuEpTkY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=efugrD5TvEokpa5bKcGlHwYN89I1a8h8rAWCT6h7baW9nF94KfZegkzL1DBbBTRs09zAj2V/FXqaB0XU2S3FjqNNsTB1m9TW91y64PUMLY556a0z0uCjmIDQQ8YNwYK3CfiKhiGDXrFBunHG/bb9PJ1O038jaWi3PdvEoUCXHYPnrfswY4IjwXlJ9P6rlnynGIkK65jkvDQ02/Ptj4piuXTrbjvY36XSYgLLCRN+QW9Tq++WR01dq5K70N1rgdxK4g5FL0Gq+fMrSrFST7PSy541S54rH+2N7bjNp3CKhZlrI7KhlfPLbiPb0Y7KPtbEI8j9RkmJ/iezPo5jcHklew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r3CfSwU+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r3CfSwU+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzdC92ns3z2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 00:58:44 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Da5k52651870;
	Tue, 6 Oct 2026 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sgIr83
	zOZHVl7MlkGAJxaEc21xQu1v0d31dNnuEpTkY=; b=r3CfSwU+trr50SpIkOG46+
	hWH6xwG8m++qmjIxMvnF17E0GRLBJpC+/Npu1KlYAcYwiYWmnoChhDPssIreZ+WE
	XB48IsDOq7DJEUUKRLMvHG2ImRN7BRw5jTRRQNZ6k47ptiM3wbhFWT+gkBYJB9jN
	17AgAR9E0Efegi+6sCZrBHVrFL8vPkL13P9Al6sbbgolOC3lN1R9agurN+8VDme6
	QOpoRT3xvZmE2eP5t7dFqL5uWZ+W36Ta/ljuSE/LDvldZZcrGZqDTtdYRxyBPEhD
	azSenagcYY5SUWQ3rB6DJNsHXvo/yL31ETv7K8CK1DcrE61kc0a+7dX2aJKSR0UQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fyjgb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 13:58:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWl0W403698;
	Tue, 6 Oct 2026 13:58:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgt3cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 13:58:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696DwSH532113246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 13:58:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C858020040;
	Tue,  6 Oct 2026 13:58:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB30A20043;
	Tue,  6 Oct 2026 13:58:23 +0000 (GMT)
Received: from [9.43.50.104] (unknown [9.43.50.104])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 13:58:23 +0000 (GMT)
Message-ID: <c70ab987-2e82-4792-a129-19d4999009ff@linux.ibm.com>
Date: Tue, 6 Oct 2026 19:30:54 +0530
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
To: Haren Myneni <hbabu@us.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "ritesh.list@gmail.com" <ritesh.list@gmail.com>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>,
        "chleroy@kernel.org" <chleroy@kernel.org>,
        "shivangu@linux.ibm.com" <shivangu@linux.ibm.com>,
        "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
        "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
        "adityag@linux.ibm.com" <adityag@linux.ibm.com>,
        "venkat88@linux.ibm.com" <venkat88@linux.ibm.com>
References: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
 <20260824081202.264913-3-sourabhjain@linux.ibm.com>
 <DS5PR15MB70054353A2CCE5A34BEBF9EB87972@DS5PR15MB7005.namprd15.prod.outlook.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <DS5PR15MB70054353A2CCE5A34BEBF9EB87972@DS5PR15MB7005.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4fe89 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=WQEazEW5rJ3jnQMXGIwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX2DEehAAilQOY
 aghc3SfcdgKHtfCAUp5kN8LAsbSdxjt/KYzbtZH/8E1Vl0uxUfX2TrXKtQffCOHxEZ6rCuh/v32
 D1NPuoBdLgjMNMpJmdbsHGs9C0+0nWpkiqh+VZdRoYHEL491DcAbe+sfDoo/f5HolGQmw4hJ/KY
 xfAyY8zU65VBf9u2T3vx4EL+IE9Z3kwcpxKPVGFjzCorgbgCtu9m1SCpajzQwOWaGyFn7MbSEnQ
 7MoCAhjlvuh2cgtUI3wm/1EUxlFygcNa0Bxu1pemLkNqvshSy3/mV9EsfRNX2irNcs8EDyaIQ2K
 /HnwGKTaVO7JpWSJX7NdYiVN5Xy0TjhqJP7P/Q+M/qOe0Md7IAVwdtb3x6c0OTqWlJRBCcElqYn
 6eJUkXXqcdhzkQGy9Wa9AaxuK5y25AfDFCUAy5cTB8OxRGraevD7K1/RhBx5hofQQary+FinxIo
 h6O4m46sAZQyyoYNKHQ==
X-Proofpoint-GUID: kxIMWZ8WimLKNXyBaDbwa3YNj_KzjGF0
X-Proofpoint-ORIG-GUID: nj08kHpJLI2QLDsQUEEsa0ywUy6qJJ1b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX2v7pYhHDt5QT
 /bmnximgXOll489bb5JMzXC2YyY9PR09yzFisNgcC3gflHr+CJrPdkcpTg3Z0AVHLDPY/H6dHaz
 i9ei1tP37yEGlsJ58Wp2wO5l1tDV2Qw=
Subject: Re:  [PATCH v3 2/4] powerpc: move to 64-bit RTAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060054

Hi Haren,

On 04/10/26 14:39, Haren Myneni wrote:
> If "ibm,rtas-64-capable" property is available in 
> /proc/device-tree/rtas, there is no need to add new "linux,rtas-64" 
> property.

Agreed, linux,rtas-64 is redundant, and I will remove it in the next 
version.

Thanks for the review.

- Sourabh Jain

> ------------------------------------------------------------------------
> *From:* Sourabh Jain <sourabhjain@linux.ibm.com>
> *Sent:* Monday, August 24, 2026 1:12 AM
> *To:* linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>; 
> maddy@linux.ibm.com <maddy@linux.ibm.com>; mpe@ellerman.id.au 
> <mpe@ellerman.id.au>; ritesh.list@gmail.com <ritesh.list@gmail.com>
> *Cc:* npiggin@gmail.com <npiggin@gmail.com>; chleroy@kernel.org 
> <chleroy@kernel.org>; shivangu@linux.ibm.com <shivangu@linux.ibm.com>; 
> hbathini@linux.ibm.com <hbathini@linux.ibm.com>; mahesh@linux.ibm.com 
> <mahesh@linux.ibm.com>; adityag@linux.ibm.com <adityag@linux.ibm.com>; 
> venkat88@linux.ibm.com <venkat88@linux.ibm.com>; Sourabh Jain 
> <sourabhjain@linux.ibm.com>
> *Subject:* [EXTERNAL] [PATCH v3 2/4] powerpc: move to 64-bit RTAS
> Kdump kernels loaded at high addresses (above 4G) could not boot
> because the kernel used 32-bit RTAS.
>
> Until now, the kernel always used 32-bit RTAS, even for 64-bit kernels.
> Before making an RTAS call, it clears the SF bit in MSR and uses LR as
> the return address from RTAS. For kdump kernels loaded above 4G, RTAS
> returns to a 32-bit truncated LR address, typically causing an exception
> and kernel panic.
>
> Fix this by switching to 64-bit RTAS support on systems where firmware
> advertises "ibm,rtas-64-capable". The kernel instantiates 64-bit RTAS,
> passes RTAS arguments using a 64-bit argument structure, and sets the
> SF bit in MSR before entering RTAS. This ensures RTAS can correctly
> return to addresses above 4G and allows high-address kdump kernels to
> boot successfully.
>
> If 64-bit RTAS is not supported or initialization fails, the kernel
> continues to use 32-bit RTAS. In that case, high-address kdump kernels
> will not be allowed (handled in upcoming patches), and RTAS calls will
> continue to run with the SF bit cleared.
>
> Changes made to support 64-bit RTAS:
> - Detect firmware support using "ibm,rtas-64-capable"
> - Initialize 64-bit RTAS in prom_init and add a new FDT property
>   "linux,rtas-64"
> - Read "linux,rtas-64" during boot and track RTAS mode using rtas_64
> - Add 64-bit RTAS argument handling and return value conversion
> - Prepare MSR appropriately for 32-bit or 64-bit RTAS calls
>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas-types.h |  8 +++++
>  arch/powerpc/include/asm/rtas.h       |  2 ++
>  arch/powerpc/kernel/prom_init.c       | 20 +++++++++--
>  arch/powerpc/kernel/rtas.c            | 48 +++++++++++++++++++++++++--
>  arch/powerpc/kernel/rtas_entry.S      | 17 +++++++++-
>  5 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/rtas-types.h 
> b/arch/powerpc/include/asm/rtas-types.h
> index 5d40d187b965..8a54647a87f4 100644
> --- a/arch/powerpc/include/asm/rtas-types.h
> +++ b/arch/powerpc/include/asm/rtas-types.h
> @@ -14,6 +14,14 @@ struct rtas_args {
>          rtas_arg_t *rets;     /* Pointer to return values in args[]. */
>  } __aligned(8);
>
> +struct rtas_args_64 {
> +       __be64 token;
> +       __be64 nargs;
> +       __be64 nret;
> +       __be64 args[16];
> +       __be64 *rets;     /* Pointer to return values in args[]. */
> +} __aligned(8);
> +
>  struct rtas_t {
>          unsigned long entry;            /* physical address pointer */
>          unsigned long base;             /* physical address pointer */
> diff --git a/arch/powerpc/include/asm/rtas.h 
> b/arch/powerpc/include/asm/rtas.h
> index d046bbd5017d..aaa4c3bc1d61 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -10,6 +10,8 @@
>  #include <linux/time.h>
>  #include <linux/cpumask.h>
>
> +extern int rtas_64;
> +
>  /*
>   * Definitions for talking to the RTAS on CHRP machines.
>   *
> diff --git a/arch/powerpc/kernel/prom_init.c 
> b/arch/powerpc/kernel/prom_init.c
> index 53503937de0e..be7c5ea0b75d 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1841,6 +1841,7 @@ static void __init prom_instantiate_rtas(void)
>          u32 base, entry = 0;
>          __be32 val;
>          u32 size = 0;
> +       u32 rtas_64 = 0;
>
>          prom_debug("prom_instantiate_rtas: start...\n");
>
> @@ -1865,15 +1866,24 @@ static void __init prom_instantiate_rtas(void)
>                  return;
>          }
>
> +       /* Check for rtas 64-bit support */
> +       if (prom_getprop(rtas_node, "ibm,rtas-64-capable",
> +                        &val, sizeof(val)) != PROM_ERROR) {
> +               rtas_64 = 1;
> +               prom_debug("Node ibm,rtas-64-capable: %x\n", val);
> +       }
> +
>          prom_printf("instantiating rtas at 0x%x...", base);
>
> +       const char *method = rtas_64 ? "instantiate-rtas-64" : 
> "instantiate-rtas";
> +
>          if (call_prom_ret("call-method", 3, 2, &entry,
> -                         ADDR("instantiate-rtas"),
> -                         rtas_inst, base) != 0
> -           || entry == 0) {
> +                         ADDR(method), rtas_inst, base) != 0 ||
> +                         entry == 0) {
>                  prom_printf(" failed\n");
>                  return;
>          }
> +
>          prom_printf(" done\n");
>
>          reserve_mem(base, size);
> @@ -1884,6 +1894,9 @@ static void __init prom_instantiate_rtas(void)
>          val = cpu_to_be32(entry);
>          prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
>                       &val, sizeof(val));
> +       val = cpu_to_be32(rtas_64);
> +       prom_setprop(rtas_node, "/rtas", "linux,rtas-64",
> +                    &val, sizeof(val));
>
>          /* Check if it supports "query-cpu-stopped-state" */
>          if (prom_getprop(rtas_node, "query-cpu-stopped-state",
> @@ -1893,6 +1906,7 @@ static void __init prom_instantiate_rtas(void)
>          prom_debug("rtas base     = 0x%x\n", base);
>          prom_debug("rtas entry    = 0x%x\n", entry);
>          prom_debug("rtas size     = 0x%x\n", size);
> +       prom_debug("rtas 64-bit   = 0x%x\n", rtas_64);
>
>          prom_debug("prom_instantiate_rtas: end...\n");
>  }
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8d81c1e7a8db..873e54238d2f 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -45,6 +45,8 @@
>  #include <asm/trace.h>
>  #include <asm/udbg.h>
>
> +int rtas_64;
> +
>  struct rtas_filter {
>          /* Indexes into the args buffer, -1 if not used */
>          const int buf_idx1;
> @@ -569,6 +571,7 @@ static struct rtas_function rtas_function_table[] 
> __ro_after_init = {
>   */
>  static DEFINE_RAW_SPINLOCK(rtas_lock);
>  static struct rtas_args rtas_args;
> +static struct rtas_args_64 rtas_args_64;
>
>  /**
>   * rtas_function_token() - RTAS function token lookup.
> @@ -690,13 +693,48 @@ static const struct rtas_function 
> *rtas_token_to_function(s32 token)
>          return NULL;
>  }
>
> +static void populate_rtas_args_64(struct rtas_args *args)
> +{
> +       int i;
> +
> +       rtas_args_64.token = 
> cpu_to_be64((s64)(s32)be32_to_cpu(args->token));
> +       rtas_args_64.nargs = 
> cpu_to_be64((s64)(s32)be32_to_cpu(args->nargs));
> +       rtas_args_64.nret  = 
> cpu_to_be64((s64)(s32)be32_to_cpu(args->nret));
> +       rtas_args_64.rets  = &rtas_args_64.args[be32_to_cpu(args->nargs)];
> +
> +       for (i = 0; i < be32_to_cpu(args->nargs); ++i)
> +               rtas_args_64.args[i] = 
> cpu_to_be64((s64)(s32)be32_to_cpu(args->args[i]));
> +
> +       for (i = 0; i < be32_to_cpu(args->nret); ++i)
> +               rtas_args_64.rets[i] = 0;
> +}
> +
> +static void rtas_args_copy_64_32(struct rtas_args *args)
> +{
> +       int i;
> +
> +       for (i = 0; i < (s32)be64_to_cpu(rtas_args_64.nret); ++i)
> +               args->rets[i] = 
> cpu_to_be32((s32)be64_to_cpu(rtas_args_64.rets[i]));
> +}
> +
>  /* This is here deliberately so it's only used in this file */
>  void enter_rtas(unsigned long);
>
> +static void _do_enter_rtas_64(struct rtas_args *args)
> +{
> +       populate_rtas_args_64(args);
> +       enter_rtas(__pa(&rtas_args_64));
> +       rtas_args_copy_64_32(args);
> +}
> +
>  static void __do_enter_rtas(struct rtas_args *args)
>  {
> -       enter_rtas(__pa(args));
> -       srr_regs_clobbered(); /* rtas uses SRRs, invalidate */
> +       if (rtas_64)
> +               _do_enter_rtas_64(args);
> +       else
> +               enter_rtas(__pa(args));
> +
> +       srr_regs_clobbered();
>  }
>
>  static void __do_enter_rtas_trace(struct rtas_args *args)
> @@ -2078,7 +2116,7 @@ void __init rtas_initialize(void)
>  int __init early_init_dt_scan_rtas(unsigned long node,
>                  const char *uname, int depth, void *data)
>  {
> -       const u32 *basep, *entryp, *sizep;
> +       const u32 *basep, *entryp, *sizep, *val;
>
>          if (depth != 1 || strcmp(uname, "rtas") != 0)
>                  return 0;
> @@ -2086,6 +2124,10 @@ int __init early_init_dt_scan_rtas(unsigned 
> long node,
>          basep  = of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
>          entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
>          sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
> +       val    = of_get_flat_dt_prop(node, "linux,rtas-64", NULL);
> +
> +       if (val && *val)
> +               rtas_64 = 1;
>
>  #ifdef CONFIG_PPC64
>          /* need this feature to decide the crashkernel offset */
> diff --git a/arch/powerpc/kernel/rtas_entry.S 
> b/arch/powerpc/kernel/rtas_entry.S
> index 6ce95ddadbcd..df776f0103c9 100644
> --- a/arch/powerpc/kernel/rtas_entry.S
> +++ b/arch/powerpc/kernel/rtas_entry.S
> @@ -54,6 +54,10 @@ _ASM_NOKPROBE_SYMBOL(enter_rtas)
>  /*
>   * 32-bit rtas on 64-bit machines has the additional problem that 
> RTAS may
>   * not preserve the upper parts of registers it uses.
> + *
> + * Note: In 64-bit RTAS, the SF bit is set so that RTAS can return
> + * correctly if the return address is above 4 GB. Everything else
> + * works the same as in 32-bit RTAS.
>   */
>  _GLOBAL(enter_rtas)
>          mflr    r0
> @@ -113,7 +117,18 @@ __enter_rtas:
>           * from the saved MSR value and insert into the value RTAS 
> will use.
>           */
>          extrdi  r0, r6, 1, 63 - MSR_HV_LG
> -       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)
> +
> +       LOAD_REG_ADDR(r7, rtas_64)      /* Load the address rtas_64 
> into r7 */
> +       ld      r8, 0(r7)               /* Load the value of rtas_64 
> from memory into r8 */
> +       cmpdi   r8, 0                   /* Compare r8 with 0 (check if 
> rtas_64 is zero) */
> +       beq     no_sf_bit               /* Branch to no_sf_bit if 
> rtas_64 is zero */
> +       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI | MSR_SF)        /* r6 
> = ME|RI|SF */
> +       b       continue
> +
> +no_sf_bit:
> +       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)         /* r6 = ME|RI 
> (NO SF bit in MSR) */
> +
> +continue:
>          insrdi  r6, r0, 1, 63 - MSR_HV_LG
>
>          li      r0,0
> -- 
> 2.55.0
>
>


