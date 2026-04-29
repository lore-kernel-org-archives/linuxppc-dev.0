Return-Path: <linuxppc-dev+bounces-20281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C04FFF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:27:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Glh72Fzz2ySf;
	Wed, 29 Apr 2026 22:27:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465648;
	cv=none; b=bM2r0NwCxUfiSbeI/derza8W6xcZL+pwZre7C65+aUkPuZ+H+U0erssCDG0l+4GWOBkfoYntpVncvXFHWIgHvS540oUCp72O+MaJ7+DJ9SjXIbS4ZFq7BHrElonZzAHRH4RH1SuaPGyhKEYUneclA7AIlmRUjHCQeaEI0qs5x7JQFLZcm4OOELUjeQooGbrTA+XhD46WD7VZ2M+ObNBYVzl7e+ajJf7dZ2+qu+R7tBt+lhuqoYOiMcCZD4SsZyWL5ifyrYEUJNc/OpW7zSZWPcjK6OrEi11afVLbF+S/zjqjWtEF/kifYJYM+yR5rpOjnRMlUKzHUaQqxeES6UYCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465648; c=relaxed/relaxed;
	bh=hySTdbv4km3hxPKl5G4LByk6HgkUM8thYPdMgG32wUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmnYwMXvycoNmeRbbsynRHZpV4sZtxF8P+lEaV/km2tPmrKgvA+Dbj5KJjNcqGRNv3HpuQ9esR7xn7s9C43RXZRrgydbs831pjocoCJ9TfqCEdT9oqg0s6oC9X1wBxmRwp7lbNZlZuS4eW5mScyLbp9BvzqNuR6+qJO4EgAikVrZGy/Xqcg/SGPdQZ2/Y7jNRRFFL/w+oYBh+VM26XEN89iLMTv+xFseSljLGqq6WjPOEi+GBQ7TIzcTMaj7HUecAgKyzILMkRL6lyk8kGCoUXsxtgMdrCHJ+Vkowy7NnqZXzPbWyolpfWY8csdArGrGviiatoM0C96r05MFJyIttA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HF5EEm2c; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HF5EEm2c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Glg2K3xz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:27:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465648; x=1809001648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VXJ5q9tWKaV2T92TCmAxPMeclranQN4ydQ0uXeo4AY=;
  b=HF5EEm2c0XyfT459TWnIkkqlkASb+utf2jA6xy85sJh0S8SZEF0on7Vq
   gVLnRFkrZ4ZMycL69eSkLhJSi/jac5hEs0WS7TAY4W8WZdL5R6z09Wu96
   7cRKrKGFCPLa5TF8uvkUR5rgSO3UXh7JB0dYXQ9eaOj37hznIxFJ9EmmF
   YWpDfJ7xR+W2NB2fZAtP0MvHtVlkVTZndzmP4T4JmPHaup3bx+WeBvMZS
   7fva9hyJV/cOf2PMrJFjmKjB5OGnU3fGJvnakfsJEglXb0M9TWp4UhtP0
   /6PI8U+5mDc6WXipz3WBLraOhw9EtAV51Zj2WlK94WySKeTHdQ4fEF1Ia
   g==;
X-CSE-ConnectionGUID: RXmB/SMZSKaa1h1cZWdosQ==
X-CSE-MsgGUID: nFxudI/bTI+sxSjAr4ldjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101805"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101805"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:24 -0700
X-CSE-ConnectionGUID: Jgvu4VG+RDuYkRSRGmchNQ==
X-CSE-MsgGUID: ccCDbeE2TSqj2vquDJN+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512170"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/11] resource: Make resource_alignment() input const resource
Date: Wed, 29 Apr 2026 15:26:11 +0300
Message-Id: <20260429122617.7324-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

resource_alignment() does not need to change resource so it can be
made const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 2 +-
 kernel/resource.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 3c73c9c0d4f7..f7930b3dfd0a 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -261,7 +261,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
-resource_size_t resource_alignment(struct resource *res);
+resource_size_t resource_alignment(const struct resource *res);
 
 /**
  * resource_set_size - Calculate resource end address from size and start
diff --git a/kernel/resource.c b/kernel/resource.c
index d02a53fb95d8..3d17e3196a3e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1238,7 +1238,7 @@ reserve_region_with_split(struct resource *root, resource_size_t start,
  *
  * Returns alignment on success, 0 (invalid alignment) on failure.
  */
-resource_size_t resource_alignment(struct resource *res)
+resource_size_t resource_alignment(const struct resource *res)
 {
 	switch (res->flags & (IORESOURCE_SIZEALIGN | IORESOURCE_STARTALIGN)) {
 	case IORESOURCE_SIZEALIGN:
-- 
2.39.5


