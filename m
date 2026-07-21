Return-Path: <linuxppc-dev+bounces-24580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99208C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:15:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49Db0Rfqz2yfH;
	Tue, 21 Jul 2026 18:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784621727;
	cv=none; b=Pyd3noRolOgiF+jdx0vadWWAnnoypH/hdUP0qbV1uTSI92/3Mr5jCJdXT9JAI3jHNCHQhPmQrH71Z5T9CqRSKDVwzYl//qfDE7K5HY7hWoGy8djOXB4P8+fwZqX55GbR0k4pVS5b95a2ihpk4N4CqfVBTSQSz4d65hdDwTy1NisbDZKhYvrnbgU17I8b1kNElcJbFo3EeZU5ycVrfEZIMkenM3h0R4KsuelDbycTQsnvLIHnrOD2vc/1eW8iK2HnK63VEM5bgdyyQS00RL7NHgugLrT0mEOpnpzUEnEGMeqCSgNcHIjmtc7czUCpTj/LWMODe/VKVlMfVvEoTBPtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784621727; c=relaxed/relaxed;
	bh=wnrXycjrzW3p8VBwnIgHqFdIViEruXQuoINEQQM7X5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7FDKpsnMF47+qa803XOULDlrKavLQDN00cCS8v6jkPUgvPpj+haQVF1cfYv8Nl152G3Jk9/QWiKEZMwOmTUVKVN9L5Qos3ReHIFHk+TCZ6Grn6Pzc6esjpCSR/qY9M1LPOhGe++EH3xnNewbKgpgh7auAUeZ+8LwkYARfvHgEuEReqt2cNORs/ZGpAPfjYNcgZzmsmQ1mlAEAaqKwOcLkR13AP8YmFGuXlJSU4CKy+sdTMQem4eM5NzNwPLGz427MYm/z/tAMTMMJvdK6YRXF10yzoFoTk8k/Ek7iOIt8P5Z4CwuBjcpXJCP8AL7WM+9LH3UXcQaax4duQsuYfaKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C99oYJSk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C99oYJSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49DZ2hyHz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:15:26 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDuLx3482046;
	Tue, 21 Jul 2026 08:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wnrXyc
	jrzW3p8VBwnIgHqFdIViEruXQuoINEQQM7X5Y=; b=C99oYJSk7OoxLn5uAfIVnw
	+S2uDjUzesuXDL/WjPk9QJDHGbfLs4jgT+vYgP9GJoxLknGNFaqXb96cLuHroXV9
	yS1NMMbkzDxV1hknfdsSm/btObDXNMWSU9CjtebARQA5QH3TgFGZ8VkO5ybE8F+i
	FJvZ6uwHBMKPo0IIAQsXvvlUgbQy6gwMshOouim78Cct2SXELoLIyijnpyXxvucx
	P3HAuqaYNO8rZnRepyQoBpiXLQeNJ3jFxhnZHtMzUP0pbm/4UA7fbiXPSV739QcI
	VHuxCOnbsF1nAYxLw7kD91P/fiABZ/crFXx7fv6oONWp2hXLkPSeTM1itoBj7hhg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k37w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84ap7000930;
	Tue, 21 Jul 2026 08:15:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w1g5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8FJpK35455452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D72E520040;
	Tue, 21 Jul 2026 08:15:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7973B2004F;
	Tue, 21 Jul 2026 08:15:18 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:18 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: frederic@kernel.org
Subject: Re: [PATCH v2] powerpc/vtime: Initialize starttime at boot for native accounting
Date: Tue, 21 Jul 2026 13:45:17 +0530
Message-ID: <178462153937.1974055.18353161262032724096.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260605124329.377533-1-sshegde@linux.ibm.com>
References: <20260605124329.377533-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5f2a9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=KfJoYC6utgCICWuazgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX6MdOk8AX51Th
 kzsbMBeVSHpdR8C8mD5P3xv6yoeGMKV/5QxuEdshk6BNMxWc54v+v4jJ8fmt7/ijFFHhprk7uHA
 cBJXknDx3ll8LSIRFjG76kHQ1iNu5APQzfH5JINKpiylY7fWvu8WLn5zbk38IIhRqPQgG+BLN0H
 zRIBmewNbdGTzOswWmnIEKtYT95FxXSo6rzO3U5EIh7dme4FLGwhTK+b7KQTGHGPfSFmEOzU33c
 Q146y5LuCr9RMpmemqyXxTting5KjmthEGhXHU3zQEl7UaqC7VOR4YJynWuxhGKOeKmGFGl/YGA
 Zo+PH4OxAVgQkT+aex5OpdvXLVWPLBb86NsqrukiRBEnxrk6rRC72iNOoXJnQZsbxmFT6TeLvmi
 J21hSKWkVbyaVMBU0VTnL92kpLFWlZw2RKTdLfxRDXkB4h/Wg1cLzLCkb/vE35rlRM8bRj7AoKV
 BhdGsYkIic+1cERWFig==
X-Proofpoint-ORIG-GUID: yolx0zFOkfTKymXQADEyyM1vUtM6NNXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXyeQtxK6VdiNc
 wZSsKweDZ//pDlfEMvHp0sHXloEkH6QBoL+xDgZb+iQ7Lq7iGc9W9GdcU2IpbgV6Ac85hA2vTU4
 53ea8tdDZEW8H5bS+6me4GJmUnxkO2Y=
X-Proofpoint-GUID: yolx0zFOkfTKymXQADEyyM1vUtM6NNXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210085

On Fri, 05 Jun 2026 18:13:29 +0530, Shrikanth Hegde wrote:
> It was observed that /proc/stat had very large value for one ore more
> CPUs. It was more visible after recent code simplifications around
> cpustats.
> 
> System has 240 CPUs.
> 
> cat /proc/uptime;
> 194.18 46500.55
> cat /proc/stat
> cpu  5966 39 837032887 4650070 164 185 100 0 0 0
> cpu0 108 0 837030890 19109 24 4 23 0 0 0
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vtime: Initialize starttime at boot for native accounting
      https://git.kernel.org/powerpc/c/c1c1ffa490fc33591e90852ed0d38804dd20bc36

cheers

