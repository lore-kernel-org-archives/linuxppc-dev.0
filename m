Return-Path: <linuxppc-dev+bounces-20666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB6ECD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvM07qtz2xFl;
	Mon, 11 May 2026 12:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466526;
	cv=none; b=VHDiX1XGL/EVKQE9yQHDB1rqstEtz9385o3xxLaZtdrAdaFuLQmg6UCu6s3Jbt+apqGN7QULPN8eOaRYl3GkUPD1FddUPKRoOWwQFfim18+cMiJ2DYO3iFTRneeLONui7WmkiRWVYx2l+uNXMwa1dyCPPYvqgFDDKtgFVLrk6zncG2Xl2to1MI4/FwY+Tpix7YY4UuxuiSNi/wW9z1kSN2cXUC3sh6YP+aMIUwiA1YOi4us7yO302gI4PY55ZS/7HsQfI+/DRokeBc9LhA6fbRQRtQ9js5cyVguHFqVKjLs6dGe9MagO3T3TizsMD6SHEhQqf3ytUNiiZtG77yjb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466526; c=relaxed/relaxed;
	bh=WK/4d6NWve5x5vGGR4UnFFqmj0dnQgGvjTIKWDgXpuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImRgUhBMMSte7XaF2fFFbeSJNKS1S6BRpmNnvjSYqTEYwrVIUFR38+Sd4wb5iZDrVd3ONBUUG8oBiMK8ewOu+dJ+sx9K02lC3uKauMySdCoLPvwsmW81c2Sa/bbqnhoMCZDI155ebY+SmDcQlmGR25YW5wt1OyxU4MmrhW+XrdbfGXvX0+wVyr+LpRfOs8tlKwEJd6GHouwlPh0NL0R3hLuTb9I5LAdlDIWXZBg6doWwV/xQQGzw1XkjVrNE/FN89KlijpOflIUGsalD5yhB1ZvG2rTa79edWdE9ZGBcTbhp18kEJ5zYaCblzo0oa2TcU16mUjF/8OEYHNeCF8X5gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dOYDMtMZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dOYDMtMZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvK6n6Jz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:28:45 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALOJwG4023653
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WK/4d6
	NWve5x5vGGR4UnFFqmj0dnQgGvjTIKWDgXpuQ=; b=dOYDMtMZkHo9K4U8VkADcD
	1Xfwn80IDibu21zhAKZ3bmqmaJVnr9USUj5BJVuCYT96tGJi+0bdQUJyFNelAwRt
	636HmEKwigfcpIjDXGgi3nUpJS7eb6YvlNCTByyHDack93iW3aQod3FhRrCVF+eE
	DTJYSw/oWunMbJqMmBRwecpPqB7LyYY0vaDge3rrbB+nla0xkOd/WK6Mn4Ii6y9v
	YPy1VdRU6RYEgcLdhBPxhTL+clyf9Sgf1D2JD7hjjAfltwhb5sAC9DGiPowOg0dr
	XKUveRJh202ne78BuoUJl1MyZgkPpvHNNTxuizeic+EaAsVTWFMfKh3qQhaRxyfw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju5rrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2Imfr025730
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg37bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2ScIK30408960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C325F20049;
	Mon, 11 May 2026 02:28:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE5520040;
	Mon, 11 May 2026 02:28:37 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sshegde@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] powerpc/pseries/htmdump: Add memory configuration dump support to htmdump module
Date: Mon, 11 May 2026 07:58:36 +0530
Message-ID: <177846637458.1289230.4163169775909389692.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260314132953.27269-1-atrajeev@linux.ibm.com>
References: <20260314132953.27269-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a013edb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=CDBnajM1oAEJ2gr68O4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pu8Zv3SfzcIvqerhfoY2K9kFB2MdQv-6
X-Proofpoint-ORIG-GUID: pu8Zv3SfzcIvqerhfoY2K9kFB2MdQv-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX+6rG9dASx0NP
 MSvmAVmMLEgeq1gaPfThMkTtCDDt52fW1FJmZ2XdWvj816eIUREuqDI3myD1ePuieszsS4BThFF
 4Sa0eaYeeYtjQpHaqdYUARglSjP7uJH4TtkvpDFyF/XNTPrqmVnkqUOzItYt9KzJrslg4NnDvuo
 5a7i8MgKnua9Adt6RGBSDHA479/GTn/kgEfYv11ysdYKoQ9Jso7xo60JJfR8fFkOSSDvuQCWB4S
 PMEwBQQSNQctWxHAwb/MYmoiGJinYXt6QG0SAnVPzYvBvmhg0XhoE6XBiv+qwndw7P93a+28tCd
 kgal0ToU7HgxcLobXy7Tas4GHLZBquTrE4nfqb22+gB7ss6tp2FVCiuz/jJEjv0G2gL8uu1qjHH
 P761izi8FtPyApR7fzuKKYRgLsKFBR3m1q37gSU/odaeyO9YT6sunO/mvGqP/FiePxunhWgBdBS
 Vs90KBToEhY3XtJkvMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Sat, 14 Mar 2026 18:59:53 +0530, Athira Rajeev wrote:
> H_HTM (Hardware Trace Macro) hypervisor call has capability
> to capture SystemMemory Configuration. This information
> helps to understand the address mapping for the partitions
> in the system.
> 
> Support dumping system memory configuration from Hardware
> Trace Macro (HTM) function via debugfs interface. Under
> debugfs folder "/sys/kernel/debug/powerpc/htmdump", add
> file "htmsystem_mem".
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/htmdump: Add memory configuration dump support to htmdump module
      https://git.kernel.org/powerpc/c/0342545a29bc2edfbe132c68c68b51c92a12444c

cheers

