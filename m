Return-Path: <linuxppc-dev+bounces-19469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B52FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97H3cMxz30Jy;
	Wed, 08 Apr 2026 14:28:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622539;
	cv=none; b=F1QJlcih+kRXuAt7HPpPMGzvCh75X1Oo3DFD8Cj3BvOH+Dp1VPd1qWn3vC7QUFk2VPcruaSeqY09YliH+smhpBF+sefRzd1yy+zgVOIYgTdNep/iQOrFic3ZyqpN1MV71H/m+c79s7r+dYPCkbm4W5aasRnyzfwUrbDvmWIA1EmJj+smG4158lS6d04JTowoJVSPUTu/yD4SwEV+EJgLcrNEX2RvIzh/WfOQP5YLvhelVKmkDNZIzu8Av4qGh3mfbUiZgcc3B7W5oHaEI0E59H8cs2Xf/yyvhIm/HGqEz57rGSJBXtUIUD8TqKT3nWDqEMOkspQXBji6f377e4MuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622539; c=relaxed/relaxed;
	bh=UjosQCcLkNrR0qX1/zfw9xI9UOIUyqplMiXHPOs2BtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HblQv53MJhIQZB5WpLxZk1/1n4tdjeIirhb0Tx/k2gSYuOGxr+RrCuhBAIsSnRnWhhMZ1Us1QZU8o8FJNr8zii0Q+lKblWEatD+FO9X+PE9aMPRnIswQ7vUH7TF9+ZmOIAkTTPFIEPbQPk+DLmOnq7BEhWQrzxon8oJXnzNd9tfR7l8oPuKI5fU5+BJT4LzEwWGqo2nCPdZO3qLJSkXqs4pJBGCm7+B+dgLCPegKXwReq7ah5ESL6pPmdwt7e2j/d7REg/2z8H+f35iBw8RmnNRM+3ItkddTStecnNDiHwwTdob6pJIJspF+r2FVywcedK2aAChFmxPPwrKAd4Rk0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFNhxFAF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFNhxFAF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97G5V0fz2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637ESRYX2590966;
	Wed, 8 Apr 2026 04:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UjosQC
	cLkNrR0qX1/zfw9xI9UOIUyqplMiXHPOs2BtU=; b=sFNhxFAFOrf2jB3gkZSdSj
	APpWY9CpuCyrTlWo57sbrEYAE+/7mwQYkFYVogXBZMBRxoVwY5jOiCbC4Ii4Yf23
	GTgu4pwO+8lhYBwVpXAFpITgZA8TK+m7TqFk0iHAme/ermghV3OOX3Ea69ORGKJN
	Icz/kwxW61EprK3umBcp94iOsT4p/TOoIm6CbsUwl6rCiuGhaEZMWZugcZDivjMs
	1rCAEmEMcHN69Cu9d6uAYXviLOEbDD1QOqTY5Ex0Iicut3k7l2Eaxk4nz6YAB4ud
	EqyPzO8FxNLH25O8xTaFBWYUhzpqTnoFSZZHkEvEmCV+0b9jBMlIzVB8ljrqki/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e67ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380BO1N007942;
	Wed, 8 Apr 2026 04:28:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2dyxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SiE07536924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3339F20043;
	Wed,  8 Apr 2026 04:28:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF0E20040;
	Wed,  8 Apr 2026 04:28:42 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:42 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH RESEND] powerpc: Move GameCube/Wii options under EMBEDDED6xx
Date: Wed,  8 Apr 2026 09:58:41 +0530
Message-ID: <177562236425.1381144.9623126221979387858.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-gcwii-kconfig-v1-1-636b288e7270@posteo.net>
References: <20260303-gcwii-kconfig-v1-1-636b288e7270@posteo.net>
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
X-Proofpoint-ORIG-GUID: vabGVehXbPh-cBA3Nfa8ng-r-5WYIbEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXy0DoyEmgikXH
 9XsZKRtPnLkpj0TkSnTtbhSMS1FWv28hu31KsRPtZRqy0ObloBIz8JeYgwIHONZzrTgHwvQbOhq
 lpliW7TnOvxTziigtH5b40bAZPe6eRVquY1ZVdvfIyBp3qa5MoaEao8ST2oIo5N4NT3Wl6I8Ur9
 x4vzz1SBWVM6Pbkyi5eDSUVqkKJqvYytlzNK56i45SLkfJwVeqRyfOnle+/4/TJfphAJqGxcxpG
 OUOimm4jlG45YOveRHcZDLmxoJC5soHU/J+RAF8kggiDMHYJ24FK00jJV0DspR+MOh+/UeyRPWp
 3gFMosrgLKE8sNfyIsfHa4AxbL+q6dlzY2ypwLLMK/lCc08GejvVVyJjm8T10ilOgFVc0CxFmfm
 LvhlPgifiuvLsYtCKcl5aIcWtjyf2UIeYbeyLi9Oqeis4i79eIrxHdxst9EglITrfITpc4ENt0J
 GAiIwfXeftJeGgod1XA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5d97f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=oClvhP7utr9LKb4MSosA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IfukH3FCHfLMi3LbntYFKTFNzfWIWdze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 03 Mar 2026 16:09:49 +0100, J. Neuschäfer wrote:
> Move CONFIG_GAMECUBE and CONFIG_WII directly below other embedded6xx
> boards, and above options such as TSI108_BRIDGE. This has two
> advantages for the GC/Wii options:
> 
>  - They won't be moved around by USBGECKO_UDBG appearing or disappearing
>  - They will be intendented in menuconfig/nconfig, to make it clear they
>    are part of the embedded6xx platforms
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Move GameCube/Wii options under EMBEDDED6xx
      https://git.kernel.org/powerpc/c/89f46b578694f1549426277c370488479d20e1ad

cheers

