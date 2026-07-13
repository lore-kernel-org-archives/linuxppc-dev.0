Return-Path: <linuxppc-dev+bounces-24089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8Xj3TyKz306N;
	Mon, 13 Jul 2026 14:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783916821;
	cv=none; b=S9dbTXwvLl9/DHazL+Tf4Hz20OhWOxMqeKO0H2zHiRz9iuHeJWPDTEV998W8hRVuw13Eptk/kcq/Ud+KrDIaJZE7YWVY3eEGJ5y1+3u8FlbzWbnETgsNcgYprF6icLXwh62lq4RN5kxU0OAfIKh+i44bgXBPkQp5vmNn0bIg/OHakIFBabZuRga1qJextfTtxBkVZ7RlI/CmbHuxigNKCTi1TA5URVXPj8uSUAYCctyX6iiU0dDx1OoepvLE25uj9g9rD1Bjz0oRgjxgreCcAoJyyQtMMYTgHyzNaRhGAHmcT6UdAIItbLr0c17qWldaGBIf9zCyli645Cl7TUuOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783916821; c=relaxed/relaxed;
	bh=FdHF/ctIvE3/lXMIpISD9S6ekvIavno5it07UQBMiW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJu40RWXE3NJ12ei+LsfszGfuE+aqYc+/J/ok6F4MI9HGmm4/gns8EdU7h+DyUMryedvTvW3tXZXVfa4heRHHcQ1VkoM6zPugA405ntQPOgQy8BbwYnf1zR4y+8Q0oE3oKQfw5OZp7aeBeZPs843DGFSvxmPdp5ieK0QaGelS42CV38HZvZrCYU8xhgWv5CIygwwSEgvopDVpdsNPfWGJVrL6hJnpwqrmuRQMXUOWyzWX0hadEioK1PtjhnULvXPqtLl2cH1Br3sjuEE2cIRSttIMvKVzlf5KjkjM4ThtV8rTCTrTkyIZgskml+VuBjBSn+847M2QObyHhV94xoHwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mAvDuPoL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mAvDuPoL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8Xh6YvBz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:27:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3CdtI1285027;
	Mon, 13 Jul 2026 04:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FdHF/ctIvE3/lXMIp
	ISD9S6ekvIavno5it07UQBMiW8=; b=mAvDuPoL5d45nuhFAS0+rToPW/C6htyi/
	4DuwfljcqWqgOm5KlVovl9Sl5KdmmMSThWes/+NDfUfNgPUsLEntMpQibvXl6KdC
	kgy+QaJEaZ10B0ALnwD7AHkOlKOIsSabwTfP54feAYt7y605oEm1rX0KV+aYLgRp
	YdOpj/MaXgGVagOjLR7KWOtRDrhwlnEeLDVTrSZxdO1UAB5CflEViB+jFI7lk/zV
	jR94jCrfp2hTfIqt/a9r1hHFRt3woIwujzKVYFGzK8kpsYVjZJSSO2KZvJsrGJmT
	9y/1OEPgmXal/kETuLH2aKv3yxeCfiUEnOmj76NahH/sIXZP5jtqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86ks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4K1rp027238;
	Mon, 13 Jul 2026 04:26:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pv6x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4Qmhw45744508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:26:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E20022004B;
	Mon, 13 Jul 2026 04:26:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D009F20040;
	Mon, 13 Jul 2026 04:26:44 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:26:44 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc/fadump: remove old sysfs symlink
