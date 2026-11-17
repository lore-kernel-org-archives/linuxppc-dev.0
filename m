Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5221606A887
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LxY3RYX4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTVJD2VyDz2xPb;
	Wed, 18 Nov 2026 03:17:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794932268;
	cv=none; b=lva1ZYy3nXYHvC2UT3h1YHNxIDM9Eg1jMBwpR3ft9HT9LX2SrJ5FZ5Wg4WpPzABbNi8OnQxyR0oK32Yzna71HriM87AmXpykScZHCePMIxGOfTsKrHjIBV2+2k4EZ301eTIDCYZrRCvzfNnzYaqGlvNPG2ekcW+dAq6WgswQT2ezl1KAwShJ8m5t0h2RFEwGgQ4X7SXUOaTk7bK4TxA2qQ1Jpf/EtIj8gEP+16R7FpTXaNxuB5LHvyb9bleGpxQE5agQM2Q2cJVc2Qww/OxoowjP+G3Uy+2x4W+UQiVfaU7YKq6WtsKYOMEnm7HhI8h2DgdwSiTAbIDZJ0rbQZZAng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794932268; c=relaxed/relaxed;
	bh=Q57TmUUo3BmI5QnXMFTxqhjXB7ogwKyz1o3p0R7xaxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abLrLiDOjXlC+YYDotUlcNEXBzYPvvcgD81f49Yh5amft2374Za0d7/KS7BzcgQLQg+xlIFRX7SDtBpzr7Dctkk679S3Dkua0EztcoDBI3aF0NuDIhBxgQOOtRaGqCLaeVftEuK241ks4AR6ncRfGr45t2AUV5gwffoFWne+m4RzTZ+eI+RLRUPViQrD0c8WZ3NJKg8x/7QWbJMYyiwT9ocWikJ1gPOz1mnTAX4fFCs5uJ+jORcZB2SkBGMCYyDsOiG7i8qoA9iLntlk5nBscts6zFShP5yhnRdoNBB5Tmb+ZNsF9P9QWom+RGJq5BmYwCh4UmKctisZ4g/ibD92kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LxY3RYX4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LxY3RYX4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTVJC2hz9z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:17:47 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQgw92711695;
	Tue, 17 Nov 2026 16:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q57TmU
	Uo3BmI5QnXMFTxqhjXB7ogwKyz1o3p0R7xaxE=; b=LxY3RYX4LSQLqyzz2EOKN6
	GdnpGU4ttCn/JpKzdnBM54Y8wsjmwiqsrn8RJspl+VHa/vtHx0T9lPJ4+5WKqML/
	I9rFKcCJNTK+X1DBK7yr3F2Xc3cm4+ntuWCE+/7RsSMRQM12yMF9w52UoZ0eOB+T
	IZQSpupJk/v80+EpljwNLb1Ves8UBVsXnPOmQFlbyzr6k+lBVyjx+NbmNxwL/Pb5
	KnOSmMvh+L8PzFPX5vPtpfgbjsMe+yxiYy5iByxTTYMYBZo/qwGb01ryEB97IGIL
	JF/BOskEEGHcC+ebw+q5fjDBtZ6sWeoTT9R84cX4waAqFoC7fWqk5GNtOCjxY2HQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2m3rrd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:17:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYuHW657668;
	Tue, 17 Nov 2026 16:17:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nseac8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:17:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHGHWGo23069414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 16:17:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0F4358060;
	Tue, 17 Nov 2026 16:17:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D3F5805F;
	Tue, 17 Nov 2026 16:17:27 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 16:17:27 +0000 (GMT)
Message-ID: <7bfeaeae-975c-482a-b469-d417244dba6e@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:47:25 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] powerpc/perf: mpc7450: Export event names in sysfs
To: Matt Turner <mattst88@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
 <20261109-ppc32-perf-v1-8-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-8-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afc7e1e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=CnTRze1K2R-K5JjHI3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YrBIf7kAzRC1DkK9L4tWjVhAk58t3-eF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX+4AcfI9EB1oK
 /zS8DhmdF5LfLbDKnPtPgkryXieNbgVD06eLlzwwf28c/aT9sIQwOAfGFyQl2fbhI8nPV94pBKA
 8FnkObEJMi9ksfeAvuHNP0YvUH17wy8=
