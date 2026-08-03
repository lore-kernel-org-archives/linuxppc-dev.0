Return-Path: <linuxppc-dev+bounces-25238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F0BC55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6v51YvKz2yfD;
	Mon, 03 Aug 2026 16:57:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740273;
	cv=none; b=bV8L3VXKYJpo2E6ew8yZ0KbPfZJJB3F5sYhqW1ut3QtkG/60cR4dgUOoNJeXnbVvtNoGJkq1nwbEw8qrihz9vRFu+mDQDwocE5fvws8dHzlN2e0jLFpZj9R4R7Cbo0E4Vq0HLiVrWjvc+TWYpt0RfHcRsCZgjOtFZ2dio6yIqlXu2IryqB1Q36aci9nBheCh7dEPDN+H9sQr2XQt+jgJgPD2//AI9xHrK7d9713SPJm0OEPAKS7gqVo/1EyJ5wQOee7gl+tGzYk82IbNMtlK/O77M10QPzp1AMkeJEXq16lhYechURn70crMP59mZYp3ppnhyCVz2nvN5sLK9A1+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740273; c=relaxed/relaxed;
	bh=JzbP0VUujxT/EMoGlzVNrARJmJlTWqqAFMVF+eZpDcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmYDTvkJ3feFqc9R9GkDgNcd4hOsDIUVZB4REdOXdUsjlL6hdiEjsWGxt+XQDJinL9gwul/1QaDZukVkrwO4AV2z32gVNR9NyXdlz62GhSiQdpyksVvonuOBkoQxpElrv92TX1fZ+XGCxe8S7h4lPwifJ+cRXYB59rE+T/16Zqx8/56WUz2bwBP9vqWIKHQX2h2Thgdr2Atz+me2kE7dp1l6vRuTaYSlaPdCo6nDcR7zNiJSHUpihhH9T/geA/1dIzwin30KrjktS+1gLh+MhKXkRNlaEjCUHxcVqja3mg+bwOVAn1jZjpBusR7nsLeHTHKStBgjSNW4rDfkMOAgRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m5fR5HoQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m5fR5HoQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6v44FgHz3brP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:52 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmmFZ2566526;
	Mon, 3 Aug 2026 06:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JzbP0V
	UujxT/EMoGlzVNrARJmJlTWqqAFMVF+eZpDcQ=; b=m5fR5HoQIvCpErYylvjYaC
	33jYdjEQmseCQcRksjxGvt1nqXJhALN7wsa8Wlxk031vHlWAj5q4Lwo0Eo5HM+um
	rR+PDGPA+1DFOnsrOeukYgVD70Lmo9ZAeN6M5Yv/u3jYg10Tcpo1oJBZiMUbEwbI
	vDP+XdcjYlMxRQekOQWcQRHT/0vXYlhIhYdi+jD696Nie6+6Bqpw/omXuzToU24q
	bIG0EPUlDQb80DnpN/r7crB5t4CouH61diCBBqeo4gE3mPEpPxxlmzfSXsFRpwdF
	WSMvHGazIh80zcnQOBXBbQUX2T/gptMFtOCFOMErdSVMr0aYVjTYxHGphB0Jojrw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqf8n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uEk0018855;
	Mon, 3 Aug 2026 06:57:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qc9k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vcvS48955676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF9820049;
	Mon,  3 Aug 2026 06:57:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A843C2004B;
	Mon,  3 Aug 2026 06:57:36 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Remove unused sprintf()
Date: Mon,  3 Aug 2026 12:27:35 +0530
Message-ID: <178574013465.29744.7029961908335227821.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724172200.208722-2-thorsten.blum@linux.dev>
References: <20260724172200.208722-2-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: 55_2fpg9_5MMux7DzNrkW42ulrUGS3XK
X-Proofpoint-ORIG-GUID: AQycOIg6w40AmagJEX1n7VWyMRyZ9JPW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX/IqdBfUTQ8Uq
 aG8lNEtYz5khSkWcV+UzAr0EQEOBQg50Il5w4kafkB0pqtNY6Ny/l4WL/pDWArLYKxMVB63MUSj
 PDlch4YTY6IpUO6LJ1SFSL0zJLN+nEM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a703be5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=zz1L_PSh02bSXPVVYnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX75dSXHMnb8AZ
 UQ5HkF8sVrehjCVcgXbmuqmdlMcNje8HmxIuGYoN9TzN2vnxorr5khOLcK4j7CNUVPVkjZlyNPF
 s9Z6sUbemRIoDxirUyB9+mp8GgAIBvGqANo/7+QJn5I82NcAXJHn5iGYaIGsgBz0oqGB/A1PyoG
 cHGmt8xNJMgYicDBwL6otv5NljDu4YTw2XNbXw8/cKRPjt1Uxv0hoSWTDgxTYL4CKgwvcWgbezi
 +Ms8x3TkKszsKUmz5d16uEC+CT/zPrzTPwQOYe5EhFYDYAlSGaX36SHJlHuu8Mgf3ZIMUHx6Wfg
 CjGZAYgVlTJXmgXVMjXMaKNiZNyRx4TZxPcWXOT08Rcngntuayc29ecnJg1rxY4znlQck/Qudek
 fTpwfFLK+ogjZ6asM0rhVMF5LAAPth7fNdduX7Oa9OiCf0k1pVR0YMHJIXG6wclD1l9v/Wr4PFv
 2QiHNvRbgc1gg60HHCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Fri, 24 Jul 2026 19:21:58 +0200, Thorsten Blum wrote:
> There have been no sprintf() callers in the boot wrapper since commit
> e275e023aa69 ("powerpc/44x: Warp patches for the new NDFC driver").
> 
> Remove the function definition and declaration.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/boot: Remove unused sprintf()
      https://git.kernel.org/powerpc/c/3b232a0cce4182851ee8f2788180c93e49d9ab96

cheers

