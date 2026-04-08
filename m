Return-Path: <linuxppc-dev+bounces-19470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD13FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97N0MLRz2yks;
	Wed, 08 Apr 2026 14:29:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622544;
	cv=none; b=JHcaazTcvGfCTS1/MmnpFy5yXxQkosjqKU+8BMjr2t9BpYjGyVGMxwewXEKJYFBHOx96Kfxb+eeR1DROH2LmRihFG4nrNiL9RkYUi5X6zLKRkLVrQN/yh4UMjU82mzwzhHzTJC1Bky65c+gS+MwXNt6KtXYE5fQxmlzudapa7yjXYH6OyUUaQo2tF7dzHYU0hfDJ5nm90mKyowYOh8Ygj3bEmdcYdfkSOGqhcqqGIsc+N50GgDzRO2tU6Ll+Mr3OsFoUBxrvi5RM144JVd5+22xUQYg5SrzxpvD7VVCd+WR0ED+u96hmvveMfnAkhrsOm1Q+tvaych+ayW09w7BZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622544; c=relaxed/relaxed;
	bh=C8vCeOts7WfkxEBK9VS6PksqNmFdWXiGUd7atou3BUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0xrm5aHUpk5c+CLFjO8zi12lcmIWkyF/555kTY8UKEJINgcnxdGZULFwWzrMOmZqbNc28PDW4XTnl2Kml48k6V/C4sSJeFct71y0mEIlGA35YzSQGc7rGOnhyifCET/wkxqBUypcC+Mr1sVpHzODQccIDOF2jsQxQxNiaDAYBGTIjdlymGak+FweNRpISKeoxRUmDxvf+47TGi6FIVN4PdmfRFxn0QIviEAcMCAxCkTX6KHxndP/ClqKi7NdwxOY/ZtbV/El6lnHJlfnBL3wFI7QOavPxH505lpooQKgo/u6yQoYBBDsYRAmwPzDKEj94YHpGELk8tQwZWTmu/WpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TlFw24DP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TlFw24DP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97M1xbzz2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EUZZp2326538;
	Wed, 8 Apr 2026 04:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C8vCeO
	ts7WfkxEBK9VS6PksqNmFdWXiGUd7atou3BUY=; b=TlFw24DPSf04y3+xNhSggs
	0rG6qKCkGzVi37zkE3cni9FBt4hPm4CpCJEdx/l9I0uqqnWIENJC1I1zn3qfwjAz
	DDAvj0jvdtGV7Zn5MRK8TtYkxS2xVdICWua990krZuzDC5u9nC6I19heeXojeTq2
	raG6xFXyIYmYKkIdTrEpRf+hHzZ8fXdd5QeClcxz/MtKh+NDBKNqI1hi9vOv5ksC
	0YN+dKsOMzU5A4r1/8X/VQtKXjwNuwRHLV+GWngJYwsRaI7qBGw4WO1OR08tAtRG
	l4/DpfYcnGaTv+R0vtjtjVJzKh+99qInru/R2nlpvGdyxiVZyQqTHc2j56UGOp6A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdre5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63801LnU013878;
	Wed, 8 Apr 2026 04:28:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf46069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384Sl8f62718314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646D320043;
	Wed,  8 Apr 2026 04:28:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B5920040;
	Wed,  8 Apr 2026 04:28:45 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:45 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org,
        jirislaby@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x/uic: Consolidate chained IRQ handler install/remove
Date: Wed,  8 Apr 2026 09:58:44 +0530
Message-ID: <177562236424.1381144.12015372455463712391.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260119063507.940782-1-nichen@iscas.ac.cn>
References: <20260119063507.940782-1-nichen@iscas.ac.cn>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX735D7OxnhACf
 JP8CmqcOu9heQOrFcP/ea17WTgxV0LNyUtRGcDBATyxId6FGkhVpX/XHCeyq3GQUb21fs+iZkKt
 MjUC/THFIergXJTi+e+taZwOMWsRwbpct545DwZuYvDYooSBrjufzz386x5IAYOpNN3XD4ZS5HG
 MsinuZ4wHaY+jGXhCCmryO6kQpkDRZF24F0TPWVpC7XC4zt2q0boOgmZ479nBx++XFfBnOplAKC
 BqQQJlbDpFxAb2FWCjN6gpYuYJlB3ahP2scH48JnztJ075Z9YGnS/RNMYjXD1D7JxsgDO7ElrWG
 MTQ4VXNQgtWtSWfX8ZcWm3jv1YywLvZPSjd2+/KZO1/MNbCTROLe+yCF2l+nj9sOe/b36Xu6mdB
 zwi2ghlpvpnR6B32NrwmYN55Pzw+lJuB5T5SIbwczXUPAC9mSiS+I81/4/P8i7XTGdB3JDH42ak
 DbJf949lI2U1FlQVY+Q==
X-Proofpoint-ORIG-GUID: rlBD54SvgFxjYA3WRbce0WkzbHPRPejs
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5d982 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=2t0PECJ9fgXNH_Wv8BAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sg0nOxeYZAkw3-CemDMrN6hqb6oNrGos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Mon, 19 Jan 2026 14:35:07 +0800, Chen Ni wrote:
> The driver currently sets the handler data and the chained handler in
> two separate steps. This creates a theoretical race window where an
> interrupt could fire after the handler is set but before the data is
> assigned, leading to a NULL pointer dereference.
> 
> Replace the two calls with irq_set_chained_handler_and_data() to set
> both the handler and its data atomically under the irq_desc->lock.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/44x/uic: Consolidate chained IRQ handler install/remove
      https://git.kernel.org/powerpc/c/5716cacebac887b45091c658caa6d1ea25c238dc

cheers

