Return-Path: <linuxppc-dev+bounces-25245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED815C55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vQ4zxNz3c71;
	Mon, 03 Aug 2026 16:58:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740290;
	cv=none; b=n/IZCT/3yfHqNXO6GHXM6sTkybUFv1TV97JbiDvQzBtNi1phxAxZxgm4GlCxMw3UTQmdUm5f6l7zP/ZeTAdcdMwrhVvABE+IrGnh+95j3r2JNtcddawS6vRf+cXxKmhjyPPXKnxHqXOGTEMNB96R1YQz4KUndYsR25K0jrfLdLpFNMGjJXOARZEtvAoJBAyMkZSeW55VbrXV7nnR9l75jxerWxfYLoWJghSBlUK5n5n4shAcPJY1pSd7tM3IqFQc3vvs/EO5bedTjdC4ziRCSnhbpaIfd8oTRVTCqP4b2DKD7Fh910UcBbEBDaSpXVrpe4muEk4GSBXndfVn9IZRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740290; c=relaxed/relaxed;
	bh=qWWFbZrNOkmJKMA647Kqn4RSRJouKtqTc0oaDg4w2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKbZgeV4HdPGB6W056CmRMEqm9h1+YBLcfmTPY2yjHj7EZ0IkLA98RwxlgEtPmrFtPZcAKrqQ3Bp1DQCj8aCun5+qenecwbNVpGvH5MR1HNNw/VbXngnqeuHbhuFYNICVw3+hwdYLXW/Mng+nUd2YOClnJQXg1GEzM2YVSWKVkGFt/0+jdSdPuQZa8debfnL3Py3gdP1TikKHwr4LtFsm/RqJdMzTObO78cslgjqa+mDLwBUNKHYq6Qp4+HvLuBYU/iq3ipeGUWOkxPrdOCpK6wb7q+FHvykM0l0CPhCA2l+oNaFO01pbyy/qsHooYtCud8xkbLwmu0DWXzkeehUSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gaHuVNZq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gaHuVNZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vP6WK3z3c5h
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:09 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llg0B2564036;
	Mon, 3 Aug 2026 06:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qWWFbZ
	rNOkmJKMA647Kqn4RSRJouKtqTc0oaDg4w2Q4=; b=gaHuVNZqoRGiKD2A3tlXmB
	IQlJoYDmbm0x2G8Ki7SUjy+v191kTLi1dR+rdD4s6sBUhHvCdn6/ZMq02uewO5l8
	qva4KZ/g2TMf0t+5WAIL2eBIcZ0a8dCNfVXzTrn0Itg+qhDdGMQRHFla3FXf6gGw
	tD2NAcHcDGTnmJtorhOj04uPIhoDxOsfSN3i/aHMwlg9AYsSQ6k9KDFCZPZNTAvJ
	erfWTckRP0K1PLpCIeXba+c8yzMEvQnvE+o0z9kaa5ALh4oVuECjkpgpYZGsK6GC
	FgH3XVQ9f09pRPlm5YWPMmpbKfe8+HFL9kBQkKwYrL7FVSZprotESJSPw+O8OEGw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqf8pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uELS018629;
	Mon, 3 Aug 2026 06:57:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybvvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vtaA30933268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4DEA2004B;
	Mon,  3 Aug 2026 06:57:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3143020043;
	Mon,  3 Aug 2026 06:57:54 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:53 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/serial: Use generic BASE_BAUD in asm/serial.h
Date: Mon,  3 Aug 2026 12:27:53 +0530
Message-ID: <178574013465.29744.9181727021200775074.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729223807.570178-3-thorsten.blum@linux.dev>
References: <20260729223807.570178-3-thorsten.blum@linux.dev>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4uO38j6mxXsrceOqQpA9KxI_d7yH4wlS
X-Proofpoint-ORIG-GUID: OyWTLKmzHQhPJoXAC3Q8TxUdKtaM8Y5_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX4vu7IaETGASe
 SrFWmexZ9R1XLSpPh1etVnHIaT2Pb1Y3pLaMGBTnWG86K5x2dGNbaXkJKbE3nvOh9jrEfYFbqPt
 N81Q0Bwh/Msa4DooG+34tTUo5fMY7Ao=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a703bf6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=hDjUMhd9jn0cCc7EubsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX/S4X5v9kSvQu
 aWuk1GkQHSfeWgkpqJ5xbgufGtG8Nvf0iojUKbqVuFsHgONDB7/RxY8fIHp+IvPkeXqtS3kENyJ
 P6lX3lEyGdEM7pggArb1xPQs7pGTbPW9kRBk7DZMNoPVinG5dIeuchiVUwAszRPV5EaFen+7Pes
 xVPfmcoA1Yoh8tcUC4znZ7tkNp3E2M72eXvqUX7FSGslQcKimtrRl4lN9Rv2Uvz7/WyLXK1IkjV
 3ZEoAOghdBzQRanQun2tR539ipYJ3tykOZLRdoM6eNPVshm2aa6+vobW4wDXz4avrzpsGAxNxRT
 XWbTXfIBlLfI+VPg6nxlScIUR1BnQBJ01Afd8yxMGKEnBCN9iPzPpaNEEHspVMqZJQyzOij0gCE
 LGJnX1jKVPF0IYI3zJpBXtwbaTDPPa9GVPRLeCU+jCV+ySkMO1dOc2AAwrKezWanuVXn80IRfBM
 pn4p9H8wijv6V8thLOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Thu, 30 Jul 2026 00:38:07 +0200, Thorsten Blum wrote:
> Include asm-generic/serial.h and use the generic BASE_BAUD definition
> instead of redefining it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/serial: Use generic BASE_BAUD in asm/serial.h
      https://git.kernel.org/powerpc/c/be57ed769406eb2cafd3b98f83ffebd5f703940f

cheers

