Return-Path: <linuxppc-dev+bounces-27013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DC9C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgVtG01bJz2yFK;
	Thu, 10 Sep 2026 18:18:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789028293;
	cv=none; b=SMm8MTycB0OMJMeM8MsoroQSBQ3oyUHENn1uN8K2FNZyhbtB3rd241pVGMmpQDjWZYwli9nh0dm+7GbZEbMb09lCDOniex0Xvv4NX2imqqTrlnv6wCAoXWcz3Xjp49aFNsAWgL2WxHKKCTIIqAsE8kt0/jFij3pVQBbvnkqyGwyfWpW54BNwcVtw1Ai9TlWrRkrNO6vmMUGjny2hlNTRHYNSA/AFt85sL7/7lq7jlajvhXhVjHuVC8vjD2Qz/mmN/VyQSlDfD4av84iHQpwvoDtDMvt0zDab2auUiHi++IBRL5XdKhQllNWwJbaIkhaJQSJTVrqRUGi+y/kYuFuS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789028293; c=relaxed/relaxed;
	bh=xcWA8OfzIl/1JTdb9sWCRDlEAq0LdexvG/EQYE67/ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctdOc1mEZ84bLdGPAfmkEh/cgvHptyWxyX5zYuACz/iP/D92jAP2Q/9CegtQlFVOPyMv9vO+rEm5Kgu5IyUIHyh8gLD4a/NZLV6YQZvl9iZzUiAh3y0sRR7whTiqTHDFJyUJJQzptmqAy1h7h1uWeNneGTocmt8uI3vb2qbvf9/CeI6J5I65n0GWoRexQsKiqwcng9rNQuuf/+rVdk2+Z8nVP2f91xBp29H5ZKhs4kmXx3zPLDUN0ofYDnAg38JQOZocDUgxaCsYtfnyoMsG9dU+MxoSgrvfNHKu5ybAWaK5upWO8aDTwynp+Q66fOuojc9xGBRto/k8Y5HTJTXH8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dk8yarjf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dk8yarjf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgVtF1MFmz2y2S
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 18:18:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VRg91973303;
	Thu, 10 Sep 2026 08:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xcWA8OfzIl/1JTdb9sWCRDlEAq0Lde
	xvG/EQYE67/ZM=; b=dk8yarjf+v67cjKOBbQ/MqLsczPKBVoloH+HWWrzn2JJ4p
	UdIreN/0B9rkH5dLv/lBMUUlmTRLHVKpyk1Lj7g/GElQ0sXUCIICQkH5dYmzKTFb
	91wyw08dEeruqo/Pc2sjgqWmCp4DjYGi2Vfyg6R4nkc5tj22X9VxCnhWh6bM/LrZ
	vLGIKkUO1TrDO5SmlfM0Rn4ZsLYh3E6ViawfKocYf+DOWmI26QT48gNs/GYJKQWT
	/YbAybq6GT9iGVINKQxrF0QqWEVV6j3JKVU2ydhTSSzLKPNdurSOl8U49LpRXOGZ
	B2qNMnaY0AZ4Q2r5mun4Y1cElJxPF6oFdkudy5/w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pk98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 08:17:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7uYGw014691;
	Thu, 10 Sep 2026 08:17:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bahv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 08:17:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A8Hs9M26542796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 08:17:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D00212004B;
	Thu, 10 Sep 2026 08:17:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C6B020043;
	Thu, 10 Sep 2026 08:17:53 +0000 (GMT)
Received: from dhcp-9-123-3-18.bl1-in.ibm.com (unknown [9.123.3.18])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Sep 2026 08:17:52 +0000 (GMT)
Date: Thu, 10 Sep 2026 13:47:50 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Fix guest state buffer kernel-doc names and
 parameters
Message-ID: <aqJnrkTAeSM2RVvt@dhcp-9-123-3-18.bl1-in.ibm.com>
References: <20260910033655.16127-1-kmehltretter@gmail.com>
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
In-Reply-To: <20260910033655.16127-1-kmehltretter@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa267b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=yuWOQlAcragr5604HYQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: grMzTpSfcn7vjL6lM51qlosSdQ48hvBv
X-Proofpoint-GUID: UoFhnGY08Fqpin8o9UUgksUaWgwqtvAq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfXxczAwHCyde6w
 8V6g3h52xGBXOUycrqDaYhveMOfnXbbwR8dLu1WmmiNNXH/lqmu+n6tvT9Tw38i4leF9DhKERzq
 TSV1ErkPpTHNyKvksOWYoGEGeDDwjXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfX9vg6g7JjztSX
 u+0b/U14RRhohrRhWa4EvKpHcbxyjhLwL9wrJFPWgUXEjXp/xZMBkYpJsTqqyxu0tWyKQUCsIXq
 YYYIrQJDr0nKzfsVduJsmlYFPmLqWuZBg849WpQlBWxolvwiQImGP/Sr+lTujC1U6HKlH4CDG+t
 uzc/I//4tbfE8yLi7E5tMHE6vFPvQZgEcyoRF6Jv0I5FdnQwD1wJeebh7C2xZ+tzuKSAN3/UcZb
 jflRTNoc3pJOiClK/jzWT9UHMFh0Mn8MKwI2h7dwetQIpS7Kbb9WwhzoEJ/J26P3gzB8h3NYCTv
 1Lnaf7YQTJgRwS/IxYFqY9tfi5t63MpAZHxsnuB3Qf8SMZ/GcesjEH3/5xx0WMnlRQMK8oyXlt+
 MBEoilpZIXe07PvzhzaQg8ShbG94SeN5WnGRqy0k8Q+9YRtsfqJXkn4r9dToY2ray8ysIjvf5H8
 /gAU8K2EZ610mA4I1+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100088

