Return-Path: <linuxppc-dev+bounces-24039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5836C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 03:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxvNL1j6Cz2yH4;
	Sat, 11 Jul 2026 13:30:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783740626;
	cv=none; b=i8tlwbxuBEsWBqUHjarU/j9wSXUqydvq4N7lo7ZKyhMSBexM/xjjIzXde9FrtIVr+Z8tdpT9Nu3yFT4mahStNwXMv9Ad4HUpfF0SW5RgSQzHON6TS5mD1LVGa0pImBkO2PXpNHUnG2yfyn8Gf61B0ICLRIbF05rWgzAGuI7hnLUyKTkkwBBrZ0D/AHir1a3ploWoYZ0OmdbcXtnDAULnBzN/C6KYfhHEATSgV9/TNv9Ww+YLbZ4i8BrxLYIqEb8RcfTXDeUlVZYUjhE5QtaFz/5s3UT5X/GC8k/NO7alhKb5j565KfPEqn9RMN5A1HFpQ81LH+/gw0NLSi4ue9rVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783740626; c=relaxed/relaxed;
	bh=xqCBfEpl/mAyGJ405WEpHV5wVbpJ5wX0tabdzGuhwZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myUbX62fl3AVWG3X3+Do9Zckv+BxGzuFVvkJs/nE94fXU1ysxnDzgoArOemmwYCNmjD5gpy5URzy3OehpJ2jgJUGT31CNWlK55bS95pugHtSgCSn5hyCp+Hu+ltcjnRq7jmEJBirdbJeeWUK/4L9fYHaPqFYISIHjGx0ZxcMZtXIg/PtXwgkfS6o9Z1MAleLvGrqUFvQS9Oaupkz2fhRRMw8RBjQMibCb4N5Z+v9IZzTUroZh9hWioKfZKt6nqtktNJHEd2lJPCsznQkGLOvNdg83saoleXnEg2Kb8anh/1fpISkxaJ2wUN2ahKo1susM38BwlLRhd6kuwCTTHsFSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kGqj0aNh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kGqj0aNh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxvNK1ZKPz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 13:30:24 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66B3IGEJ2701577;
	Sat, 11 Jul 2026 03:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xqCBfEpl/mAyGJ405WEpHV5wVbpJ5wX0tabdzGuhw
	Zs=; b=kGqj0aNhjWh2aJtRwtqZmJcwJzlgq2gBmCHk8fVxKDpUz4jUc/7nCl5dj
	53pXEp0dnzxs973tZ84H+AKnYCZ2BXuG7l8k/6MAHIHNdClJ3EOQtmki4jF1Rjdc
	1BL+Iy6HprljPMQRUbcTALph312u+2j7VPvnmaXBRCh56o9XzGvcVhBZ/yFC4ydz
	igXkPlRZtkEDuHZTbamp6TRqdf6x9245XHK3EpRc6t7l1UFGGc7dnqrtTrL+gywE
	LPDHCRqtv62JqiMzNPyqScvglmWq8V5NZJuDKj8Vt3HAxFRDKa6iliU9LHGUGHvG
	6GxDrD/YOT1C9lfo1lgicPRvl9XfA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbdj58274-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 03:30:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66B34fB1001487;
	Sat, 11 Jul 2026 03:30:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgmsjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 03:30:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66B3UApt36241800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Jul 2026 03:30:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E64F20043;
	Sat, 11 Jul 2026 03:30:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6769A2004B;
	Sat, 11 Jul 2026 03:30:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.249.103])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Jul 2026 03:30:03 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: alexander.deucher@amd.com
Cc: chleroy@kernel.org, alex.hung@amd.com, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] drm/amd/display: Shorten KUnit exported symbol names
Date: Sat, 11 Jul 2026 08:59:56 +0530
Message-ID: <20260711032956.87948-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDAyOSBTYWx0ZWRfX2EnfL07x0eJ+
 RR9UGxvx1ExkzEZvUo9rhtRa4gQwRjjEovnBMYwIOQN6heBpGVKsKf6PVQnGBoQkQPjuAYdOdY7
 tsa/Jgjz6HsrRNnlbCsDaSDwKUrrciE=
