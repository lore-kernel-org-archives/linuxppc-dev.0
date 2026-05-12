Return-Path: <linuxppc-dev+bounces-20759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9371ACD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:37:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF92C247qz2yY0;
	Tue, 12 May 2026 18:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575043;
	cv=none; b=M2B6x4WUDW2QrRbo6jLgwWFA+RzaFkfXODErrMWrivLFNJB5OLSdBfa25xyuKbaEaeLOqqUAEq4OX3RtmFGGriXEFwseQEDqnuFSLNGzOcSv0QWnmUEzKH4maU2EpGCLf18Lxo4ksVyIU6yb0tbb8+B9WYkqwUdFAqvJKU062hHdc6ALwacFz421JQnmc/NGFfkhgX8EIkoymgBroUuinzb8E0JunRkq/kGXc3JymOyBDoEeWwifl+9aQRReCEu2CSUHuOzDr/zg9+hEGESD0OJoiRcHndOBmUhRLkCSp/THwcwE+gTSjgiE/4ATaHGQP+g8NuYYBY9pmuBe1pNZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575043; c=relaxed/relaxed;
	bh=H8gZvhDiJcfPj4izdPoeTyKzYez876PA3k9XPRRUrF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bw3SSvqClrPjxEN4MP5woBjMZB4VV300Ag8fQZApANHwxLk32I0qNmhz9MHJwE6nRv76t+4VrvCuilDSJNHkaGYjpQG1ZVu7/3xhQY1550MfP15kHX4RXniaKvK3P/iJ/GKFjoleCR97PYfWFYUDb0Hd8nTZ1a90C6k9AoK3dqc9X8xR4bY4NtkUyWfMVCbZP0T2rOuXnqZ/89ZaszZGBlGGhSAueDj5lUiT/C1VkuKO5YNlto5Pu+EjQtGIJWDZ8cpqLIUKQqjwptaoNLH2PkG4pkObHTZlRicKLgOoY3fZFpq8yB3kDx0TSRWxXYDwElSiIf9ofMNlEKv0C4Rxxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JFKfrhPq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JFKfrhPq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF92B1HXqz2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:37:21 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7H352760537;
	Tue, 12 May 2026 08:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=H8gZvhDiJcfPj4izdPoeTyKzYez876
	PA3k9XPRRUrF0=; b=JFKfrhPq8nUkfghkSxPLnz3TlK6envyHBf7rktLvSsXHmy
	iH1t0d6K4J710TpSKiT8tF9xje+oiyMy8ICvD6VMeIcSTcCn7NCtgOA0mj70X+Bl
	SDP6eWNiQ6MOqJ37gRiXulrHHDWpjKnmelcjgVSxmGkdynJ3AzQ7j6sBtuJJT4eK
	NntESoFIr/UIYKAe4aVr8qNbn/IB/MoR8M7KEN5ydLcAuet5pbAJgwSxazRbuq1l
	CdDSzaXZS8UacvRj3C/IQJf5dUikwWKwGPZfvA1MuoCqH2AA4zNG5vkYFLY88ddF
	UhbhTD5RaGfpLjM/k7jHyd+uK+IOxAMXs+OYBD/Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6j24w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:37:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C8OXsn028662;
	Tue, 12 May 2026 08:37:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjb95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:37:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C8b2S325821758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 08:37:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD3A58059;
	Tue, 12 May 2026 08:37:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5EF458043;
	Tue, 12 May 2026 08:36:57 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.192])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Tue, 12 May 2026 08:36:57 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Tue, 12 May 2026 14:06:55 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
In-Reply-To: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
Date: Tue, 12 May 2026 14:06:55 +0530
Message-ID: <87pl31uiqg.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nU0nISuR4Dqqy-ix_PCeP0TTyaIL8XvG
X-Proofpoint-GUID: KMAjbdqZw1a388q652BZ71xGUDq0AL35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NiBTYWx0ZWRfX21zcGlj/4oYi
 +mHmsCfhLL7CRqOq08J+bp0jRQxj2DZRsLgEdY2C0yOhPCupP7StLghLuZt24lFKu88cYDEFNYN
 djDl4gbF4nwyUdZf52QOLQRwOmK2EMpqWqPBLPmPhzQQYI291SOP+xWTZS0pWvjP/1+/kUxluR8
 +Qrq7zMHBSddBRIo58gtVOWmMpGGIofs7rgre+LFASvPyDXtdfP14Xh47vklkDbN0l37zt0byWP
 CItPw2cdJOE2sk9czVpq45oRgpBej1dY8x57TQxOFllQBMspXtsoKCaPvpoq5OHISKoPhoGBIEI
 3bVO+IGRTsr6JH39wzILWTvV6rFH1GEt+5uYg3ei22BpjPYeewEO1gQ6GsEuFWbJ3RK6OLRvtdO
 TyshK9C+55j4tWHXSEC/6sI1XfLaG3zfN9viq+LdoIcpmgsKwikwYweqkWfRiARqrJ6stPYZKSW
 XhR8QpQozFN3Qf/+0Lg==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a02e6b0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ycv1Ynx4oPle2U8RHYcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120086


Thanks Gautam catching this and proposing this patch.
Minor review comments below:

Gautam Menghani <Gautam.Menghani@ibm.com> writes:

> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Remove the trailing comma after last element
>
>  arch/powerpc/kvm/trace_book3s.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..5d272c115331 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>  	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}
Also add trap of 0x000 indicating "RETURN_TO_HOST"

Also sychronize the contents of the proposed changes for this header with the
libtraceevent header file tools/perf/util/kvm-stat-arch/book3s_hv_exits.h

>  
>  #endif
> -- 
> 2.52.0
>
>

With above minor fixes done, feel free to add:

Reviewed-by: Vaibhav Jain (IBM) <vaibhav@linux.ibm.com>
-- 
Cheers
~ Vaibhav

