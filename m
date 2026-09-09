Return-Path: <linuxppc-dev+bounces-27030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49B2C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgdrL0K90z2yb9;
	Thu, 10 Sep 2026 23:32:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788975233;
	cv=none; b=PasNcfowI085cNEMGEyrg5ioYw52RsBSbrmokQk0YKDk/EG/lSjPxRUID6aTXGU+HVkB/4jv7ceSmIcrIZSboeW9Dg/nhw/8JZMhEUJofJoAoXZbsEzzvI2e6KeiGHINnWS44pSL5KXqPfHxYxM9ragym6ojkuLtI/0oWX365LU3U2Ryt+FkY52SZ29LQbFrqAx77nNua3yg33RLGM+4qAJT08jDzPIPGWO/i7C3w3mLDhjrzD1Wor5ZxYqlNiZYjVvvLxXsO8PtKyCSxGtxPqZj9mc33vHOdEoFD8J0G89Lp4xjLkMXvZiKrM+yRh3ROJAEVrGy8RweW1r/+etYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788975233; c=relaxed/relaxed;
	bh=aRf99SMBmtl+VTLk0zBUOwJpiJLfRXga4UGT3MjWHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCYQ8Km7zrzEuFmcZGSPxuwFwXYH19qdFKKCNxhoatLoHmZhmL58SpQ97Uhj5lyFfa6fJu1Poaa+5yTkKXvRWmI9Z35eXcJR31lSrFhmC2L4N3j/FNn6b79uXCYcgCywJKjLK3GT4PfhBFjyGec22saxmqiRkYf6ERvyxwPuYlp2U5We6A/cFdyvHk5AMVQj+iVEctSZ5zdAdbQn5WFCLDyWFYAgMt0Jj1gAnt4d3ZbkQuMnzOqrVQICLdw9Dg/bEeq7YtK4dA5gl+mX1wN1f4jwMkd7g4Kb/aV5E7qZIx0SUogpxUK1bgZDKFjM3GYoUFfidrMrwzw6Vz4YLJUlTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ugi9W9LX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com; envelope-from=2000jedi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ugi9W9LX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com; envelope-from=2000jedi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg7Fr2Tdsz2ywh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 03:33:51 +1000 (AEST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-6b1c75f0049so4594337eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975229; x=1789580029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aRf99SMBmtl+VTLk0zBUOwJpiJLfRXga4UGT3MjWHTQ=;
        b=Ugi9W9LXLRaAzYukBspxNYnkWCa60l3yuts3x8k7PE34pHVb+xJLHYL+R5Op68tjXi
         B6bIKao+8l+13yhF0DegzpCInPZ5s96UcRnwvy7BZv9vt7G/W4S/frt7cv4GWZGtC5+c
         v3plXy1+BgVR3zar/4td/BDDdW0+owcsqcQkD6D6eoW/tI+u7DmBWFPxS99U2cFlq/p9
         MNITlkQOWjgsOHxSzdMAr+PVbRmzvGXhl2DLB6emvUonveE/fei99YJ/BYLK1JhKbN69
         91EaocxDOXzXsmR4FpXTf9jzZmp+sBtlJjtS4zjcTjDiI5G6pwDxomTYYR4mWriV4FcX
         YRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975229; x=1789580029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRf99SMBmtl+VTLk0zBUOwJpiJLfRXga4UGT3MjWHTQ=;
        b=agZ2FZfhXini2dp0Duy40L/yupWkKjhtZlAXd9DEaNcvFQqDeduSL5FVyaD1VKgUzr
         q//WdafByzVhBBOc7pRNhvY48vg7+4ufc7TUsVf1lWkgy3sq7R3Hcfasy9nWCrqwfIC9
         R2op+xKgaZ1+ks7+kqx0f9X/ukIz/rxGbVUwefhQJocW9UyJ/Z1h3J7Ue3LqPbmV1NME
         cP8psGC3m4Bo9muL9OF+ZW3CecgqSkaNiRK/BeqHABftaZ4k/CGwIuJdFWxxp/B7zqzi
         cS/L+loGAwD27w+3n6S6XrYKQC/fn9MIDTiAD1sW+dKLhVEybOKnjx4G+o61P5cSohBm
         NqKA==
X-Forwarded-Encrypted: i=1; AKwUvBzpc64HmJhRYpHGzcWQKQ2FuLAnHHLl2e6Y4iwsnU0mGlZP71RBLzrXDakyh6BAR39SN8SpCtx495UqzgQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mP2qT2Se0Ia6f4hanj54lal3DQriC8iem8cjpKAJpsNKJHbSOC
	vyfjNphwnmErYu6t03FImH/nDVhRQ2RIwlMT+Hi/fCYP90iLIn47snSe
X-Gm-Gg: AYBFou1xVjNdKGZur+hWzO2TcMH9X/r1UugZ4AAaOo/H1PS0+knUQXjzGBuOFXBAZKt
	5i5rK4jYqTjlh0Z5IOMKRhMl4T1m9J21pEJXziMKEhazO0/gKfr/JczZRDihK+3w4FBXaoYsoyB
	1mK6hszxga2A6gq5su81S5dMqk3W7Q8391U0zEcC1zwZhsUdr5afX2EXf6uZP92dvrWzsocxjnW
	PIivzc5Iq2Gj8ZYdyxk8yvL2nkd1VL6ZWNSnIyKQkbAGISfIklkYA/MgAEiNYASMDZklWSa/FGU
	ioQJoWY19FZwzqbWf6oyEyBS4WneGS1rdBxUdewgNZmjpqQu87bA8CDan9Uvlxkg5Be9gYQMk9o
	V3Gz5mPiaFJZJ/2apWNKe2jHTcKlsbXHok8ZHKvpCr8FURAahdYxRJbWPRQqx1I4U/4JoPL6dIu
	z784bDjPqnKV2w2iyLoVlJ05X9yOSPVi7FTC9u7e71Mz5DMyxB+PcD6XUwfZVqjG+VPbQ9Z2YR1
	u5N1SDh1555qaoCgfzWc0btJlbFsbfLQHq4QCq7APjRftO9Wi/4gngPYlTKQggDqV8=
X-Received: by 2002:a05:6820:1888:b0:6b7:46fc:1cb with SMTP id 006d021491bc7-6b746fc0236mr17849545eaf.42.1788975228770;
        Wed, 09 Sep 2026 10:33:48 -0700 (PDT)
Received: from memorizer.fox-kitefin.ts.net (47-163-111-11.bng01.bytw.tx.frontiernet.net. [47.163.111.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bac11fc29bsm10396408eaf.6.2026.09.09.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:33:47 -0700 (PDT)
From: Yudi Yang <2000jedi@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Michael Bringmann <mwb@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yudi Yang <2000jedi@gmail.com>
Subject: [PATCH] PCI: rpaphp: Fix stack overflows when constructing DRC names
Date: Wed,  9 Sep 2026 12:33:00 -0500
Message-ID: <20260909173300.1144301-1-2000jedi@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The drc-name-prefix field of ibm,drc-info is supplied by firmware and
is not limited to fit within MAX_DRC_NAME_LEN. Using sprintf() to append
a suffix can therefore overflow the stack buffers used for DRC names.
Use snprintf() and reject names that would be truncated.

Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
Cc: stable@vger.kernel.org
Signed-off-by: Yudi Yang <2000jedi@gmail.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 2316de0fd198..39109a50fee6 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -252,8 +252,11 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 		/* Found it */
 		if (my_index >= drc.drc_index_start && my_index <= drc.last_drc_index) {
 			int index = my_index - drc.drc_index_start;
-			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-				drc.drc_name_suffix_start + index);
+
+			if (snprintf(cell_drc_name, sizeof(cell_drc_name), "%s%u",
+				     drc.drc_name_prefix,
+				     drc.drc_name_suffix_start + index) >= sizeof(cell_drc_name))
+				return -EINVAL;
 			break;
 		}
 	}
@@ -355,7 +358,9 @@ static int rpaphp_drc_info_add_slot(struct device_node *dn)
 	if (!is_php_type(drc.drc_type))
 		return 0;
 
-	sprintf(drc_name, "%s%d", drc.drc_name_prefix, drc.drc_name_suffix_start);
+	if (snprintf(drc_name, sizeof(drc_name), "%s%u", drc.drc_name_prefix,
+		     drc.drc_name_suffix_start) >= sizeof(drc_name))
+		return -EINVAL;
 
 	slot = alloc_slot_struct(dn, drc.drc_index_start, drc_name, drc.drc_power_domain);
 	if (!slot)
-- 
2.43.0


