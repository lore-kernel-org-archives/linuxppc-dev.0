Return-Path: <linuxppc-dev+bounces-25637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A18C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 05:28:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH8gs2FF2z2xd2;
	Sat, 08 Aug 2026 15:28:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786166921;
	cv=none; b=L9H1xbBJbew49Ese6YFrhn47TvcpVL6HdbHtXGOlrKLhunOH62aYn5Y3pzPaMNfD/JWXeOXZABdZZ3kNxtuzOwE+Bz/ul+P8TD8KiahBODg1+98BY96tVvgVHIwSsUrcdXISBKu1GAe0jtRAhxLh/r0OwNkR50ZwKVmGkytNF6iC7nSD6EoDSoJhB1J/Zdb3osvzcHuM2Aj+hRIWGdsTC8JUzDvjNzqPhM9jtHV925cmds+XR6JA/ZSooVF0GfVIFTISs/lHw0FrVnsbIv+6mXbdzge/ytJrXStQhN2FxmfzK3BRrAe94Nf/CroK7A0u4Oq9R/+F05k9RAaE9FLMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786166921; c=relaxed/relaxed;
	bh=ZrY9712h20Q1QlsEboS5JoGDrpQrLgJdzOWRSGLLgI4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=D68ZnOIoaWvYVVc00yRPSN4W1pJwOqDr6yGuNCN+ov59g9NqnDGFgDrYW4wOfcDbfrsOpKsi+dODqa3dRUZ8xWNXFuXDQtarHzO9KmWBqULGakEic2j1LKI9ytdrvLpjbIvzGeXycWRoWqSEw/lVuGeoAqOwjeyTgVQ9H6W9dK7auBQ4HfBcyH14TSMSrtpRQ/iXtV4hw6FT/NpTzktnjDMZtaLEIgpIspqt5NKLYUDDCKDPw1UwXnU+1KRSxgstP3TKCUUTTQaUsX25ryaoGU3oXHwGzSDIpEfjPC/Ub0V0Q7UBW0WAOWVLGr/p+4Bv8AGDt0EbSvR1L15WD2yqkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DrRXwIKd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DrRXwIKd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH8gr3cKpz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 15:28:40 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678489Jc3326201;
	Sat, 8 Aug 2026 05:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ZrY9712h20Q1QlsEboS5JoGDrpQr
	LgJdzOWRSGLLgI4=; b=DrRXwIKdhiWcWeCup7Cwj89Y+dqDEPITT9CvkeGaUkk/
	ulrtz96cHTOLdope1llYCFegYGuYOxcsprdYgex04h2Mr2akU+4aRaVS51YtWlDB
	JQZC9U57byHs4VlZ+iHXwwwO2ChfqRxpNP8ac3KZ5kgiBd0B89iSVu7QWq5lXJdw
	Jb7kyAfWlligmrdz1MJ2HzdTQAi6Vjg/wDcp/C8a7sVcqaJqlGzXfrALJE8C80sK
	+n7HjidOEwM3iBgbnyQmEO0mtDe3bEMqGDwFyRnVrl44roHig+LAXSlQQJMTqmTL
	pKGoqD7R8d2vhQv32n9eR3qv834MIX+d4yT+C0a2fg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2g7ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 05:28:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6785C0no001449;
	Sat, 8 Aug 2026 05:28:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kjnku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 05:28:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6785SP5924445566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 05:28:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E9D65805F;
	Sat,  8 Aug 2026 05:28:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 966C45805E;
	Sat,  8 Aug 2026 05:28:22 +0000 (GMT)
