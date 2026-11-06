Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC8606A333
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acznaWDr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLkTr661Nz2xNC;
	Sat, 07 Nov 2026 03:02:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793980960;
	cv=none; b=og/+qv8SQKvARjhRit7fdN8cvxnu1iEuHwW02L/Dskkjx7tkSsFlWUciTdOb+NP7evHaBuatQhOIaOUV/AK2cQWxUa1A3kvtADFBg0VWsySXTDo/ezogh6OBdBSWSOwfrWSjpfNy+bu/PvEhixo8tsjxoZPB/kPFr60bZMyiWvJRCAVeEbdPRs6EpK4Sf2oz56UAR4oJbuwGHiqcLJSVvBHFDX+9CA/fOoV5Y5CbOlnL+U+xo/eYJugz0TTQWep4zqFTvMnzvK4uVnZNB+PkhOW4aWmQ5lgcTGgHI0+xlrgMtaCKasEWamxvjlBfjAVRDRFHLbhDBgBnaFm/41ESxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793980960; c=relaxed/relaxed;
	bh=hB4t7lomzunxZk0X0m05JMwXZ0SRZi/SUaDJWWyv2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtbBGWHBQ/rlEmg9vhTAYt5ewB3+a/EEmjTpzulMBK4zgV9HEqcXVbjs76NM1hJsG+SU1vClSu2LYaHwPC6Q9/ENGUi1rqdoZExvUZr/gOQTn1TjR8cqvHOaKYvhZaj7s1ABsmTSO5EjCb/24XQXD6HiUwDxBEUFSdWiztwaEkOyM8v5kajdUfcfxIRWxZxP4HH+/7Zf9hpmBdgCfIQgee73XnjFv9mJyHEVYHrhHSLOzUqHit2ymIF/+MrIyc+q/kK/g0I1BptjAzMAIWSUMgCp6Wi1hNSA7cRaTEwgjZxAQIVabJhQ33lsb6GyFZ4rMx2nmhb6eThycLJBjvS4Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acznaWDr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acznaWDr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLkTq5r66z2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 03:02:39 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE9JQ2726688;
	Fri, 6 Nov 2026 16:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hB4t7lomzunxZk0X0m05JMwXZ0SRZi
	/SUaDJWWyv2/A=; b=acznaWDrm3C8X8dMZOufO4t0sVPuS3zc1xYhVpkXtBZVCi
	5eTVaqQN0EDaKN1xyByhEy/5mYf9oZGhELEk1WhsNHeFMuPaqaej+4rFSA0qYDsw
	zR2yvb5gB1/NG19N/O+zAcLH/Bnp2/R+Q7b1IV2F3w0hKMe57HfOToDMRnqtZFnR
	On2TILkkV7ty+ANJS0bL/1/Sk/63kGzVyF4TdAlB2lXW1CQkY+V5X5ymd19tsA3a
	ISyHuoT7D+fZi7B2HIEpF4IYEqN3WBEe6tGxt6APOmhPVQw3W/ZOjEfoexH+6lzs
	74utCs2LhdefIu6idsdG9qgFGvn7iZltOJvDgxww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9ddue-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:02:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xrk3538379;
	Fri, 6 Nov 2026 16:02:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mt2p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:02:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G2NHc36897042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:02:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6656920040;
	Fri,  6 Nov 2026 16:02:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E8582004B;
	Fri,  6 Nov 2026 16:02:20 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.29.160])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Nov 2026 16:02:20 +0000 (GMT)
Date: Fri, 6 Nov 2026 21:32:18 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        atrajeev@linux.ibm.com, tshah@linux.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] powerpc/perf: Fix vpa-pmu driver to report
 correct numbers
Message-ID: <au35t73S10aXgpYi@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
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
In-Reply-To: <20261106153136.330165-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aedfa14 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=jjOfc4w_Om44QiH6-5AA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gv41lfcRHMda00r8k1NQBgu2bPir9Rnt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX2M57DSAyjsYO
 mudStF14o7h1KyA4jwUoHFFqiRMk8iMS7VeyFAQPDOojnFDR1qx5CyvshcXoIUHt5dZVknGNSez
 3NMLGPq9I0Qd75ziDUdYnfSBz+Rb+Ko=
X-Proofpoint-ORIG-GUID: DdOAsDceh1iOtpLystqEkO3lhpRnxU3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5Px/oIZS0u0w
 96bBqRNbdpek1wFfTuP+kX1yWT3gnUV+DklyM2qO8tPEd5COhCxCQ/kaSYq1/L1epybYbKy9UxH
 xoqo/34Oc4YlEydCHzeiD+VoTthG/v6mywLPW7Cqu5SEbTIDdetvDrQ6GU5okFpSa2g7piI4CA6
 00WArMBob+lkmRy2uAohMprCsIk+4/ELSSJe1F/7Z6pFtFelbhEoAwX8W6BkAz1SnCIKvxCFP+z
 M780qg6OAntKC7Wkrqe1S7zFqzK+mpEpesUe6H33dpzXUEFIpvw4doid91Rno0iTpyUEopMC/i8
 KjT2DQfYISOJpy4XjEHWLKq+56rZ5i9ZFZBhtpGIs+HHyRJrt9YnHg0jJRWeb7zLkwk3+7qtyeu
 f9RP32/EHuAdtQzp9DZZt0OQrxrlertgEFaSohvdh9sOBh3ek/e+ECauR4arjwuvkEvzJVnyevU
 buVVBDQNAttfC37x5pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Forgot to add linuxppc-dev

On Fri, Nov 06, 2026 at 09:01:31PM +0530, Gautam Menghani wrote:
> The vpa-pmu driver can sometimes report incorrect context switch latency
> numbers:
> 
> $ perf stat -e vpa_pmu/l1_to_l2_lat/  --tid=2061  -I 1000
>            time             counts unit events
>      1.001022517 18,446,744,073,708,177,408      vpa_pmu/l1_to_l2_lat/
>      2.002120674            345,092      vpa_pmu/l1_to_l2_lat/
>      3.003171582            406,342      vpa_pmu/l1_to_l2_lat/
>      4.004234838            340,836      vpa_pmu/l1_to_l2_lat/
> 
> These invalid numbers are observed because of 2 issues:
> 
> 1. The PACA never points to the correct vCPU running on a host vCPU when
> vpa_pmu_add() is called.
> 
> 2. When get_counter_data() reads the PACA counter values, it does not
> update the event->hw.prev_count.
> 
> 
> Changes in V3:
> 1. Drop the usage of the PACA's vCPU pointer.
> 2. Introduce a new patch to fix an issue seen when a tracepoint and vpa-pmu
> driver concurrently enable/disable access to latency counters in VPA.
> 
> 
> Gautam Menghani (3):
>   Revert "powerpc/perf: Add per-task/process monitoring to vpa_pmu
>     driver"
>   powerpc/perf: Update prev_count of event to get accurate values
>   KVM: PPC: Book3s HV: Ensure reliable usage of latency counters
> 
>  arch/powerpc/include/asm/kvm_book3s_64.h |  3 --
>  arch/powerpc/kvm/book3s_hv.c             | 54 +++---------------------
>  arch/powerpc/perf/vpa-pmu.c              | 16 ++-----
>  3 files changed, 11 insertions(+), 62 deletions(-)
> 
> -- 
> 2.56.0
> 

