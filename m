Return-Path: <linuxppc-dev+bounces-19467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FB3FD5F61
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97D6dgVz2yj1;
	Wed, 08 Apr 2026 14:28:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622536;
	cv=none; b=YbBX7uaSgtBx773rLmpFXMiUupLqlVs2d0E6L+8Td4LckJnAXNpsV67v0SAW+z5AuUvF+/MJdsP0QxCfxcdTEiVGmHusc1YuugzYB0guqsJKX9CpeIuJojobjCGkYYWJEngh3P+7lMZkYC77SNWS933PS+D2lSxObiUJO+eWBpwlFmb4xdisV0a6FIN8m4BTNX739cJOxU0Ku7TCUeAtjJsa6ET202+0Q10AqSHuvCbxcMS86VpJfGIthgME6HiFEMP/7WFH4ZV2Z/YsqmATFZ6K3RnWtdkrz3unEhgk1wan+vzWBFEF9HYqvG/ZDPUK5OtjwEE0rSr5OXWFz3lnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622536; c=relaxed/relaxed;
	bh=0tT7ekGBhBR9Pkw9VXHVPV99qlF1DPhNiY+7VcmD8v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+WMI5/IcDrw3baxSUysS7/D7Jru4KyYjveHhDaCADLhGc+J/7WFkOiWTqbOkmta+b4bgN69lWvNjYAE/g2yMqBZqzEjWo+CiUyTxq7cvufayzeGSuCCs4MdrYm0CAyIHkJfEJ3YI72Dg4CrIsgheSWuWSmGVZOJgJmOYOwc33y3WX9f9BYmNSvnJ+baDN7LZ3lYJuR5DhJDRLZR1wxQLQWhdb5UqEeSJtgouUOaN4MmKPmnnHV4PJRFRuO+XbOJRq3/50s52e/FETdjoMzHS1byBNn80runK5iGTaasy0qIWMTgBmA7nCtGYMu98X0I1iqcDMfxsen/BR3Am+MmZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=swuNmX4k; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=swuNmX4k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97D1CWHz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:55 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EeCdj2211703;
	Wed, 8 Apr 2026 04:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0tT7ek
	GBhBR9Pkw9VXHVPV99qlF1DPhNiY+7VcmD8v8=; b=swuNmX4kEdi/7gij+W7thL
	dE0UelKHr/CpitJbpOSacSva0yjUmiqJuA1azR2ps900O74aCeUyvrf+qP+AFWnx
	xWqOSIre+88/HKhMKF9A+6IOvA5l4tbmfk+wnESJ992+NE/i2RUyaG2bFopFxtIn
	Xx9DsyIVxeFC/U/u6uJ4mQUnavI08zfIJbTfTOl5rSAvB3XBGU11F9hb1rvnojdI
	hbYtwaDpnXODqO0F4oRKXOLd4EAXujM7FLcXryLhE+l/QIsQS3xcbBGhH+/ktoW6
	Fl1hPuAr+XoiUXDzvPwadyoVSL9/+ipsSNm+oAMGuK4dTdbwGa+EXRMAhTz/e81g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hdqvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NwmkP030062;
	Wed, 8 Apr 2026 04:28:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dyrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384Sf287536908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2827920040;
	Wed,  8 Apr 2026 04:28:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C47520043;
	Wed,  8 Apr 2026 04:28:38 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH 0/3] PowerPC/Wii: A few devicetree cleanups
Date: Wed,  8 Apr 2026 09:58:37 +0530
Message-ID: <177562236426.1381144.9452129890234194382.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
References: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX1P9fnlFwrkyL
 FFFLc8MMzA4BGz+LQ03mL3v8wCcVb2OYo+Hp2y9S8JHCOp2roU3sIDb8Qpdv/UUm4Jmq0OzP1WQ
 wqWODmdL2UlVzPHyrBpef3A5M/0PhoVYr/nnplgVNv7qpa1hSZZQcpIRwcJMUA0vG/cWe7rGmLm
 Ht/AX0VKuQux9SJJOZIJE4geipXAYIOV1xX+rrHE8UWS5KE9C47rIIN3ViDyV54lfaS+HeHeTx4
 U6s8Z2thRWe1guzidl6iSybMSOl9ghCEvXR6YEweAbifL4LNQyScVuBZ39mpZUYWG9CR0EnnSc0
 Kw2op9XinkDmYbFwUOmwQIa8Q7dBctWhjNwBQHmGtxGbM5eTujczDtv7/Zlsn6/n/Ab6vveX5qQ
 OfaasdqwsmBVkO+9Lal6p1d0Wr1gHTkFtc6uT8ycOGEt1T8KMJruyFOs7lk53qOXeqtRosAYp+0
 54x2XJGEhQW8TH+DbMA==
X-Proofpoint-GUID: Zf7BPce1fAdWDHeJGRosEq62-8H2vSBL
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d5d97c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=BppeBZHskiO_FOh2NBIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FYE5_WB_lGAia-e42jGk6UpUuc4JA6mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 11 Mar 2026 18:35:55 +0100, J. Neuschäfer wrote:
> This series contains a few minor fixes to make wii.dts somewhat more
> compliant with the DT schemas.
> 
> 

Applied to powerpc/next.

[1/3] powerpc: wii: Add unit address to /memory
      https://git.kernel.org/powerpc/c/d1620f27ed1aa3be4255513e1a213ab1805ec892
[2/3] powerpc: wii: Fix GPIO key name pattern
      https://git.kernel.org/powerpc/c/4a03d824b3204bae7e19cdf47a85ac01027603bb
[3/3] powerpc: wii: Fix LED name pattern
      https://git.kernel.org/powerpc/c/47a05517c6edbf5160ce1bff107c10b76aa09ef7

cheers

