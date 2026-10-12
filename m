Return-Path: <linuxppc-dev+bounces-29237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAC1CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:50:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3B4z37ZHz2yYY;
	Mon, 12 Oct 2026 19:50:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791795043;
	cv=none; b=Q8edVRKMEMN7KD+edU4dDq26vgkyXeCngu3bg8sRFqgFbkHMhM0T8SmuJcb0ou7tQIxl1SFGmkCMPLCnnEJygkN/kI5sVphcgyLgLfV/Xp2rul+a/dl5Rh98++NqeUeD1Qp/9ntPQVU3TpdY0qzICc22trCSTj6dcfo58kqnuaJoV0j+m9Z2ZzAomnAibQyNTrmAiAJWIw8xmF4YdwdXgmF4UYmriIi2q/Dj6KHhuyaDtSZvjjGx2ewG1la1+5meppnHhprX2CEs6WWBEoDlM5UUzkItrpPk1YlxoIr1j20tuHO4eZK94CK3FdZutbQVPX/63WPfI+TpJbpLTRbmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791795043; c=relaxed/relaxed;
	bh=BiWfORhl14Y2kc2Yj7jd3L+ojV0uPdptlcen5uHcHjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayT8wXoMQHyZSVjnARG/Ax5L6bks+TwHneVQ9nFkJyag0NhdlSUpiRGW6l8+xBUk6vPNT4xvo7P62x7zRdvpYtVopOs2ARRYWwdoX+LG9HeyJQTHw/eFmQOUkFiyQc+43Zz0pDUB2LLaxcSB5vLadBxNv4Or4CuoblEOC5biL/d2ZSNC11bhUD4G94FQknS1pctsb7U/BePONSxjrWClBD9BC/iEc4xGUBrRWX8NKxj7cLoC1ueM+7v7cMRPxbqsaE28OAgkn4+1wtZHrd5+aAn6zHxxIpFtHCVXVsFiJlyrTMBDeim4blS8cFTzN/q9vWgge+ARD2xS+1yu8PYPjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cpdo3P5F; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cpdo3P5F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3B4y3jSMz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 19:50:42 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iQRe4053600;
	Mon, 12 Oct 2026 08:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BiWfORhl14Y2kc2Yj7jd3L+ojV0uPd
	ptlcen5uHcHjo=; b=cpdo3P5FbPN7vIJppiN5mRYuP8ZcwUvpn3fivzVOs0AJLL
	3OuNo6ztWeMWRpH3SAOw7MxELnNIoUHupffXRQmxpjWaZGzzBB3m8DqPSujVS4dh
	fQkLkEDdgao9LbkQGunPfqBFC33B4YAETVCAUnntwBPgV58Udx2EyeimlGxieWPI
	DE90VcgE3mflQBhWJBixA30/THtpBJFYeAhqKSvuqPtZR+mF+LUdSPtjcO4rnSrV
	3QOwBWbPirzifxkYjAtldk7FfvbdVIw0IOkwGjs8iUwVoul30Lhu9coexm0AKO3r
	lyDDBfyfo0HrR6i6dkI1bKIE48VykzEhPPhihZOQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug80tx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:50:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8Jxwr964540;
	Mon, 12 Oct 2026 08:50:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppmj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:50:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8oS5U42271188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:50:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D79022004B;
	Mon, 12 Oct 2026 08:50:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB46B20040;
	Mon, 12 Oct 2026 08:50:26 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 08:50:26 +0000 (GMT)
Date: Mon, 12 Oct 2026 14:20:23 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/configs: Add debug configs for debugging
Message-ID: <asyep4EEG-lNR72Z@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260827121309.94434-1-gautam@linux.ibm.com>
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
In-Reply-To: <20260827121309.94434-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc9f59 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IJYSnQM5NmKPltgcYjgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zxRbLfwKOAkQ6L-WkQ334uuldg0AC3tT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX+7A8nYdbXtTK
 9HPc+8FntGbdM23TDe91xjxoRgMpKCdi9rvq99wcDco9xEk5zw1Fjl+D723ZHHzh2pRYAxrWEij
 aaMeBIj2GF/YDw55xjRbm0SQHAuBwxQ087fz26MEALiHrHg2MdfDHLLFAZPKc2ikkc9fPvKE0a/
 RtJdpK1rdtHA5+61yr5CRWXI0pXoaZrcrohSRC+Gm4OwZzGo5iC2U1XZp9Z9k19xjLfMabo2qip
 /muKc91xasTCDqWTCdvT/ta6VsG4DJC+J+8hoem56bTJXA9NbnJRtZghmFW24ucV0YIkNduqbRu
 v9cls0XIpnAy1ZoU4nLGuKuog+IwWMXM2nW8XuCHfuT4ndjSg5IMafc0bd/ZRlcEjniW25MxxyT
 lduwFR6Lcl9FS+4b86FWFuA9iNE3pkjbQ6la4JNeaSfW/h30FDWhE90Z138unMVZ6dJjsvx7GEG
 8cFUMkMV3L1FUmMHd+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX3y8RLIVeRzzo
 YGEwIyGulW2tIzjx6vwKPEVi3XtHyQfV9n5PEOknuQG6fNhxBW3C7vjwKTC6m0KBlSXC2tgBDy+
 6bzEu8GSOYa1fSwl5/ebh2am1dO/wfU=
X-Proofpoint-ORIG-GUID: TFBK63VZaVlyVjvdV8XDPWzN1hYeF049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120034

Hi,

Can this patch be pulled in? Or is something else needed here?

Thanks,
Gautam

