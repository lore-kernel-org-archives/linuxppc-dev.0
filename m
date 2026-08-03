Return-Path: <linuxppc-dev+bounces-25247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80627C55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:59:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vX1CB7z30DK;
	Mon, 03 Aug 2026 16:58:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740296;
	cv=none; b=dfxehjEZtuDrH3UYk+FoGcu8yhe0pBGh/3JBYWeejS5f1bSMaYbDMc74mP1dVvdgxGBnvZkdQQVQT20XLo7xF1FGrziomldUROc5mfdSE0j/PVH4OT9IZzadAdz6yBhJRwBbhuarvmP5oXGWq28PszUuKWSpbLNJqhc/MzWjZNeR+SzMve9ATASl0NytDUdWRZ3McZghvg2UpQPydkgZk6FeQtxi4e3W0e9etcYQFEJHThfvVjjmxHt2S/UJ4Jwkr3Ey6D3UG9nEXKx92BVnnX8jO13UwX2R/RG84KsWOYDxHgYn8JZ+TBAyh1J75xuRjtHSymlZjswjTSZWyzGNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740296; c=relaxed/relaxed;
	bh=HjbAb2VAUA9gyD+6i7VbbQtHPEip7aTqwNf8AjzjuWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktKUuTdc/ZREJjPv4acAISc7hnO+wdBl50eEt5RVpm5N7Shozobp/5ugRfWSieOMIqcBMxmkn/BF8ihzO02upErnJgWO91V27MJxmLLFBohz94JoH2kCuuWRTyCzW94vLMiL5m8xiH5MjjGk79pf2BRI8+SbARVFZFN9LufZ4Z3Ptu6/Zeahaf03kjYuOQ2xq0eL558vIShpXNimWwn0VLYit65Dfg30f7RlMaq4R+hR+/arCc/QWTQ6bRvgqBluii3Q+/RDnKzALeZ6SW+JKVj/2KZvpOqpwiWJg8YtzuBvG1EaCgCPiIi55UgLi+r1T2aPOzwxCjlOwZZAOPVZpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YsaKykVJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YsaKykVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vW2zdTz309r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:15 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmB2j2565422;
	Mon, 3 Aug 2026 06:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HjbAb2
	VAUA9gyD+6i7VbbQtHPEip7aTqwNf8AjzjuWw=; b=YsaKykVJS6oUW4dEWOchgR
	BS6uoOl1DxbhK8g3j0dtT2W/+LtVsjViTIJgYWGVTwqym7P5Sb1WKQduqZD5nsEy
	USDw/Khp935HxvQWGKnJI2KgH+/ChatS3TPNINLGeoGb2F7twreaDgzARIRaJMB/
	81xSiSwXMOx3dooEcrTudhdeCM1S9nCWo3By6lgQdgGPnADVjv+V0NtkhXnczWcI
	N5AenLrhcEiFBnXFAD+wnQVp3BzwOEV8d6PQWdRgfUgq1jnE7msDx0fivhBVKZqO
	RobfTS/xbey2f+YueaMDtlWUSC9TaT8fppMEGRr91lqntiHgq57fXhszruGNZJZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqf8pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uPXG026483;
	Mon, 3 Aug 2026 06:58:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvv7g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vwJm39125426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDC5D20040;
	Mon,  3 Aug 2026 06:57:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3C6B2004B;
	Mon,  3 Aug 2026 06:57:56 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/rtasd: Use struct_size() to simplify log_rtas_len()
Date: Mon,  3 Aug 2026 12:27:55 +0530
Message-ID: <178574013462.29744.6823090165902962267.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260627104730.276858-3-thorsten.blum@linux.dev>
References: <20260627104730.276858-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: nSApYz5TntwDKIWQKBMX_Vy9MTYZDV_y
X-Proofpoint-ORIG-GUID: mL5TbTJGkXieQWe1Hb2_35-exN70P4Jh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX7MAWk0rpgN4u
 I0lPQiNBkWYfoVui4FnS3dbBlnfDdZ2wTAfe7Vupwlk5Jxv4fZy0iRo+iXlDLcR5fJ0ZzxX2u1i
 7FA6Eso5AZxQeTyJNAtC4ci0FZFJYMY=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a703bfc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=DTEs7wphgVcR27ZWF2AA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX934Re+BKzSTK
 CJPJu3EJqG9zPngxWtsONk86qSaXP5VcyE/wFoQo3CEj9VY6HEt2QdTpnDPfyqsYiBYXmId6fCh
 S/ElxVYY60zZcWN5huc28j84kGa/HcPZfc+ULrBNjqxh8zZdgJBgqmIxr6jgzjnarkerzc0FYAw
 xZKqNvW+mNtgoLYwNgFhwQY5b0IaCDXAYZOwc4G7A1akTFlU2QTifYWdWJe915fZAJCXI/Kladf
 JG6wi6Y8i+e+Jhf/QOywN544JE2ICRRUVhoMCR6Ghxdv3hx5SBIa4dHTbNrnpAUv10UmN1valoZ
 XKC0Yo81zttoAjKOXGoR3lYctIJI6FQg468s/LdeDs03af5nj1B5w2u4PjyG4PTbN8Y2vzneihD
 EXIRmvcsict8EUpLYoOVr/p8cofDIds/CbbZ6usIBlPTUbndDL40o8q2Pgqfhz9oc47oKeotCX9
 YVgoIRFPoNIkR1ZeDbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Sat, 27 Jun 2026 12:47:30 +0200, Thorsten Blum wrote:
> Now that struct rtas_error_log uses a flexible array member for the
> extended log buffer, use struct_size() to calculate the total RTAS error
> log size and avoid using the hard-coded header size of 8 bytes.
> 
> Use min() to replace the open-coded implementation while at it.
> 
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/rtasd: Use struct_size() to simplify log_rtas_len()
      https://git.kernel.org/powerpc/c/6a7f74525a9964ef3228f6e1d1af261e92964987
[2/2] powerpc/pseries/ras: Use struct_size() to simplify fwnmi_get_errinfo()
      https://git.kernel.org/powerpc/c/351496d6aea664f25cbd6411bf5567210328e419

cheers

