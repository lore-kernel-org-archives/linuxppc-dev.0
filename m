Return-Path: <linuxppc-dev+bounces-25052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15685C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPC2zzGz2ynh;
	Thu, 30 Jul 2026 15:41:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390111;
	cv=none; b=DxZvxVA7WMNOps9Yl35/hlx/q6nghkJ8naoD1PmEXLTNn/8aOPUae30M7G1KRW/E5kYjbz3ER9S1gz/sE6+dK2+HO4aszI734aesb+Ys6mvzmvYmORb4F6Glw/Y+aQSLKvKk+dGgjAQ05t+VA0gUSzBcB7sbmxhtVzB8lNUGMa5NcD73v491PHK2iVfozbFhFkQ1zyf8HK6Bwx+j0L7/N6vFSWPVpuwGZXJOVTgYq+d46WFc3xbvpnKJ3qPeTe4/i3yCBN6v66P2xZFehB+0tsJFat1FJ6Dg8kU5Bd5Ik+PraeFPuxoOVP2dD81JSh82FawJNlUlavwpNaTPIr+Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390111; c=relaxed/relaxed;
	bh=1YL4KUVKGQMVuLe2igNDGiQdd0jI9WqzHNpjU/8Zcoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGp/THf0gv2z4YxctEUiUBKcEQpUdILERcVW+Thkk9qcNhQUgTf81Elv7jQ9YhnUDmvE0DYeQMx4SAo9uLKFWUcpz3xYYir5ohUByP2aXvXj22vnM0s8wPJ6l+0PfN6u8AjEmzuNf+HGMYojXUYF2ZIc0NknhpMgorKU12W9k+cTdW4iS3X08Exj5BGWqhkeVoCLKcQ0x79VWSnpb72WOi3K33Wy6LPbvUr41G5f0Gy/1CkyFZE7vCn0PyesllDFL8pl1wcEqIeNlAy8Noq9ur+ou88RKtqfX4lFoUYc7omA2UaCKom/gy159gFAADz0CXUsHDIGfz75xbwP1H7rBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P/UnUO6T; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P/UnUO6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPB5Ygzz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:41:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lfHJ1824239;
	Thu, 30 Jul 2026 05:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1YL4KU
	VKGQMVuLe2igNDGiQdd0jI9WqzHNpjU/8Zcoo=; b=P/UnUO6TRR0Ok/Zz3gyThi
	UL2xfOlIIEbTwLJeCkyMYQSuzq0j0d7/mdJDnRb9U8ua0KgIbHAPIOo9ZpVV3K8h
	R71l/LQsuH0nxHb4ica4AbC8oHQHQcJn86o3tIIZ5fgJkOa/BC3WkDkWXW3neLLP
	Nj5qazrsmFv4ciHko+pPJRfI5ARuS23Ym88hJG5WhHhvN7CEEY0EvwnTcDWi2hlM
	/GRBuTVoDCHtRGyIUPZgeVpkyWuGdaYgw1UmzNpDlDG5aJdoxImCk+9kzJRlaBRs
	TMWyT4Y5Ph1TD4124Z0nZRcPfvktTFVPa94K2iJ1KXY78i6PP/nd7MZtu/uE4Vgg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjdb47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fPhi024164;
	Thu, 30 Jul 2026 05:41:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwa24y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fWmK29098320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 266D520040;
	Thu, 30 Jul 2026 05:41:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116062004B;
	Thu, 30 Jul 2026 05:41:29 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:28 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Josh Boyer <jwboyer@linux.ibm.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Tony Breeds <tony@bakeyournoodle.com>,
        Alistair Popple <alistair@popple.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/boot: Fix simpleboot CPU node lookup check
Date: Thu, 30 Jul 2026 11:11:27 +0530
Message-ID: <178538948393.1278583.1936601171257024633.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702211554.56923-4-thorsten.blum@linux.dev>
References: <20260702211554.56923-4-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX29cNfYYYvZTO
 NgpAyhHICvDD5OIRs/rojOro5xbf0gnf3fA0ZjyjJNHnpWf7GlQTLDm7j9JrcAXDgwYFMyq8fP+
 4azXobgcSE1MPujih691+7UpOb/7Z5s=
X-Proofpoint-GUID: mZcBROQE-EwNS1-Kv-lVf5ThEaJEpJeG
X-Proofpoint-ORIG-GUID: kkRDAMBCQ6Au6BxYYcmGRied62ky_Kin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX8DtUq5qeqVdk
 1J0Btx0LK+wAmI/3Zhrj9a9hu4PNj6MMy5PaDhysFEO2OrtRuWG+iYmACOEjIbMf37S3PmAv3Cj
 e9ePFIRuIn1B/qKbpYjXUxCX9lrsUS5K03COPZXexEk7SdrVJWcu9m23/VQnhHHZHuSI7KVjit7
 VS7IV6FO8dqx+aAnwBaCz5pL756nLI+B8IcaKx8RISw1cnmhtlqFOzjYI2dwyo9b+rW1jHS642D
 AFwEB9MpcV4ye+/H1xoB+pYZO3iw/X8PIqhCo1m0sAzEhkUudDwJJ0Unnl3JwKnuvIVIjM52N8D
 lrDghnl48tYWuUPHur1+birfZJNFV0gY0edQ8Vj207iwCAoJjsldt7wiEHGw/Gf2G9tIwBnsrxn
 iZ5qbL5J1FDR1oMo6Pt+HQ4K/GTXI33FHxKzYLgooyiouKjR560DrA0ecidnvv30pKgLpDbWooh
 5PRu9I9+kNSVgq56Tkg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6ae40f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VJuR2jBAgisTMyMiAMwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300033

On Thu, 02 Jul 2026 23:15:55 +0200, Thorsten Blum wrote:
> fdt_node_offset_by_prop_value() returns a negative error code on
> failure - fix the check accordingly.
> 
> 

Applied to powerpc/fixes.

[1/3] powerpc/boot: Fix simpleboot CPU node lookup check
      https://git.kernel.org/powerpc/c/c824ab65685bb119c6c6a3a200b3428c72862d5a
[2/3] powerpc/boot: Fix treeboot-currituck CPU node lookup check
      https://git.kernel.org/powerpc/c/43863f6575d2211e8c5157fefb83ad0ad046aab4
[3/3] powerpc/boot: Fix treeboot-akebono CPU node lookup check
      https://git.kernel.org/powerpc/c/b24fc8278b70a9d27ec801a427ab4de9b769d69a

cheers

