Return-Path: <linuxppc-dev+bounces-25463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C15C55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 04:17:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFvB233zRz2yPR;
	Thu, 06 Aug 2026 14:16:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785989818;
	cv=none; b=gwAHjL0ju2JNjpvOTsAITtv7I9QRAYm6rvYYD7z07KerUXiIWSSN6CDDp4U6vBL8La5qPj3DtVOVTD+zD1qzRX6ubqfonRsMUSnVWTwdrUqtH1ztjpqcFwjNTTtH56nQpBqGtT+abjgtV0YknXDsuUAD1SvxEpsAJPfoKPhkQwegxanaU5wrEtd8oD9hwMMjxSivPdyk049AhlP7vnJkBn9+5hRrQIUEhVk55TyXk8RE82h3+lN92Tc+zY9T+wbdkVuxIFn984SbD89VRRlrnT5a+gkfU4vC/ynGqeKLJXe21Or3QWhWDrjyzlkJZmSDqYtKrOtiqSCPU9ISypJqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785989818; c=relaxed/relaxed;
	bh=3VNk7P7h/7p8adiVwPvadjTDscvZzMJkWpB/uLF3GvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PT69kHsq4s48kRijSuAuKBawkr81HCG6JT4wAI1xwTl1sjqBuwqHdn+6v/9hW/xBETV+VOMeZFYB99sZoUbEq6MVbDY1CorYOxRL4ESHQszxr/Wm1efan0QaZYhn9Z3zRDiuKQ6dGogYcfhYspCaJisSJ2to5ZwlcUhek8Q40U/QuetZaKoMzYzK8kI2BrhwdvtL447Sj4B7+kG0OVGxAEbcb8tpE9fEjQn6EJd/sj2PpKCLBwSEKlMqVwfZkH4bGke25Fnc12zGeu7AsthOhDN2mM4DTNqyZ9hmCqVzMarW1vJbIPqY1Ersg0DUt+AuRdzt0oJApbvUSzC/SVNlwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZqAYAlHX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZqAYAlHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFvB14n3lz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:16:57 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmfoK995593;
	Thu, 6 Aug 2026 04:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3VNk7P
	7h/7p8adiVwPvadjTDscvZzMJkWpB/uLF3GvY=; b=ZqAYAlHXCrIAQdMJnfHNRx
	Qr4TVb9J5sBtEeSaHHNW41XoVmL/hwh59+JdU+QEuolfhyo0vmAPw5ysMIEL3deP
	PWZRm5IwqSjh1vn3Kx/jqA6qMtZRxhJZuR2XdlhaEYqXhK9asHd0GZzR0NehvWJ3
	IsdCbr1SaNLTQK78nAdk1KVdz3OK6t34CUKoOgH5SFiBB8sRdhnnBeh1sBnSadV6
	IZFe+oj9Y2xqalgFjqGdMO62QqHA+3K3hHfUem36ICL4XzPNCRD0PmDnBm8CRL3t
	yf0DmmWVipiASgmAgny+8jpK9BCIiUrlf3dXVVERO7jnrfBlVxCQBoSklNVhF6Pw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gdv1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BOkr019300;
	Thu, 6 Aug 2026 04:16:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw9pme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764Ggq343909578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE6E2004B;
	Thu,  6 Aug 2026 04:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 340C620040;
	Thu,  6 Aug 2026 04:16:40 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, ritesh.list@gmail.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
Subject: Re: [PATCH v3 0/3] powerpc/crash: protect kdump from active watchdogs
Date: Thu,  6 Aug 2026 09:46:39 +0530
Message-ID: <178598971870.942627.12770891054644025533.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727053416.276317-1-sourabhjain@linux.ibm.com>
References: <20260727053416.276317-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfXwkxSeM+Awl8E
 IECVkwZV6ZMC6eaDA4p5aJDDlEHLgly/JcNC0KjHGYmdPjxmuCz13qcIKQfZd5mwM/7aomtIhg/
 6VZpLY57DOKQU/2sJAZsx5msGnpA75zV8+ok+pNGdgw75wYNmUUjy9E5II5UFak3MSbqiD0MPjg
 cEob98EUiIqwwQtlVMzxm82xl++OdcCIpmNZCm16VdWJUJRioeitoQSa9vsIPQkNFFZdP/u63fz
 PpI1/aLLKme0iIl9RbgswQq7W8YYzIWZ35F7/OXc0rqD7FzFSi0zvVPx1u2KINPIAjklL18EHgx
 P55Ig4jvtKnUx2lD9vvj1xymBWXUG9uNJq0s/TiOwzVeBexNv/TrnzHGerB0VqnaglT3uqKhaUr
 CRHQtjLljCXl1E48pXE9hfAa2qlrskFV7qpa6/anXJb1yjUqomLODshJF/2/aB5iOrhOHUAgpfd
 72nOqhLiR/z2bkIbN3Q==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a740aaf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=G9IWJv-s4P5rHWGXQW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: b10XuRvxO_FQqFGLVe9Hv338WgpAR5vb
X-Proofpoint-ORIG-GUID: hgDNZZwx9dpcrtoacrLi4v_a-rRFcivj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX30n1V57ZdtXN
 jCnQp/lxH0rzsf9T/pOCqg+Fo3DF/ed06od5jFurgJ+bN9mp/X1yD6TNOk01oNtk/BElDLyVqKY
 60HAqPbatLYlducCtfo4IS0oMNqVTYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Mon, 27 Jul 2026 11:04:13 +0530, Sourabh Jain wrote:
> On pseries LPAR systems in a high-availability environment using the
> SBD[1][2] service, I observed that the system abruptly rebooted before
> dump capture could complete.
> 
> Further investigation showed that SBD had configured a watchdog with
> a 30-second timeout. Since the kernel crashes directly into the
> kdump kernel without shutting down userspace services, the watchdog
> remained active during dump capture. Once the watchdog timeout
> expired, PHYP reset the LPAR, causing dump capture to fail.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/pseries: Move H_WATCHDOG definitions to a common header
      https://git.kernel.org/powerpc/c/516a254918453ec99660201263d01189c082332c
[2/3] powerpc/pseries: Handle and log pseries-wdt registration failures
      https://git.kernel.org/powerpc/c/e65b526affa621b50646cafdf6b06505af07032e
[3/3] powerpc/crash: stop watchdogs before booting kdump kernel
      https://git.kernel.org/powerpc/c/fb43ba4256543ce18ca0540fc37022bda438a293

cheers

