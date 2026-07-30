Return-Path: <linuxppc-dev+bounces-25059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFE7C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPZ5vqDz2yvX;
	Thu, 30 Jul 2026 15:42:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390130;
	cv=none; b=Fzwdj2pqPDP8CNeREkckYqDrl+JekJue7o609hVtrTBvBvliguHZ8l2gnwuBq8zNpmVzk7t7f28RyAPCX17WCnN3qSfgSKEcTqBfRV2sb0dmC+xlbybNUd5XOoPvt97AIfmUc3E4iEvbECTVU3Lf34+k4BcucaJNVF6G1ok3MOJXASRIOEJjJ2CK5+p6V+uaQ73NtebhoO+ZukrIsVK/5Qfih2nmVHT6DCOBTg3oQNCYa5SaBBJkdZXfNgVuHII3fmffvJSFFuPBY/fC53w1IDeLDCDFMRK2xf7TsCE7T+k9Ra9QktS7v/99aIzQgzcanr/dP+O1RhBlAAPKx0O79g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390130; c=relaxed/relaxed;
	bh=HbhgOVQEVe0cgNarFSPl+ZLL1Xc/lamN8WiPFz5gbuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzgS1GUnTpvDZcRFHdGa0B/R6CDanJTc1W3t2SYEGjMeEMjlMG+RIL/lDWrkdP/+AnpKLsIIftOqCoXoXNmrrR+WYJ1yKeNGJovfJvyI1ElCZANdJ6+WYqWgBdNIVg2AbbEA3EDqYRsSpLsptSKns00D+aJvmbeYKxMqIALA2/aJ12QYqUJZXnZ/zOaJ0ztKmkKkChGcXDZxUwunKWQjra0fK/RudQa4w3ccuLfaSi9VXUJzONv/H1cjoB1gpIn15xeyDsv2CZZTypkUFv2CtyzYPqFOeTDryJLP0tJmDgOWhdBscrcfEKakldp5hRyVRJwLhRyMVwcwrm5QDMUChg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qTkr/SbC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qTkr/SbC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPZ22pyz300B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:42:10 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3loRd1901503;
	Thu, 30 Jul 2026 05:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HbhgOV
	QEVe0cgNarFSPl+ZLL1Xc/lamN8WiPFz5gbuQ=; b=qTkr/SbCBD7RdqnBabTPcm
	Hymp7d+jEkL4ltGGFJ/UL+NrC9Xd6MIpfuPIHn+z6PtgK7b4xbE/bINxAARp4kw8
	wLxXPdH7xMVcxsSzwQW/R0u9ma+zOvSG0w5fri+wVjGqgO68wSNdN+wl4PTmKIOT
	2Z0TapweBYbtYv742EwfHxhWawh+Z4qWJWDbuwo3CT2ZCzgNEMdzJRl2EuZIT/cq
	s55hJoltUMLKlcpQ0f/C8R2ndbVnZCV9wmgNCTT7PkQT54KMF2i1gxXeL1NOHT5m
	PGRx20KTOng412bt4g7mJUyeN8cIFzBmbAb7sum3Ay5eC9re3u40LQq+3cjjhsEg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7p69a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fJe4021695;
	Thu, 30 Jul 2026 05:41:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y9nn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fnm09961744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581A120043;
	Thu, 30 Jul 2026 05:41:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C665020040;
	Thu, 30 Jul 2026 05:41:46 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:46 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/ps3: Remove unused struct table in setup_areas()
Date: Thu, 30 Jul 2026 11:11:45 +0530
Message-ID: <178538948394.1278583.16184702242239130361.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713091731.97212-3-thorsten.blum@linux.dev>
References: <20260713091731.97212-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: xJXRzNe9g0TQK7UJEEe5I7Ed2rXOXXZ3
X-Proofpoint-ORIG-GUID: 9RkOamU16jNXGnD10QayTm-gbW4N-tN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX7GJKLnT8NTDO
 Oz1l7C0Udp3XFonA0hNwlU0fhPDCb+dflko+UWX2hwKklrFsxQ2LRwNwekSE1buoGF9WupsIHrU
 TjD9ai4YbQZDsgJHuagoT5n4izsDXWSts8rVEr2bo9LYmnqToViUGvD8DL8VXgzmJ7E+nb7779J
 AGR673VACjIwD/73wBQq+DgBLd1Npi47+g+g2qpA3fmCNI7+jgFFK42baLH/9TygdVNOEmgrO98
 s6ktWbdQvOel7+weynQSjAvIo2It9fGJ6Jsz0V8nrG5R0swK0fWgWgMM/3wmjQZirVrDSAwRQ2K
 EQj9u4wrWV21BS86/0kLcVNEpDPlJqxij4gosEaacGO2oYIXLgPbPvSqHpUEIsjYj+/ccsf8q/n
 oWD+rhc2BbAzZlMyJqElIhrNbnZWKXH6KWcdKhB+0FLG5WiHwK9LlpVff1SDmE/MwhfwONlzPPG
 3q7T/BNhwZcFxwehhUw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6ae420 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=faeXrdeqNi3QC49T2NYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX6PU7Ge6GwAIs
 Xdw/ZtumPMp4oMnYNe2plwcSvz3es1MfYaE1YCY54qZyqUOkck2Why38ATCRNHQLskka3cDhI8v
 fmAW/NqnHscb5WA2hSp0I7Heq9iHVIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300033

On Mon, 13 Jul 2026 11:17:33 +0200, Thorsten Blum wrote:
> The local table structure is not used - remove it.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/ps3: Remove unused struct table in setup_areas()
      https://git.kernel.org/powerpc/c/41bf83c1b10781fcb992ff0680db771b7b833308

cheers