Received: from [9.43.41.45] (unknown [9.43.41.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 05:28:22 +0000 (GMT)
Message-ID: <be9b4950-898f-4f17-825e-415b30e0d892@linux.ibm.com>
Date: Sat, 8 Aug 2026 10:58:20 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, gcwilson@linux.ibm.com, haren@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, nayna@linux.ibm.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-4 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a76be7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=qrUzY55morn6TlZF8AkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0wo_vgUFEDjQ0vp_cbYfXwdb3xysAXrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAzNyBTYWx0ZWRfX1aOXZL+D3vdX
 VuauDgDT6tdLM7MOWO/suhP5dUsibThpFAnZbevsCO6b02d4wk3Jm3BAHSumlews4FOwk9uydqj
 C8Lt5PR4eBIF41pWFRy8LTmXKbdxR5PTu+FkSfMLypte0Aff0SJzahPdA1MIfLJkDN0c5AWTLZQ
 MJxUUiSPpr5w7SpHfXtQqD0VLFaELDzXK9OxBmv93v6XAMaEWGeu1jW2EksvC75TOLws+8xDyvD
 GB6flNa+FoWDGIv0yn1ET2UnggA3OpzzIHUrmCPVzvAnyeweHS8zD0JLoGKZ8CdweE9ek28uZc3
 bAnpnt+ThljsTRv5p9j/V44T59ougi3HJbzCefIZ+eoExhlZWKQs8RtM5Po4fFlfRVLM2G8OV05
 rJ5uHOrubxBhWdt4ixuyVOnhnRrwFZGt6unSqIFR+K20YefShFE6GrGa22a79cIZneOvdMr+rvP
 UbpQ7tDxg46dV8hn2jg==
X-Proofpoint-ORIG-GUID: 0wo_vgUFEDjQ0vp_cbYfXwdb3xysAXrd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDAzNyBTYWx0ZWRfX7T0qj0Wtv34x
 OM4QNSxHyPqvHd+oUnj/oFyuOYO+4En2ZGwH2ypuVhQaTmMerhwKnajGGYjXKhtH1SV++2hRUTu
 qO6TKH0rANrGjzXMHa+uI7PEMk7nHdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080037

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.2:

The following changes since commit 5732bd17feb9ddf843591c4d038eb6de1f8daf4c:

   MAINTAINERS: Demote myself to reviewer (2026-07-29 17:53:21 +0530)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.2-4

for you to fetch changes up to fb442a6673ff1046bf67754957d95880fdb394b5:

   powerpc/pseries: lparcfg - fix kbuf[] underflow (2026-08-08 10:34:28 
+0530)

- ------------------------------------------------------------------
powerpc fixes for 7.2 #4

  - Couple of fixes for mem leak and underflow case

Thanks to: George Wilson, R Nageswara Sastry

- ------------------------------------------------------------------
George Wilson (3):
       powerpc/pseries: papr-phy-attest - validate cmd.length, plug mem leak
       powerpc/pseries: pci - logic bug
       powerpc/pseries: lparcfg - fix kbuf[] underflow


  arch/powerpc/platforms/pseries/lparcfg.c         |  2 +-
  arch/powerpc/platforms/pseries/papr-phy-attest.c | 12 +++++++++++-
  arch/powerpc/platforms/pseries/pci.c             |  2 +-
  3 files changed, 13 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmp2vdUACgkQpnEsdPSH
ZJSZKQ//YXI9RiYMhfHTyJyd1vSEIuGzZoRMrb3SPw61cbwS4lOdjnpEGSDAHi95
HcNh68gZNavxCG1xnyLayKcXuctSUm5AATbOmSQ6SoxvH9xzBPxVe/N+jXh+TJBQ
TBl+h4OtOPq36NjSzQytb2MSdq+nctBoP+ryGZA6aLB9uDtUbXREB6Vyp9CRCAUa
cQp4b63foop2N1oYwAjBoAzS5/Bl7nnMoPEAOsNKWErz+o2wZFLrGGGUKaybytH/
wh4rtqsphC+NjFtynZYtJ/DwMkdzchawUpaNbBsW6B+zUbKmhYJ02OYcPsKfSKVA
aLpQ07KJv+e9+KHnHiim7xSd5ST3tWwFR9yAEeXuuKw75vInjY09GKmrONVU7iQH
Z7ToaHW5PtEl5qUcb1l+DsymRF3iip8+mFPeAka5+sgLtGE2Ix+hNpv8QIDeTKx8
cI7S+6p1aEEMhscmEmCnWGmqAqzYJp7ZwXog3OXAdFGPNiAcbjwW7khvK6i3UFUV
0ZbvmYyZWDJ0dVfXyvTe7k5d8CVELpGswC3a+UL4RD5CFEFjJQw/hYN6muDfiAgm
R8yoP6IXZC2P3lA+/WcZ4ZiaZ1BDorl0+BYi2hH6b7hlUHskv93S+QHibSBfp2jO
sQw+rAIsdf03Ntay1ZpRq6/iAW/JOF5v5Nw/PFNz1HB6Pfo9kcs=
=mG9t
-----END PGP SIGNATURE-----