X-Proofpoint-ORIG-GUID: pPMx4YIob9xKz3et06v0tbJ26RPBjhMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfXyXXE1KTzLmjN
 qYdK9Tm8MtAxl8yBMhfxTvBxYBJEMdaELwQ1IR64ADwcgY+Gcseol7vT/v39JJAYNzAfu74UiQh
 1CSf7fpp/3Q048Ky+J8XiL1KhrAdBfkIPcwhntesyf7bMcebpj6T5EuxLu/f7n065Hbptk/asl7
 Des3aFNBx8TsaW6Cd/t1/VRs88610Gm0ytu3p2CZnTbH1Peopaiq0HEOQtft2fH28C8xtCzbcqd
 H3wAv9+aHNdy7FhUqjOLFamz60ukYyJBic+QpuInB7bD7n9ZE4fdK2YNMcA/kwkpuWLoLe7EVfu
 v+cBUz0f1VMteILb1CMH18c3Tac0/F/jQ2WxDqrcd75vMcPOwRUfBkQLsq5fA2BmW8tmYWAdaqr
 qIobr93LuzYyrM5+i1F0cvwEJlv6tB8DzWxrTmBU9uxRLZF5c5yKXIU6Y16lOe+DljWTg2UDMTo
 zWk9l/dv3Mn/RGqo3Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 7:17 AM, Matt Turner wrote:
> perf list shows only the generic events for the MPC7450 family, so every
> other event has to be written as a raw code.
>
> Name the events in the manual (MPC7450UM Rev. 5, Tables 11-9 to 11-14)
> in mpc7450-events-list.h, as the POWER7 driver does.  An event that
> several PMCs implement at the same select value is listed once without
> a PMC, so the driver still picks the counter.  An event repeated at
> different select values is listed once and reached through the
> alternatives table, whose comments now use the same names.  223 names
> cover all 279 non-reserved select values.
>
> The 7441, 7445, 7447, 7447A and 7448 have no L3, and their L3 events
> are reserved.  Hide the L3 names when CPU_FTR_L3CR is clear, which is
> on the 7447A and 7448.  The 7441, 7445 and 7447 share their PVRs with
> the 7451, 7455 and 7457 and get CPU_FTR_L3CR, so they keep them.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

I compared the new event list with the event tables in the manual
(Tables 11-9 to 11-14), and the names and codes I spot-checked match.