On Thu, Sep 10, 2026 at 05:36:55AM +0200, Karl Mehltretter wrote:
> Several guest state buffer comments use copied function or parameter
> names. In particular, kvmppc_gsm_for_each() describes a parser and an
> element argument, although it takes a message and yields IDs.
> kvmppc_gsm_include_all() also describes an ID argument it does not take.
> 
> Match the headings and parameter descriptions to their declarations,
> and describe the parser argument and vector output with their actual
> roles.
> 
> Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/powerpc/include/asm/guest-state-buffer.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/guest-state-buffer.h b/arch/powerpc/include/asm/guest-state-buffer.h
> index acd61eb36d59..95d50ec7f2a9 100644
> --- a/arch/powerpc/include/asm/guest-state-buffer.h
> +++ b/arch/powerpc/include/asm/guest-state-buffer.h
> @@ -224,7 +224,7 @@ struct kvmppc_gs_buff_info {
>  
>  /**
>   * struct kvmppc_gs_header - serialized guest state buffer header
> - * @nelem: count of guest state elements in the buffer
> + * @nelems: count of guest state elements in the buffer
>   * @data: start of the stream of elements in the buffer
>   */
>  struct kvmppc_gs_header {
> @@ -779,6 +779,7 @@ static inline u64 kvmppc_gse_get_u64(const struct kvmppc_gs_elem *gse)
>  /**
>   * kvmppc_gse_get_vector128() - return the data of a vector element
>   * @gse: guest state element
> + * @v: output vector in host endianness
>   */
>  static inline void kvmppc_gse_get_vector128(const struct kvmppc_gs_elem *gse,
>  					    vector128 *v)
> @@ -849,7 +850,7 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
>  /**
>   * kvmppc_gsp_for_each - iterate the <guest state IDs, guest state element>
>   * pairs
> - * @gsp: guest state buffer bitmap
> + * @gsp: guest state parser
>   * @iden: current guest state ID
>   * @gse: guest state element
>   */
> @@ -866,9 +867,8 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
>  /**
>   * kvmppc_gsm_for_each - iterate the guest state IDs included in a guest state
>   * message
> - * @gsp: guest state buffer bitmap
> + * @gsm: guest state message
>   * @iden: current guest state ID
> - * @gse: guest state element
>   */
>  #define kvmppc_gsm_for_each(gsm, iden)                            \
>  	for (iden = kvmppc_gsbm_next(&gsm->bitmap, 0); iden != 0; \
> @@ -908,10 +908,9 @@ static inline bool kvmppc_gsm_includes(struct kvmppc_gs_msg *gsm, u16 iden)
>  }
>  
>  /**
> - * kvmppc_gsm_includes - indicate all guest state IDs should be included when
> + * kvmppc_gsm_include_all - indicate all guest state IDs should be included when
>   * serializing
>   * @gsm: guest state message
> - * @iden: guest state ID
>   */
>  static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
>  {
> @@ -919,7 +918,7 @@ static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
>  }
>  
>  /**
> - * kvmppc_gsm_include - clear the guest state IDs that should be included when
> + * kvmppc_gsm_reset - clear the guest state IDs that should be included when
>   * serializing
>   * @gsm: guest state message
>   */
> @@ -958,7 +957,7 @@ static inline int kvmppc_gsb_receive_data(struct kvmppc_gs_buff *gsb,
>  }
>  
>  /**
> - * kvmppc_gsb_recv - receive a single guest state ID
> + * kvmppc_gsb_receive_datum - receive a single guest state ID
>   * @gsb: guest state buffer
>   * @gsm: guest state message
>   * @iden: guest state identity
> @@ -998,7 +997,7 @@ static inline int kvmppc_gsb_send_data(struct kvmppc_gs_buff *gsb,
>  }
>  
>  /**
> - * kvmppc_gsb_recv - send a single guest state ID
> + * kvmppc_gsb_send_datum - send a single guest state ID
>   * @gsb: guest state buffer
>   * @gsm: guest state message
>   * @iden: guest state identity
> 
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> -- 
> 2.39.5 (Apple Git-154)
> 
> 


Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