X-Proofpoint-ORIG-GUID: KoJ7HB6QAXyF77kB1iiWZTD9rvr05PHm
X-Authority-Analysis: v=2.4 cv=Et7iaycA c=1 sm=1 tr=0 ts=6a51b8c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=r9Pw27tAvqG1vXbKDuMA:9
X-Proofpoint-GUID: KoJ7HB6QAXyF77kB1iiWZTD9rvr05PHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDAyOSBTYWx0ZWRfX2zVl6VlAcUVZ
 V1klAT2bMHVRfRV5Cnc59EjzNn9jiIQdzY1AgFpI2ODtZOUzgD4mWQCt08mv+otL8v0fX7nn1m9
 rWVOdF3DsSMIzy2OETJD8qkSOt85d8zZ3KIkV3t8+n74jq3oHrIpB7u4fzaEB3UdmtTuDyegV28
 3tEkEGtHbZY9JJP4nebijbsqkN/8QafWqqL6L5ZGp6CjYPsZqs50xTpoDo3hpsbp62XjbcV2rxY
 DS4gXjNq8SKtqBypeMbdHAKs094S3vzaW54SmVa2IyGYTTD0BxTz7VcpVlyTu8YUyeXdLZlSDsK
 nwm3pxn7IlMDmW+Y2qdumy7EUcPSIUMZ8iK5HXUdnLTajZCCP2ZcTfzjAI0HKy44ieHKLvC0JAo
 o49xKsd7p4W74E1q63qEH7vEROfpCpbJzYLk6u942jN4PVkwyrAhV6ECVsungcb145XFohRt1qB
 wpvIr0AFNmfCHFlO5Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110029

The KUnit exported helpers

  amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers()
  amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers()

exceed MODULE_NAME_LEN and cause modpost to fail with:

  ERROR: modpost: too long symbol
  "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"

Shorten the helper names while preserving their functionality.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Link: https://lore.kernel.org/all/fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com/
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 12 ++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h  |  4 ++--
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c   |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..b58225338bc4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -328,7 +328,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
 									       const struct amdgpu_framebuffer *afb,
 									       const enum surface_pixel_format format,
 									       const enum dc_rotation_angle rotation,
@@ -378,9 +378,9 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(s
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers);
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
 										const struct amdgpu_framebuffer *afb,
 										const enum surface_pixel_format format,
 										const enum dc_rotation_angle rotation,
@@ -419,7 +419,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers);
+EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
 
 static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
 						  uint64_t **mods,
@@ -927,14 +927,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	}
 
 	if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
+		ret = amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
 										 address);
 		if (ret)
 			return ret;
 	} else if (adev->family >= AMDGPU_FAMILY_AI) {
-		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
+		ret = amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(adev, afb, format,
 										rotation, plane_size,
 										tiling_info, dcc,
 										address);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 911fb2d73e22..55c33e051aee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -92,7 +92,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev,
 int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
 				      const struct dc_plane_cap *plane_cap,
 				      uint32_t *formats, int max_formats);
-int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
 							      const struct amdgpu_framebuffer *afb,
 							      const enum surface_pixel_format format,
 							      const enum dc_rotation_angle rotation,
@@ -100,7 +100,7 @@ int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_devi
 							      struct dc_tiling_info *tiling_info,
 							      struct dc_plane_dcc_param *dcc,
 							      struct dc_plane_address *address);
-int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
 							       const struct amdgpu_framebuffer *afb,
 							       const enum surface_pixel_format format,
 							       const enum dc_rotation_angle rotation,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 46c9af432e37..fc84f5a08596 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -579,7 +579,7 @@ static void dm_test_fill_gfx12_plane_attributes_from_modifiers(struct kunit *tes
 	plane_size.surface_size.height = 1080;
 
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
+			amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
 			adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
 			ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc, &address),
 			0);
@@ -623,7 +623,7 @@ static void dm_test_fill_gfx9_plane_attributes_from_modifiers(struct kunit *test
 	afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
 
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(
+			amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(
 			adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
 			ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc, &address),
 			0);
@@ -1187,9 +1187,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_cursor_position),
 	/* amdgpu_dm_plane_format_mod_supported() */
 	KUNIT_CASE(dm_test_format_mod_supported),
-	/* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
+	/* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
-	/* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
+	/* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
 	/* amdgpu_dm_plane_helper_check_state() */
 	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
-- 
2.45.2