I also checked the CPU_FTR_L3CR part of the commit message against
cputable.h: the flag is clear only for the 7447A and 7448, which
matches the L3 event handling.


Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah
> ---
>   arch/powerpc/perf/mpc7450-events-list.h | 250 ++++++++++++++++++++++++++++++++
>   arch/powerpc/perf/mpc7450-pmu.c         |  68 ++++++++-
>   2 files changed, 315 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/perf/mpc7450-events-list.h b/arch/powerpc/perf/mpc7450-events-list.h
> new file mode 100644
> index 000000000000..b79f2fc675bf
> --- /dev/null
> +++ b/arch/powerpc/perf/mpc7450-events-list.h
> @@ -0,0 +1,250 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Performance counter events for MPC7450-family processors, from the
> + * MPC7450 RISC Microprocessor Family Reference Manual, Rev. 5, tables 11-9
> + * to 11-14.
> + *
> + * Codes below 0x100 are the events that several PMCs implement with the
> + * same select value; the driver picks the counter.  Events that exist on
> + * more than one PMC under different select values are listed once, and
> + * the others are found through the alternatives table.
> + *
> + * EVENT_L3() events count only on parts with an L3 cache interface.
> + */
> +
> +/* Events available on several PMCs */
> +EVENT(PM_CYC,				0x001)
> +EVENT(PM_INST_CMPL,			0x002)
> +EVENT(PM_TBL_BIT_TRANS,			0x003)
> +EVENT(PM_INST_DISP,			0x004)
> +EVENT(PM_PMEXC,				0x005)
> +EVENT(PM_PMON_IN,			0x007)
> +EVENT(PM_VPU_CMPL,			0x008)
> +EVENT(PM_VFPU_CMPL,			0x009)
> +EVENT(PM_VIU1_CMPL,			0x00a)
> +EVENT(PM_VIU2_CMPL,			0x00b)
> +EVENT(PM_MTVSCR_CMPL,			0x00c)
> +EVENT(PM_MTVRSAVE_CMPL,			0x00d)
> +EVENT(PM_VPU_OPND_WAIT_CYC,		0x00e)
> +EVENT(PM_VFPU_OPND_WAIT_CYC,		0x00f)
> +EVENT(PM_VIU1_OPND_WAIT_CYC,		0x010)
> +EVENT(PM_VIU2_OPND_WAIT_CYC,		0x011)
> +EVENT(PM_MFVSCR_SYNC_CYC,		0x012)
> +EVENT(PM_VSCR_SAT_SET,			0x013)
> +EVENT(PM_ST_CMPL,			0x014)
> +EVENT(PM_L1_ICACHE_MISS,		0x015)
> +EVENT(PM_L1_DCACHE_SNOOP,		0x016)
> +
> +/* PMC1 */
> +EVENT(PM_BR_UNRESOLVED,			0x117)
> +EVENT(PM_BR_SPEC_BUF1_CYC,		0x118)
> +EVENT(PM_BR_UNIT_STALL_CYC,		0x119)
> +EVENT(PM_BR_TARGET_HIT,			0x11a)
> +EVENT(PM_BR_LINK_STACK_PRED,		0x11b)
> +EVENT(PM_GPR_IQ_DISP,			0x11c)
> +EVENT(PM_DISP_3_CYC,			0x11d)
> +EVENT(PM_INSTQ_EXCEED_CYC,		0x11e)
> +EVENT(PM_ALTV_IQ_EXCEED_CYC,		0x11f)
> +EVENT(PM_NO_CMPL_CYC,			0x120)
> +EVENT(PM_IU2_CMPL,			0x121)
> +EVENT(PM_BR_CMPL,			0x122)
> +EVENT(PM_EIEIO_CMPL,			0x123)
> +EVENT(PM_MTSPR_CMPL,			0x124)
> +EVENT(PM_SC_CMPL,			0x125)
> +EVENT(PM_LD_STR_MULT_CMPL,		0x126)
> +EVENT(PM_ITLB_SEARCH_CYC,		0x127)
> +EVENT(PM_DTLB_SEARCH_EXCEED_CYC,	0x128)
> +EVENT(PM_L1_ICACHE_ACCESS,		0x129)
> +EVENT(PM_IABR_MATCH,			0x12a)
> +EVENT(PM_LD_MISS_EXCEED_L1_CYC,		0x12b)
> +EVENT(PM_L1_DCACHE_SNOOP_HIT_MOD,	0x12c)
> +EVENT(PM_LD_MISS_ALIAS,			0x12d)
> +EVENT(PM_LD_MISS_ALIAS_TOUCH,		0x12e)
> +EVENT(PM_TOUCH_ALIAS,			0x12f)
> +EVENT(PM_L1_DCACHE_SNOOP_HIT_COQ,	0x130)
> +EVENT(PM_L1_DCACHE_SNOOP_HIT_CO,	0x131)
> +EVENT(PM_L1_DCACHE_SNOOP_HIT,		0x132)
> +EVENT(PM_WT_ST,				0x133)
> +EVENT(PM_CI_ST,				0x134)
> +EVENT(PM_L1_DCACHE_LD_HIT,		0x135)
> +EVENT(PM_L1_DCACHE_TOUCH_HIT,		0x136)
> +EVENT(PM_L1_DCACHE_ST_HIT,		0x137)
> +EVENT(PM_L1_DCACHE_HIT,			0x138)
> +EVENT(PM_DST_DISP,			0x139)
> +EVENT(PM_DST_REFRESH,			0x13a)
> +EVENT(PM_DST_SEARCH,			0x13b)
> +EVENT(PM_DSS_CMPL,			0x13c)
> +EVENT(PM_DST0_FETCH,			0x13d)
> +EVENT(PM_VTQ_SUSPEND,			0x13e)
> +EVENT(PM_VTQ_FETCH_HIT,			0x13f)
> +EVENT(PM_VEC_LD_CMPL,			0x140)
> +EVENT(PM_FP_ST_CMPL,			0x141)
> +EVENT(PM_FP_ST_RENORM,			0x142)
> +EVENT(PM_FP_ST_DENORM,			0x143)
> +EVENT(PM_FP_ST_STALL_CYC,		0x144)
> +EVENT(PM_LSU_TRUE_ALIAS_STALL,		0x146)
> +EVENT(PM_LSU_INDEX_ALIAS_STALL,		0x147)
> +EVENT(PM_LSU_ALIAS_FSQ,			0x148)
> +EVENT(PM_LSU_ALIAS_CSQ,			0x149)
> +EVENT(PM_LSU_LD_HIT_ALIAS_CSQ0,		0x14a)
> +EVENT(PM_LSU_LD_MISS_ALIAS_CSQ0,	0x14b)
> +EVENT(PM_LSU_TOUCH_ALIAS_FSQ,		0x14c)
> +EVENT(PM_LSU_TOUCH_ALIAS_CSQ,		0x14d)
> +EVENT(PM_LSU_LMQ_FULL_STALL,		0x14e)
> +EVENT(PM_FP_LD_CMPL,			0x14f)
> +EVENT(PM_FP_LD_SINGLE_CMPL,		0x150)
> +EVENT(PM_FP_LD_DOUBLE_CMPL,		0x151)
> +EVENT(PM_LSU_RA_LATCH_STALL,		0x152)
> +EVENT(PM_LSU_LD_ST_ALIAS_STALL,		0x153)
> +EVENT(PM_LSU_LMQ_INDEX_ALIAS,		0x154)
> +EVENT(PM_LSU_STQ_INDEX_ALIAS,		0x155)
> +EVENT(PM_LSU_CSQ_FWD,			0x156)
> +EVENT(PM_LSU_MISALIGN_LD_FIN,		0x157)
> +EVENT(PM_LSU_MISALIGN_ST_CMPL,		0x158)
> +EVENT(PM_LSU_MISALIGN_STALL,		0x159)
> +EVENT(PM_FPSCR_RENAME_QTR_BUSY,		0x15a)
> +EVENT(PM_FPSCR_RENAME_HALF_BUSY,	0x15b)
> +EVENT(PM_FPSCR_RENAME_3QTR_BUSY,	0x15c)
> +EVENT(PM_FPSCR_RENAME_FULL,		0x15d)
> +EVENT(PM_FP_DENORM_RESULT,		0x15e)
> +
> +/* PMC2 */
> +EVENT(PM_L1_DCACHE_MISS,		0x217)
> +EVENT(PM_FPR_IQ_DISP,			0x218)
> +EVENT(PM_LSU_CMPL,			0x219)
> +EVENT(PM_LD_CMPL,			0x21a)
> +EVENT(PM_ST_STR_MULT_CMPL,		0x21b)
> +EVENT(PM_TLBIE_CMPL,			0x21c)
> +EVENT(PM_LWARX_CMPL,			0x21d)
> +EVENT(PM_MFSPR_CMPL,			0x21e)
> +EVENT(PM_REFETCH_SERIAL,		0x21f)
> +EVENT(PM_CQ_EXCEED_CYC,			0x220)
> +EVENT(PM_CMPL_1_CYC,			0x221)
> +EVENT(PM_DISP_2_CYC,			0x222)
> +EVENT(PM_ITLB_MISS,			0x223)
> +EVENT(PM_L1_ICACHE_MISS_CYC,		0x224)
> +EVENT(PM_L1_DCACHE_LD_MISS,		0x225)
> +EVENT(PM_L1_DCACHE_TOUCH_MISS,		0x226)
> +EVENT(PM_L1_DCACHE_ST_MISS,		0x227)
> +EVENT(PM_L1_DCACHE_TOUCH_MISS_CYC,	0x228)
> +EVENT(PM_L1_DCACHE_BUSY_CYC,		0x229)
> +EVENT(PM_DST1_FETCH,			0x22a)
> +EVENT(PM_VTQ_CANCEL,			0x22b)
> +EVENT(PM_VTQ_RESUME,			0x22c)
> +EVENT(PM_VTQ_FETCH_MISS,		0x22d)
> +EVENT(PM_VTQ_FETCH,			0x22e)
> +EVENT(PM_TLBIE_SNOOP,			0x22f)
> +EVENT(PM_L1_ICACHE_RELOAD,		0x230)
> +EVENT(PM_L1_DCACHE_RELOAD,		0x231)
> +EVENT(PM_L1_DCACHE_CASTOUT,		0x232)
> +EVENT(PM_ST_MERGE,			0x233)
> +EVENT(PM_ST_MERGE_32B,			0x234)
> +EVENT(PM_DABR_MATCH,			0x235)
> +EVENT(PM_BR_FALLTHRU,			0x236)
> +EVENT(PM_BR_SPEC_BUF1_OK,		0x237)
> +EVENT(PM_BR_SPEC_BUF2_CYC,		0x238)
> +EVENT(PM_BR_LR_STALL_CYC,		0x239)
> +EVENT(PM_BTIC_MISS,			0x23a)
> +EVENT(PM_BR_LINK_STACK_OK,		0x23b)
> +EVENT(PM_FPR_IQ_STALL,			0x23c)
> +EVENT(PM_PR_SWITCH,			0x23d)
> +EVENT(PM_FP_ST_SINGLE_CMPL,		0x23e)
> +
> +/* PMC3 */
> +EVENT(PM_CMPL_2_CYC,			0x308)
> +EVENT(PM_DISP_1_CYC,			0x309)
> +EVENT(PM_VR_IQ_DISP,			0x30a)
> +EVENT(PM_VR_IQ_STALL,			0x30b)
> +EVENT(PM_GPR_RB_EXCEED_CYC,		0x30c)
> +EVENT(PM_FPR_IQ_ENTRIES,		0x30d)
> +EVENT(PM_FPU_CMPL,			0x30e)
> +EVENT(PM_STWCX_CMPL,			0x30f)
> +EVENT(PM_LD_STR_MULT_PIECES,		0x310)
> +EVENT(PM_ITLB_SEARCH_EXCEED,		0x311)
> +EVENT(PM_DTLB_MISS,			0x312)
> +EVENT(PM_L1_ICACHE_MISS_CANCEL,		0x313)
> +EVENT(PM_L1_DCACHE_OP_HIT,		0x314)
> +EVENT(PM_L1_DCACHE_LD_MISS_CYC,		0x315)
> +EVENT(PM_L1_DCACHE_PUSH,		0x316)
> +EVENT(PM_VT2_FETCH,			0x318)
> +EVENT(PM_BR_TAKEN,			0x319)
> +EVENT(PM_BR_FLUSH,			0x31a)
> +EVENT(PM_BR_SPEC_BUF2_OK,		0x31b)
> +EVENT(PM_BR_SPEC_BUF3_CYC,		0x31c)
> +EVENT(PM_BR_CTR_STALL_CYC,		0x31d)
> +EVENT(PM_FBTIC_HIT,			0x31e)
> +EVENT(PM_BR_LINK_STACK_MPRED,		0x31f)
> +
> +/* PMC4 */
> +EVENT(PM_CMPL_3_CYC,			0x40e)
> +EVENT(PM_DISP_0_CYC,			0x40f)
> +EVENT(PM_GPR_IQ_EXCEED_CYC,		0x410)
> +EVENT(PM_GPR_IQ_STALL_CYC,		0x411)
> +EVENT(PM_IU1_CMPL,			0x412)
> +EVENT(PM_DSSALL_CMPL,			0x413)
> +EVENT(PM_TLBSYNC_CMPL,			0x414)
> +EVENT(PM_SYNC_CMPL,			0x415)
> +EVENT(PM_ST_STR_MULT_PIECES,		0x416)
> +EVENT(PM_DTLB_SEARCH_CYC,		0x417)
> +EVENT(PM_LSU_SNOOP_RETRY,		0x418)
> +EVENT(PM_STWCX_OK,			0x419)
> +EVENT(PM_DST3_FETCH,			0x41a)
> +EVENT(PM_BR_SPEC_BUF3_OK,		0x41b)
> +EVENT(PM_BR_MPRED,			0x41c)
> +EVENT(PM_BR_FOLDED,			0x41d)
> +EVENT(PM_FP_ST_DOUBLE_CMPL,		0x41e)
> +
> +/* PMC5 */
> +EVENT(PM_L2_HIT,			0x502)
> +EVENT_L3(PM_L3_HIT,			0x503)
> +EVENT(PM_L2_ICACHE_MISS,		0x504)
> +EVENT_L3(PM_L3_ICACHE_MISS,		0x505)
> +EVENT(PM_L2_DCACHE_MISS,		0x506)
> +EVENT_L3(PM_L3_DCACHE_MISS,		0x507)
> +EVENT(PM_L2_LD_HIT,			0x508)
> +EVENT(PM_L2_ST_HIT,			0x509)
> +EVENT_L3(PM_L3_LD_HIT,			0x50a)
> +EVENT_L3(PM_L3_ST_HIT,			0x50b)
> +EVENT(PM_L2_TOUCH_HIT,			0x50d)
> +EVENT_L3(PM_L3_TOUCH_HIT,		0x50e)
> +EVENT(PM_INT_RETRY,			0x50f)
> +EVENT(PM_SNOOP_MOD,			0x510)
> +EVENT(PM_SNOOP_VALID,			0x511)
> +EVENT(PM_INTV_LOCAL,			0x512)
> +EVENT(PM_L2_MISS,			0x513)
> +EVENT_L3(PM_L3_MISS,			0x514)
> +
> +/* PMC6 */
> +EVENT(PM_L2_CASTOUT,			0x608)
> +EVENT_L3(PM_L3_CASTOUT,			0x609)
> +EVENT(PM_L2SQ_FULL_CYC,			0x60a)
> +EVENT_L3(PM_L3SQ_FULL_CYC,		0x60b)
> +EVENT(PM_SNOOP_RETRY,			0x60f)
> +EVENT_L3(PM_L3_RAQ_FULL_CYC,		0x610)
> +EVENT_L3(PM_L3_WAQ_FULL_CYC,		0x611)
> +EVENT(PM_L1_EXT_INTV,			0x613)
> +EVENT(PM_L2_EXT_INTV,			0x614)
> +EVENT_L3(PM_L3_EXT_INTV,		0x615)
> +EVENT(PM_EXT_INTV,			0x616)
> +EVENT(PM_EXT_PUSH,			0x617)
> +EVENT(PM_EXT_SNOOP_RETRY,		0x618)
> +EVENT(PM_DTQ_FULL_CYC,			0x619)
> +EVENT(PM_BUS_RETRY,			0x61a)
> +EVENT(PM_L2_VALID_REQ,			0x61b)
> +EVENT(PM_BORDQ_FULL_CYC,		0x61c)
> +EVENT(PM_BUS_TA_RD,			0x62a)
> +EVENT(PM_BUS_TA_WR,			0x62b)
> +EVENT(PM_BUS_RD_OK,			0x62c)
> +EVENT(PM_BUS_WR_OK,			0x62d)
> +EVENT(PM_BUS_RDWR_OK,			0x62e)
> +EVENT(PM_BUS_RETRY_L1,			0x62f)
> +EVENT(PM_BUS_RETRY_ADJ,			0x630)
> +EVENT(PM_BUS_RETRY_COLLISION,		0x631)
> +EVENT(PM_BUS_RETRY_INTV_ORDER,		0x632)
> +EVENT(PM_SNOOP_REQ,			0x633)
> +EVENT(PM_L2_PREF,			0x634)
> +EVENT(PM_L2_PREF_LD_COLLISION,		0x635)
> +EVENT(PM_L2_PREF_ST_COLLISION,		0x636)
> +EVENT(PM_L2_PREF_IFETCH_COLLISION,	0x637)
> +EVENT(PM_L2_PREF_LMQ_COLLISION,		0x638)
> +EVENT(PM_L2_PREF_FULL,			0x639)
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index 9bed5c238f45..4ee7b1a822ea 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -22,6 +22,18 @@
>   #define PM_PMC_MSK	7
>   #define PM_PMCSEL_MSK	0x7f
>   
> +/*
> + * MPC7450 event codes.
> + */
> +#define EVENT(_name, _code)	_name = _code,
> +#define EVENT_L3(_name, _code)	_name = _code,
> +
> +enum {
> +#include "mpc7450-events-list.h"
> +};
> +#undef EVENT
> +#undef EVENT_L3
> +
>   /*
>    * Classify events according to how specific their PMC requirements are.
>    * Result is:
> @@ -190,11 +202,11 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
>   	{ 0x505, 0x605, 0x621 },	/* PM_L3_ICACHE_MISS */
>   	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
>   	{ 0x507, 0x607, 0x622 },	/* PM_L3_DCACHE_MISS */
> -	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
> -	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
> +	{ 0x50a, 0x623 },		/* PM_L3_LD_HIT */
> +	{ 0x50b, 0x624 },		/* PM_L3_ST_HIT */
>   	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
>   	{ 0x50e, 0x60e, 0x625 },	/* PM_L3_TOUCH_HIT */
> -	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
> +	{ 0x512, 0x612 },		/* PM_INTV_LOCAL */
>   	{ 0x513, 0x61d },		/* PM_L2_MISS */
>   	{ 0x514, 0x61e, 0x620 },	/* PM_L3_MISS */
>   };
> @@ -398,6 +410,55 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>   	},
>   };
>   
> +#define EVENT(_name, _code)	POWER_EVENT_ATTR(_name, _name);
> +#define EVENT_L3(_name, _code)	POWER_EVENT_ATTR(_name, _name);
> +#include "mpc7450-events-list.h"
> +#undef EVENT
> +#undef EVENT_L3
> +
> +#define EVENT(_name, _code)	POWER_EVENT_PTR(_name),
> +#define EVENT_L3(_name, _code)	POWER_EVENT_PTR(_name),
> +
> +static struct attribute *mpc7450_events_attr[] = {
> +#include "mpc7450-events-list.h"
> +	NULL
> +};
> +
> +#undef EVENT
> +#undef EVENT_L3
> +
> +static bool mpc7450_is_l3_event(u64 event)
> +{
> +	switch (event) {
> +#define EVENT(_name, _code)
> +#define EVENT_L3(_name, _code)	case _code:
> +#include "mpc7450-events-list.h"
> +#undef EVENT
> +#undef EVENT_L3
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/* The L3 events are reserved on parts without an L3 interface. */
> +static umode_t mpc7450_events_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int n)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
> +	if (mpc7450_is_l3_event(pmu_attr->id) && !cpu_has_feature(CPU_FTR_L3CR))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group mpc7450_pmu_events_group = {
> +	.name = "events",
> +	.attrs = mpc7450_events_attr,
> +	.is_visible = mpc7450_events_is_visible,
> +};
> +
>   PMU_FORMAT_ATTR(event,		"config:0-18");
>   PMU_FORMAT_ATTR(pmcsel,		"config:0-6");
>   PMU_FORMAT_ATTR(pmc,		"config:8-10");
> @@ -420,6 +481,7 @@ static const struct attribute_group mpc7450_pmu_format_group = {
>   
>   static const struct attribute_group *mpc7450_pmu_attr_groups[] = {
>   	&mpc7450_pmu_format_group,
> +	&mpc7450_pmu_events_group,
>   	NULL,
>   };
>   
>

