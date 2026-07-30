Return-Path: <linuxppc-dev+bounces-25051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F811C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:41:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dP835zSz2xnp;
	Thu, 30 Jul 2026 15:41:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390108;
	cv=none; b=dsLY/3ZBaAFCQs2hQfYN1gWowdsjft88J0r6Ul7jMfXqBa4P6caOZ9TMB5oEp5FJN1eeIzw6tUL6slzLiSbPxctamfKage6qLkNFRUF3r3M2dFX7Wps5KaqcGRZ+RVeJauYOZ2BQDAMDWGCGUSuIjP/AbDS0R8j+hZDjj1jmqtN5WLJIBy3adhApYOrWlC+tWLonSNd6cNCU+cilG34C/bnCWyjT8PlBsOBPNlODVqFiUp+c3IkytCZfmYBzwckgIKaDvtkC5PC97lQfXGMbBWD4+WykqQM4h8HQCAqGptf/RpGcTUUJWwqPeODLqx3n9q0tQCRu/8ImXDICAqwLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390108; c=relaxed/relaxed;
	bh=3vRBXPlejyCXAECNRrdxMNDBhH1fDZl3lsTNI2I8Hvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfDxa1Tw3IMvzp+8lanyeiH8gx5X7aCr2ykahFWuEkHvdbLd1Ox7qD1Is2xGUsqe4jfaZdnxHNMuBQJm/KX1/vOuLE6USutwpQPbBKJWUzShGseBZKLsLpPfiv0WF1XqtvVRijahz3OfUcYycYYdvWflEGOA1xdzMGCOEEi9f14QGc08ZmZlGWDd8XJTkSFSX5AZ6+7Wi6azUVkl7pL7yCELI6oJEhasc2tHvsM0cUN08nihOq1w/zI0ti/z/cKnZRCY8XU0zQsRX/wahGAVYi8LzmkyMsmV0MosWWtjOl/XhF2/5wcmhiBTi9/T6Ue022LiTHxpvoLlYK2GiC7Gkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gPKi1TcD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gPKi1TcD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dP74N4Rz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:41:47 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mG3O1949370;
	Thu, 30 Jul 2026 05:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3vRBXP
	lejyCXAECNRrdxMNDBhH1fDZl3lsTNI2I8Hvg=; b=gPKi1TcD6rGuBaj3cSJ1Ih
	I3gTmmq7LEyIoZ77Jx9hVl0eMPLZWQYGkD9ftFsuiXQtaFySj7qM4KoEbT5ySkbI
	VyAmvirt9/1XLbEmYi9nBxcWYp/z1uDdKVD2BFJxUbTokXcholGAfB5tzPE2qlDr
	HZyLGR+Ff8elOK2Xt6o9eOYe2AvgF2CG9IiHOXgNnQX8ycOqKbYQP1ddafZtKX55
	v8BB0YrEYw3j4Kbutj8+UQjMXF0Lnt2Lov0mweKeo1hxWecGac/QO4tqjLZD9J6y
	9yjRDFxZgu/dGOE4L1umWNRaOlsNagpAa/JWYq+D4xE7iZVHWLVG2SJRlAzS1Jcw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd5bqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fKWj027087;
	Thu, 30 Jul 2026 05:41:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqj44d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fRAe32113126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F63A20043;
	Thu, 30 Jul 2026 05:41:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75B7520040;
	Thu, 30 Jul 2026 05:41:26 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:26 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: Demote myself to reviewer
Date: Thu, 30 Jul 2026 11:11:25 +0530
Message-ID: <178538948396.1278583.16721905464729066250.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87y0hspx0u.fsf@mpe.ellerman.id.au>
References: <87y0hspx0u.fsf@mpe.ellerman.id.au>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HaJzgcEi9PGtJPbH4tada7Oy9OFXz6mI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX/3rJx32GJdov
 qetS/qwP1aJURFJUxPdrE0CUlfbsr5V7JdIWVR2UodaMRSQLyJLoRF0wfkd2d8Bwz0y9NMwDufS
 hjsA/89l2shbrgA2vo/Wsx5HmBhLfTs=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ae40a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=EE6SiEu8Ke_ANezpR44A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXyoPJzLqG2Euh
 My5XiemktDw3GvkNjATSIVv+W1/fNkVo/AEeHGO5fdG08hqr99FFnZP0WPW3tLjceynlbVhfGNc
 vj7AKPcuus91kG/0z5YRzZEAga/Krxe8GAgFexkwXft3/6voBJn9ILB4RAv0/v6MAffEElP6quk
 lDEwA7EoMZ5dy+IYaNJW7hywx7cYPTkUaCVDsbp8TnlK+5FGnZZhX9N6az1lpfEgtRUnjxel+Y3
 dHwq2ZEuPtQ3xL9h9syhWqxIEZx9elAkqqRW97nR5p3jStTjG/rrRO7NWxDEzsYElyS/HbS4XU7
 KkfxSp/2HHoeusMqh/WkkhDsuxq93nhFwO1pgIvdADOgLBZKg9OFxFbBYvACsYevDrlImrhbn4C
 Bw1oGaBDmzHxe221RB1J1zluTVpyLcgLiLHgXGI0m+T5Q0anl/Z0P7nNPhYnrIPIsTrXJRGzxk+
 L6ZAsbVU5ZuCJUpVhtg==
X-Proofpoint-GUID: HaJzgcEi9PGtJPbH4tada7Oy9OFXz6mI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Sat, 09 May 2026 22:50:25 +1000, Michael Ellerman wrote:
> I haven't been active enough lately to warrant an M: maintainer entry,
> demote me to reviewer.
> 
> 

Applied to powerpc/fixes.

[1/1] MAINTAINERS: Demote myself to reviewer
      https://git.kernel.org/powerpc/c/5732bd17feb9ddf843591c4d038eb6de1f8daf4c

cheers

