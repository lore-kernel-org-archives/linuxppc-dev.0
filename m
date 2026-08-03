Return-Path: <linuxppc-dev+bounces-25229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF842C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 05:36:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD5590GFdz3090;
	Mon, 03 Aug 2026 15:36:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785735388;
	cv=none; b=NjJCdmqzeIX4JGV8KxvcIG1ifv/plVGYBFCzEsdLGNkviJ3CHlLwsg0GviU+wHTcQm85Eqz4ufOMfdDJxrHpZxTkZDG0hFBN3w8BHxGwQi5gU7tKj0qJbsdtsGftc5Pvf1iKjb0R6lzVScwpJEQso31YNkmvvGS1aGZWiYt55mahGGyztJH+zwmgeX+pEX7DMAG2sXmZZ15Kc43OCLC+OEXfV3ybYgcoUeVfABf8L7ooxPU54VZt8E4XG9/tHJ72yFBETBJEdV7VplDyi+/Jyv20xGtlEuq1PDM4MZEj7TlRNxrr+CtKAcLG+NbR4SmAqovLLH+v0k1i6jnRJGOxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785735388; c=relaxed/relaxed;
	bh=qFNR9RxlOv+un8sX4NcMlwheYnxVOUt99Gsx96ZU2DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lkBNafNhW/qr6AO4X6N0h+gxpnWpveKRxhQKcoLTUlfZEDCiiC/N81nxhs22aZdttHpbDVN9w8XGRZ+BqC3dsxbehwicAG3I3K2mmZxk1aOsbOn7wH2P2u2SXUPwAKQDcljZQBB+YqESS5PxQYpVajJ2wHvcgH73/bbdu8RJ5UMJC6kBFhaGxu93bodPckbJjDQ8CWN4gia7UXGHVfhj6PTPjXvqR8aZOVG/p5QbU6EhBO+T7CnGlRRefEtuXx/U58OdXVyPvbYs3WV2opnM7OcMWgQeUsm5GUaI991+6FyUKWQtTE9lghTZyKStEgWqHf5jde5n44zmju5n8a0X7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I85Vgx6G; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I85Vgx6G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD55828mFz3078
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:36:27 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llbl1222899
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 05:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qFNR9R
	xlOv+un8sX4NcMlwheYnxVOUt99Gsx96ZU2DM=; b=I85Vgx6G23z59dO4Kb1tsq
	ZXblwTAttxU+gIRrLZ5nCmPC7u7acUIlH97++ctFS0NFhnOKRLWUGXe/zswCgL5e
	FEVjpEEUiXfgOqM6ofxa2MutdxkwAVTHH71h6BShvvlKooZjrk7jO25RtwZPcfaR
	74oshYRy+fm2Aa51WcFaL5unGTXZqs9qol+3lxxyWJF9JWTMYMovwFIcS9RJL2+R
	7Tx/ogyw/nujTFW44IzZv8pfUlMrtl7Rl9FOZrP1ZN8iK1XUFpvVAu6Lhc1i0qOc
	+8usIAyOfffn/XcNiVkYKIFRDgfQs7l5/5E3IYJ6jGRti8hDA8TJxjDxe0erqnSg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3q1nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 05:36:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6735QDL1013536
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 05:36:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qc29p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 05:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6735aMFx11272474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 05:36:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BF5720043
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 05:36:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1749C20040
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 05:36:22 +0000 (GMT)
Received: from [9.123.10.251] (unknown [9.123.10.251])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 05:36:21 +0000 (GMT)
Message-ID: <aba0e4a7-9364-40cc-a2b1-d03fbe5b51db@linux.ibm.com>
Date: Mon, 3 Aug 2026 11:06:21 +0530
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
Subject: Re: [PATCH 3/4] powerpc: Add Power12 architected mode
To: linuxppc-dev@lists.ozlabs.org
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-4-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260729145405.3230272-4-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7028d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=4kYI1AjpnHaMy7DTfVAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x1QrVgw_y5_bHyOPB9fbrlXhGqoTVLw6
X-Proofpoint-GUID: x1QrVgw_y5_bHyOPB9fbrlXhGqoTVLw6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA0NCBTYWx0ZWRfX2XZ97CJ3L51P
 UhxeI/C0V8lcrzs1K975KEulYOmDC77UHOJKbP45aUquD+kS0sucoXY6nZpOv/tkf62bZLhYicP
 CASSkHhOuhaQYRNkqKP7LJXfRfoBBzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA0NCBTYWx0ZWRfX94UTyrw6qwv4
 NVlRSwY7ScIs5vcqT5fR9LwVaQzVrTjyi3ThI4Ye7IDlbF9eipNmnA1ZExLR1qrHMm6nrAHnER7
 Tk/2XB5jxety4MpcqeQ0LPHiAvWZ9XdZsXPEHjSL7o2Gcps75ZW2Do8ADcXZdypDlsVOrl3YupE
 C9kGMoDxnZNaIhItmtoXSkSJlRa9A2MICbUG+IwyInixxVxbyz7tPEtV0Th4P9y2nA9xYf56Q+k
 vElQf7+ZnZQ9Nznb6R4h6SIKa8L7Zo3ZQ9t++N9+vffP1jLGQCkEDTptc/l7qK9vaCl9jANc37m
 XDSor4CfoDYnSFNbfLWhPPXUxljHIIsCTvR3SKmqv0im9IRCPgrSgF77065+8qtKG4Sn0GH8S0W
 mv6imagLZs0033bAK5BPxLEOVIo/jaxOJz4LWtndCsYmqyoeXsQaECzu4rgOIDYN9HzAfYBDGv6
 D7Xc51JNCFSmhKFD8bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030044



On 29/07/26 20:24, Mahesh Salgaonkar wrote:

> +#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */

Hi Ritesh and Mahesh,

PPC_FEATURE2_DMF is added to the uapi header but never set anywhere in
this series. Would it be better to drop the #define here and add it in
the series that actually enables Dense Math Facility?

Thanks,

~ Nikhil

