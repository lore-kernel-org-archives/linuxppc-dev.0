Return-Path: <linuxppc-dev+bounces-29262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6F7CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 13:26:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3JCF6pZLz30Vm;
	Tue, 13 Oct 2026 00:26:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791811593;
	cv=none; b=Ag3U3lLifjGNTjlkBI6gVKm1KBu9udkaE1SNGGqSeg6dpP05eSFO32f1TrREfpDJusqQ9F3wY6VvSvpckHEjA3OWDNh0hQOrRNwy/X1CPsnXVk3zH8pT4qW+tA2/Aeople1uMK6IiXlrl3Sk27E1cFSv+3XuUMk9GwYThco/mr+5jUSIhTjWQKUS5S6uwZBqeFwoSmQ29uZKPDVKlGs4w2KCzEV0IsnqCd5wl6/s/v3jYX1o2u8FcV7jsekMC5ySx2e8xtNSVp+/Mri4w+UCXy2mycmepn0/Fm4yxckdwvkh1tl5TTiXkKKUjSL8leFKb2BE/X9Z7JVKYx5EPTSNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791811593; c=relaxed/relaxed;
	bh=GUYlqyKxKql6FAaCntzk9cYIBEamwNPoquU1fOHk61I=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPHysddMzlQu3wyxTa7xZcuBL6nqS+rF80c1f0f7kJHFRdjxRJVo2h/u1OLwO87hKbBTWpsh/idZTZfo0M3cubjEjPa86W2P/3/GUpkxeyYuWvfoGp6pssL8h5xtBoN59HJ5hP6ZHxfSEDkw8o0btE63WRmlAzPrcq44rHWCLbfq+DqjSNkXGaQY3Uyn5kxvbAND3WZY0r+h12qmijLPbNO4kk5BXVtYFUk5MLx8V+F2wXbon4AmBXYue8o3YC74/n8yIhajqHMTPAhMN291ILTap85VXaL1adAh/ZaoepGIdBioOTzY2ZHbv4jhk5b1w8o9Gb53ikzaL/+3VwiiTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WfLLQ9bU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WfLLQ9bU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3JCD4fMbz30VX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 00:26:32 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE8Mt2640423;
	Mon, 12 Oct 2026 13:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject; s=pp1; bh=GUYlqyKxKql6FAaCntzk9cYIBEamwNPoq
	uU1fOHk61I=; b=WfLLQ9bUldD453vLhtb5eS12klyIgIsBQnX7W5t3B8vS81l04
	NYjj83kRGFJysY2Nxu2itRk6LCwBAI/e81iRl2IKdDHzpQbvVDUoHeQu2qDMNuQX
	/Jg7u1krFGD27uBDY9vH9DbutIVlS1BLt7uj0UliAATUdtNHZR/WcL6krg4gJbR5
	CbD0wEz3TXSPW3Nzppw2rqS5coyIhStKU7bfCbX90KtWJizTDIGAZsikUFbgVII8
	lOvJUtblkp5puQqJSPUNQ89zIHa/3VoQ5+Ad57eYQw1S8u56cklM3Ri5e0/zRuD0
	I1xiUQJVKnz02c2y+YlHTs2evzO/rvseddYSA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh932c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:26:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uFh013441;
	Mon, 12 Oct 2026 13:26:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfw50x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:26:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDQKgw17039820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:26:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3301B20043;
	Mon, 12 Oct 2026 13:26:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4834820040;
	Mon, 12 Oct 2026 13:26:18 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.29.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 13:26:17 +0000 (GMT)
Date: Mon, 12 Oct 2026 18:56:14 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/configs: Add debug configs for debugging
Message-ID: <aszfA9umcPYKs737@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260827121309.94434-1-gautam@linux.ibm.com>
 <asyep4EEG-lNR72Z@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
 <35446573-c8ba-414a-8a0d-d682a84d589e@linux.ibm.com>
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
In-Reply-To: <35446573-c8ba-414a-8a0d-d682a84d589e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX8WEwfgTIZAUb
 qlHJYBxQdttAk8ykkmHX1HSZkDRB6CBNAOOkqij1A8eUDrInj/sHTKtS3onuLo1TuNnz0YakCk7
 UP8Zbebi1dBNcFBIRLSK2bw37mhulPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX0BkPCpJ/egPS
 emiJpPcgCz1FlTHFrxmnSzrRRSWIxXqNva6dNAepFIRexN7rsKqwcdNgBQR1JBtiOIWEmztFTSg
 C95pOaRwpc7aPQzkKuMu2KO/2du4PIf8Y0TSJA/GqjNuw5y1tyArG6UAGgvZ7CgWvyX5E/Yv07p
 8QAqTUiqir96OdYdrZW/i5M7f5eBqHndn675ViDr9mdVL7XYrTEu1Evq253Lktw8g7le5FuoQw6
 Ir5/4t5TV7jfpRhfNOFTgUJTiH6hSeg/bNuJPH4jQ8Paz34nTPvGkk3BBLZDrFLsuYtvNoVul2b
 0cDS17dxxpQc3+IeT36AelCjZpMyjxV9i5hwSHQEe72fsXqTAzHoV8oswdJi4A8zABcHtiERrhI
 c+A1xIoSksYn0J9Yry11sNCj4Wai4aDcK1517b927EN2V54j2kaMspAIdgLy+4bc7IgbnYU74rT
 XZ5H+dDFkh0oJ6bkhfA==
X-Proofpoint-GUID: vV4a7VpOv9utEQsGNHYEyMHcOmcaIOii
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accdfff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=9cW_t1CCXrUA:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=lpS_LIIzD_JwdL8Ji4UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wcUTq7we8mWWtn84FV7s1xOKd1XtzEKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120052

On Mon, Oct 12, 2026 at 02:35:03PM +0530, Shrikanth Hegde wrote:
> Hi Gautam.
> 
> On 10/12/26 2:20 PM, Gautam Menghani wrote:
> > Hi,
> > 
> > Can this patch be pulled in? Or is something else needed here?
> > 
> > Thanks,
> > Gautam
> 
> Why it can't be part of existing debug.config? Why add component specific
> config and merge into def config?
> 
> Wouldn't that cause more confusion? If not, could you please add detail in
> changelog on how one can make use of these?

The issue with adding all options to debug.config is that if all options
are enabled at the same time, performance will take a huge hit.
Grouping the options by area will enable devs to only enable a subset of
configs. With this patch, you can just do "make pseries_mm_debug_defconfig"
to enable mm specific options for example.

I'm open to suggestions if there is a cleaner way to accomplish this.

Thanks,
Gautam

