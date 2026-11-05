Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E0606EE9D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hiIOyBnB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL58165Xwz2xyh;
	Fri, 06 Nov 2026 02:00:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793890801;
	cv=none; b=fLBqbd6BI/tB9aXj4G1DXmGE+oSgSvYK314NHrKHQhFCqtld6memXTISyi7fRU4M+r9WwJ7DVSGLrdMBoiojtNQbqwvzOYl5HYEjzsdjKo1tjw4L6IcsABOCIiLYpYB14xtpec45in4zBB3RCXGXalF5kdvz1GzgTOij+9G886iTp5TH/u5k99dE0lzVf/CnAD4YqcWKPnIklgqM9AOswLCdM1Vc1zgUDowrmk/6DjyAftcWhsVP2ayplKvG9HgONI9FX8xukbqxOr3B9sEZyuXMY7HMtlyB+lrajo+oCZbBcM1CxAODfTJgt55+FnUKOAmFVQ/OE2VtQCIEyZUoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793890801; c=relaxed/relaxed;
	bh=lFDPT0oaNH/zvfvIcUK9rsDJdNG9sPVoATFrcaQax9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZiCSxp7xiFFXJ5TheKhjVCq4RCssbI9vIa5PBaLw3oqvlyfUBfFZP+AJ+i7a2GWKQ7djc7c213SKUy3Shdqk6Lf7JA9vS2t8WAXW7zPwxPh8UsKWPVYhF5uYh3haVutWvcoSA2aV3ZhXhZLTzSJ7iXI9clkpr7uNQ+MQTlc3jisKegTK3cnbacAyvFrW1grRhTzpqDiemEJ1hBmZvP2LeEF1e1i8qyA55Rr/Y/tktRZPNBfDWN96pQI4OJ9gBJwmGrup0nb6+nIgBs91x3tOGKjJ2wZvXFs16vQA3lCam9T7oLJVK8KZDj9WtU0hGEaTCTu1RBlmmGI88Rmx3/8xYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hiIOyBnB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hiIOyBnB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL5804sjSz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 02:00:00 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiHD62627300;
	Thu, 5 Nov 2026 14:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lFDPT0oaNH/zvfvIcUK9rsDJdNG9sP
	VoATFrcaQax9Y=; b=hiIOyBnBG8zF5ri+rtwFsTlw+pu1uzZZ+Fv0V/TvlMKtmq
	WrP/GiIO+2G+VrDzSJB9UqQmlHxrg8viVK3ZDrQptyBYI86UqK217otEIDTF6M1u
	f+szl3PGHM92AZ/LKucBQgHtzs7W+wXfmTI7xqXDpJpa/sgiry0U32YD795Y2tfb
	6A3uP7UmTxqF78b83LWUICoRsGGnSi2IjW9zDJlcMQtQC1O0UMLYzg8fJdDS+cry
	MOcaJJh7j6MIxJUiG0nUL23iXBojQyWJQVgoETIENihJl5hya3s53z3hy/xMAITZ
	M0V+NjtDUfL5Fmgk2pblLCuYmxU+wg2Lc7M1M5kw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdjk2q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:59:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ0Bk1685738;
	Thu, 5 Nov 2026 14:59:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrej6um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:59:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Exk8a20120120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:59:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB6C58045;
	Thu,  5 Nov 2026 14:59:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A15758052;
	Thu,  5 Nov 2026 14:59:46 +0000 (GMT)
Received: from e (unknown [9.16.46.225])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 14:59:46 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: "Martin K. Petersen" <mkp@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Tyrel Datwyler
 <tyreld@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 00/13] scsi: ibmvfc: make ibmvfc support FPIN messages
In-Reply-To: <yq18q38ym3n.fsf@mail.kernel.org> (Martin K. Petersen's message
	of "Wed, 04 Nov 2026 22:52:46 -0500")
References: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
	<yq18q38ym3n.fsf@mail.kernel.org>
Date: Thu, 05 Nov 2026 08:59:45 -0600
Message-ID: <87qzgz8gta.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DyQQh8tTjtKJ30E5dPBoRwGquZwbbWwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX5DBV24jkie24
 Nb3RvCk1eYaqH2TTLjNn3FiG05Gy+Zb+m+X/Qv+8mwUY+CKTwBCSy7S7CnMLsX9NNWVGr13mGXj
 XHoptb0gFgCpOpYBQijZ1KOSveAEancSW37I4lkLdTbgEVmSjQKbiqNcoZ5lVGHVlTNv13wkubL
 mZ7+yJZF4VVMQ91WXmEiB7+oOqJQ816W5rzX5iGdaxOoHEb0wIXncFyNE7hI3yF0LgLlRqU+/hS
 wSVr33H8JL8yvRR2lktRDIuIk7jV7pTEiTlBaJgCSeGdgHT6TPhLdZeob5wO2iV5111KgdOJ3w6
 5nM7KZBtzDu3gM5N0tdqZjCWFOkb+Tl71gvSUKrKjenmCp1coc4SLy3h0BFWEctGqOkMm4cDNj0
 lg4Mr9yOzQsYpdlQ8fNN7S/40QI4UzeoBG3nAiadIaEH41kDfwOTex0Bc7FUBqILOu0RwKr4+FY
 NRIIRH/8Adt1YnYuhnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX5ZlK/mOpb3UI
 QlikIp9p+XTXfBV7UA3wqf69B3fKGsjSb3om1BqqLsSad4WfWh2sFinhlRAO5tLVObqq/V7sKiN
 HQezDdj+/ORJ/eHCplxzzZTJyBECQmg=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec99e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=kPyA1ZOQVYL41U-xMvUA:9
X-Proofpoint-ORIG-GUID: cegMXEoSwNwjXKYYnXaD69cVs0Zx-jPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050058
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Martin K. Petersen" <mkp@kernel.org> writes:

> Dave,
>
> A malformed patch 12 in this series meant Sashiko failed to apply it and
> therefore could not provide feedback.
>
> We are getting close. However, a manually triggered analysis identifies
> lingering issues in patches 6, 9, and 13.

Thanks! I'll take another look.

-Dave