Date: Mon, 13 Jul 2026 09:56:34 +0530
Message-ID: <20260713042636.1599868-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713042636.1599868-1-sourabhjain@linux.ibm.com>
References: <20260713042636.1599868-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX+HxcJpF93EI9
 kHbBZaYxfSmylvXcNWeJSiOPuUa2lIihTS1Uqdr2bZAzewZ4kIS6jGu8772+3au/cS0zX94n5cS
 VaDcel1NkXhprP8dGOF61bBHvYJ+oeVK44ImNHL895YhvcnKHq2aZKJNlWZCjYnJQDPe59TQ+7I
 vxPGLvG0hIto4Bl1MxZi0Go8jYTdTp20eluh3s8tYdlj3sVR/jizSSPDN3A2ohno9m9aNb8fgbQ
 mq1Kf4WovaKDwPGbZXuifMpAU0+1Q28mAfOOghePpGRGMqzcuRfy0V7K1qMfLiYp8DX30O4DMli
 WjD/nwCnEj4I0NJnPS8xr2wCJhIpL+PIlCWn4ANtt0SfjL3qAxygiUMX3PjakKBLBXZbIdrZ7c/
 vJXkPvbU4d+aXWNH8V1FgLL9JGA6J0c+asAzFCf3tNWF90cEaepSILV/ZhjbF62xomLDlbz4j3D
 SLjsWgavoZAzvsCU6Pw==
X-Proofpoint-ORIG-GUID: J6FmZc0BWoJlozgc2elH6oQgnS3O9G89
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX7uS0ZC6NS94X
 E8HqJZPKRTuRiJw3ARApv5qej/XF3Ev5/6CGIOel/uygty5FSELfwcmsAidKv2kXcX/LM8TqQjt
 rDrdTILey9p7X+QTwRJMwPeMkO0gLUo=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a54690d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=6mKYDruanZIfvi_TY5EA:9
X-Proofpoint-GUID: JezAMxaJhc0ZuVP5tB54HozZbRSKFhFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130039

Commit d418b19f34ed ("powerpc/fadump: Reorganize /sys/kernel/fadump_*
sysfs files") and commit 3f5f1f22ef10 ("Documentation/ABI: Mark
/sys/kernel/fadump_* sysfs files deprecated") moved the
/sys/kernel/fadump_* sysfs files to /sys/kernel/fadump/ and deprecated
the old files in 2019.

To maintain backward compatibility, symlinks were added at the old
locations so existing tools could still work. References [1][2] now use
the new sysfs interface, so we can safely remove the old symlinks.

Link: https://github.com/rhkdump/kdump-utils/commit/fc7c65312a5bef115ce40818bf43ddd3b01b8958 [1]
Link: https://github.com/openSUSE/kdump/commit/c274a22ff5f326c8afaa7bba60bd1b86abfc4fab [2]

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 7f79c9aea4a9..7a23b7e7d643 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1592,43 +1592,7 @@ static void __init fadump_init_files(void)
 		pr_err("sysfs group creation failed (%d), unregistering FADump",
 		       rc);
 		unregister_fadump();
-		return;
-	}
-
-	/*
-	 * The FADump sysfs are moved from kernel_kobj to fadump_kobj need to
-	 * create symlink at old location to maintain backward compatibility.
-	 *
-	 *      - fadump_enabled -> fadump/enabled
-	 *      - fadump_registered -> fadump/registered
-	 *      - fadump_release_mem -> fadump/release_mem
-	 */
-	rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, fadump_kobj,
-						  "enabled", "fadump_enabled");
-	if (rc) {
-		pr_err("unable to create fadump_enabled symlink (%d)", rc);
-		return;
-	}
-
-	rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, fadump_kobj,
-						  "registered",
-						  "fadump_registered");
-	if (rc) {
-		pr_err("unable to create fadump_registered symlink (%d)", rc);
-		sysfs_remove_link(kernel_kobj, "fadump_enabled");
-		return;
 	}
-
-	if (fw_dump.dump_active) {
-		rc = compat_only_sysfs_link_entry_to_kobj(kernel_kobj,
-							  fadump_kobj,
-							  "release_mem",
-							  "fadump_release_mem");
-		if (rc)
-			pr_err("unable to create fadump_release_mem symlink (%d)",
-			       rc);
-	}
-	return;
 }
 
 static int __init fadump_setup_elfcorehdr_buf(void)
-- 
2.52.0


