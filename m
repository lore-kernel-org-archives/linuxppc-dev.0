Return-Path: <linuxppc-dev+bounces-28314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC1C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6R76Dsbz30Vr;
	Mon, 28 Sep 2026 00:34:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519699;
	cv=none; b=iaisWZrPMr5UzzcwAyY8QhdtZoDFYEaJ/ZN4q5tJNxodWGqhowcVthUDeJ033ZZQZIL+8JAsoqRez8RcA+fK9UQB+9WPYBW5SrFaP5zihdCggVOGKMtsGRheUZLAdJ8B/CcKAhLUoQbN2Dq/x3p6SRJGJM+qDlKxas02OJA1ONaBVryffXko3Z0LKkiqFbBJYOsEIxjYHxM416SXKlLhD3CW8NGNO2Q3jyFFd3MhcPXIfUZB+EIQgIbMoFEsIcgIe7lUEFxCD8lacVk0kicIMfJv6n6vyHLvmQN5TWrVCj1rUeD1EfhTnse1x+S/XyzklsxML+u4EAETKNiFWXyUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519699; c=relaxed/relaxed;
	bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ab/ACtmzHvRpTaRsodSGhwuisZ3b1UNu8UNcizyhsSOUd34oZjTTFP2vzUfbv6/bbncNXdNNqcPczqZ7UunrBvxtrAFWv7lZ+nQeHuKdU/YaiFFZ0Iq9SR65iaTZPiB+Q+MdUaVUwdyYBYPy+IrzwEFN+nhAltdU4AJEjdKcRuMPOXNxQUY6rFEiUxawPtpmo43Huf4E/su46UG7xVIsQSoEyL5ekunl9R2MG9yM6TkjLfhaR0+eMict0n1PcovQlirO0VJAWstGj+QGIpDA0KgsKHP880gDRUuonIWqJdIGreq6OkSv2rMY94ccPQLTevtVddrpIHGBhMBYMHa7Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tov3RFbE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tov3RFbE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com [IPv6:2607:f8b0:4864:36::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6R70YQtz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:58 +1000 (AEST)
Received: by mail-dy2-x0d.google.com with SMTP id 5a478bee46e88-3468ec308beso197417eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519696; x=1791124496; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=Tov3RFbEO6nLb9P+zNT4TpGsYdIqNqZFzLNvWS/BUhgFEnX2QJlk9sU+y84Yi66lKa
         4tiI1+rbyBmAV7NQs5tch1X0zFgPEr0w3EhEq4BHVFP5/aOvH/HCUN4Jmi2InJN2mvIo
         FpG/+dCwrWzPmPTJlNPSBqPQ0vKfntstTXZGhUNV0Zclhp0jlC21RcCsoJN74Aal1V/r
         CSMc+IJI2EiKsBHbKeOKcmq/RRTJqMuMRuno+3vr+LR88McVnuaBQrT/g407Tx2F2+Qn
         Gfsx8nA/aPSqdxa8Wvtusp8syRyPaaNJeYaM9H3AZsQu2iOj9Dj5F5CvpSkwmNhuQWGt
         5oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519696; x=1791124496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=tvlwdAmTZXv5NneKJlLELeFiX9tCAtSwbjmWZOiS57HLLSNPPoucaZZVku4Ld5Zmcy
         0ipO2iefvJAA9VtM+DnP0a5VOk3YUXFHJe0feNJwZRviMks70xG00IfvdY1wCz9v8LAZ
         c/jZAwo9xzQHm2o7cbnSWn0Ud4fCRXlM4SfjkIgrF4vvx5w7/GNAs5johj+oS43tOufH
         Y1OsIFWompEFow2E0kg0vOKhSsNPbzwNW+8CzuvJgCmrG6Q2p+DInl3WK3+0tzUTtyYX
         xKP6dsPf6dFwOgjkSFL4go2U8GV3oTwa4a0s+D2vAf9i2w13O8sbVORnZNi9hDq8wHnS
         cQnQ==
X-Gm-Message-State: AFq9FYJ2dQc8K32DEah1NYPPoFNgMVl+GqA1rBo9hZSYSP3tM8Oqvr7r
	d3Sb1ZvoUE6fgvIfsiKmETa0hS+3tji43LInwrV1zueJxOeAgfPFN6hybZLrIw==
X-Gm-Gg: AYBFou3jTStT5KTHFSHHsPzm7GSvOgp95ocTKMOEFGAUK5+DATrKnATRmLYNn2A4u40
	K6HTc0Bo4VcaVo6WiTOChYmAyX34QLjIdSa6SEkIecoakRtKXBZ6Zc7oCCwqC0JiMA8N4j8Ku6B
	4+OO+Zura6aJbWiAQjLHtqzRxRrbi6SkEnsDdXCHKCGvAT4XJhtdslPNU0FVklI4Fu9dLhYu2aQ
	cNs4gCO8BwyZcI6tiwJZ947v6r/wrYehXYBkBZd5lALMMwO0jXIwlFWNedRWHOke7TRUVKbH/0s
	BD7b9JV1hcfiaxTWZSnN4uPnSHyCRE2044wmJS6FUKD/nsdbUekCTVwGGWUoLetOYjg8rTZJuf6
	vxr3R30mQmQktGxS0PEx9Drg4os8sJOLAA0jAOeMVV2BJluDhE+bzgbrXfPzskXW2amDSkGZjYm
	3f2tvV1SfKiXRXOcsxu3mSj+s6qWYQ/W3m4qJ/iC4jchEXI6pOTg350owdkLHuiU/z/5z5cJx9t
	2k/w2fohIVOZYyFMDqgmKNOtUY6obmorVD37NRU+07ZwgTB9OrpW0gYCQWS
X-Received: by 2002:a05:7300:ec96:b0:33b:d4c9:561f with SMTP id 5a478bee46e88-3426fcc99c8mr5705585eec.5.1790519696270;
        Sun, 27 Sep 2026 07:34:56 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 05/12] powerpc/pseries: Annotate the VPD sequence lock context
Date: Sun, 27 Sep 2026 20:03:46 +0530
Message-Id: <d8908c2991181b75c20dfd8e23a58e7779bc7dee.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  papr-vpd.c:151:1: error: mutex 'rtas_ibm_get_vpd_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-vpd.c:165:2: error: releasing mutex 'rtas_ibm_get_vpd_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to in vpd_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-vpd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index f38c188fc4a1..8d210454cff1 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -123,8 +123,10 @@ static int rtas_ibm_get_vpd(struct rtas_ibm_get_vpd_params *params)
  * @seq: vpd call parameters from sequence struct
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_get_vpd_lock held. vpd_sequence_end() releases it.
  */
 static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 	/*
@@ -157,6 +159,7 @@ static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by vpd_sequence_begin().
  */
 static void vpd_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 
-- 
2.39.5


