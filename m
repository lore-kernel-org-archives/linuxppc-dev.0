Return-Path: <linuxppc-dev+bounces-25470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BAFC55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwNz0jbmz2ySW;
	Thu, 06 Aug 2026 15:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785993091;
	cv=none; b=N1pczyvMARQ6e+Tbdw/pADCneoyse4/6kCaJ9qanud4zTxdDEGAyZVUMunEn9fLf60LYAo+RvkBSHqLrsTQlJ4VaIlnRZ+z3LJzR6XMEaK9Dje4edC5cZveE8UPu+3gnYTfPCTrL3MdbTXpAM4WI1b8uhHjznS4lli8egdFyVv1ZO6nJiV4nHm71NxeQp5Pc1HC5LWWy4y2RLTPEohrZT2vm2tQe9X2aHG8hUeL1YXSkyjb6dhEIKor4VwJAAeYqfFi3ZLAY04H825hrqHtjH2wNhKo8R3664vuegRhvX30iqNh7zMYXkxT2GskH5K8DoZT6PMk/E4CBXL8VeIWLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785993091; c=relaxed/relaxed;
	bh=e4+oCqOPnWz/gY4SJ06iQ6vKxeWPaXxbYkuaHmOTGrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le4AcNv7bbx5Fdqp3B/zcZGA5LrGjC33qevaIzkKtaTBKBmWB9aPJno8HZ8VqU7FUXkTAxZHeEvHvfrUM/MI4IGBW1O0X94K0zdOsjIBFNoAkD7Qs2iY3kZHnXVBOmyiqVn+foKzfL8TalA0t77JT53kN/Qkd0Pt3NHJbJh6GD13d4TmnyxlHKj+qceptI6Ia46LnwHzzGBsXILJUjHrl3IbJ5K7PgSwIfOqy+y5xPjnzKrjkppFmhwq0u7/LcSA61nSYi1BOxXm3+ZgHq90aTJqstxs6vSDrR8eA58rto3Sh0zAevRLO2/Ltu5/HXq4+InRXLhlCCWvMqk56zvwmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H1qzEWdo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H1qzEWdo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwNy1xPvz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:11:29 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nm2ou1143827
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=e4+oCqOPnWz/gY4SJ06iQ6vKxeWPaXxbYkuaHmOTG
	rg=; b=H1qzEWdo/HlTUN5GZ0eqsOTD79cMmUZeGdKOeOWQCkcRF3TVjOc7WOTZm
	yVCkbTB3XNyIExz+ARSgipDBdDLHSsBetFQahcAQCeT3LZj1G9C0GdovWTqTuod1
	CEOw/EVBCc2dxe8bF+rcGHzSsRfPVPD7gBmoQkGzCPxFewz08Draj6tBJCO1c15X
	I7Jnhm0yl2x2tRkyU0LGfwTaZVBJ8uD8/RJLyCUSdORA/BemzTCxcop2TyMcIkYs
	7jk3U7GsSN1xjRkpoqBceEz9WqKGnnsHxh2NfPEVTrAd2ceV/Zdt0v9wt4lj+xQD
	kEwZYVSjBTnEmxPurAClbWvNnAr7g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euwvkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 05:11:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765BGNl007303
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbghjcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 05:11:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765BM0g51315168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:11:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37F820043;
	Thu,  6 Aug 2026 05:11:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14A0D20040;
	Thu,  6 Aug 2026 05:11:22 +0000 (GMT)
Received: from jupiter.j9d-in.ibm.com (unknown [9.123.91.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:11:21 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v4 0/4] Base support for Power12
Date: Thu,  6 Aug 2026 10:41:16 +0530
Message-ID: <20260806051120.3703698-1-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cDr9K0GOdJ9i0RU_yAdcBVBxbyxn3AJk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX+G67nn4GS1Qr
 hV7yeT2BpHB0+0cZyxxoNIJ2s5Sbc5NQr9xauJCoIP9+SvcNfgX0uEdQfZIJHAy2jdsyo7cCcvI
 swEYGgH1Rqq/5QJ0joisLNYlj3Z+LCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX5GhTe8VrdNbK
 TBwmp55Vz6xcXsICIefFG9QhSV4bpDhQMBq16RpgSvEZWZtT7xq0vuncUeEZKmTrzSPFArV2hnC
 T1U1XdZ/yJIbfNoHxnA4oCr+attRKxRFDR8yEYHPE/xCzqSxoZveOf6LwOYVxnUJGQjsTXGPdP5
 aE62nzQ7zQbLCevywWMdIyrYpcDzansgUf3+yQFMWmb2SP3pLnTFKqZe2sWU7yrVNzMpcM9JsC4
 w0rLyavs/QMTXK7FqwXGwaVJcs6osfGrPNXAz3T/6MEbg9AqaRdBPx5sDtmVIZhSA7UNNO/Aa7R
 VnxTtJtzmdFNWy40ezs760l2Q+53bNdFD9x0LwmF589iuI5xJinnh5Aul4Xpkn00Uyxe1kJDqHc
 kloO3rHjYLs1Bq1SA5uNgB2hS2JXcSmk0BA1OealnN23CX45CiuwO0Rs8Vi52V7zwzdUaKG6DmP
 +PoY8yYEyTYWe93eHfg==
X-Proofpoint-GUID: cDr9K0GOdJ9i0RU_yAdcBVBxbyxn3AJk
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74177f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3CkFMB8pvBsbaMSk_jkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060033

This series enables Power12 raw and architected mode with Performance
Monitoring support.

Changes in v4:
- Rebase the patch series on powerpc/next
- See v3 at https://lore.kernel.org/linuxppc-dev/20260805110924.3853410-1-mahesh@linux.ibm.com/

Changes in v3
- Rebase patch series on v7.2-rc6
- Remove extra tab in #define to maintain visual alignment.
- Remove unintentional whitespace change.
- See v2 at https://lore.kernel.org/linuxppc-dev/20260803155724.3272052-1-mahesh@linux.ibm.com/

Chnages in v2:
- Fix typo reported by Nikhil
- Define a named macro CAS_MAX_PVR_ENTRIES
- See v1 at https://lore.kernel.org/linuxppc-dev/20260729145405.3230272-1-mahesh@linux.ibm.com/

Athira Rajeev (1):
  powerpc/perf: Add power12 Base Performance Monitoring support

Mahesh Salgaonkar (1):
  powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation

Nicholas Piggin (1):
  powerpc: Add Power12 raw mode

Ritesh Harjani (IBM) (1):
  powerpc: Add Power12 architected mode

 arch/powerpc/include/asm/cpu_setup.h      |   2 +
 arch/powerpc/include/asm/cputable.h       |  17 +-
 arch/powerpc/include/asm/mmu.h            |   1 +
 arch/powerpc/include/asm/prom.h           |   3 +-
 arch/powerpc/include/asm/reg.h            |   5 +-
 arch/powerpc/include/asm/synch.h          |   6 +-
 arch/powerpc/include/uapi/asm/cputable.h  |   2 +
 arch/powerpc/kernel/cpu_setup_power.c     |  43 ++
 arch/powerpc/kernel/cpu_specs_book3s_64.h |  36 ++
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  37 ++
 arch/powerpc/kernel/prom_init.c           |  46 ++-
 arch/powerpc/kernel/setup-common.c        |   1 +
 arch/powerpc/kvm/book3s_hv.c              |   9 +-
 arch/powerpc/mm/book3s64/hash_native.c    |  22 +-
 arch/powerpc/mm/init_64.c                 |   4 +-
 arch/powerpc/perf/Makefile                |   2 +-
 arch/powerpc/perf/core-book3s.c           |   2 +
 arch/powerpc/perf/internal.h              |   1 +
 arch/powerpc/perf/power12-events-list.h   |  78 ++++
 arch/powerpc/perf/power12-pmu.c           | 466 ++++++++++++++++++++++
 20 files changed, 760 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/perf/power12-events-list.h
 create mode 100644 arch/powerpc/perf/power12-pmu.c

-- 
2.55.0


