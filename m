Return-Path: <linuxppc-dev+bounces-20276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE0FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:26:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Gkk1BvBz2yVL;
	Wed, 29 Apr 2026 22:26:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465598;
	cv=none; b=f+ysgLYWmwNPxuO9OCYxRy6RX1azvtBx3VSrtlE2zt+ybcJCkvHOmYtkL30IhF2uk7FgPsNnYHEWMLjhtF4st5COCHZkWFp98WHppD9IUpihMJy0Ulo6rv9c7apQGXSeDPBHq9bsQ4F9Ik3M/ARVFM9ZcQ+jxrvNd4hqBx2OnVECk3h8zjvNLkmZ0DFn9XPa08D8WNGpuzw6TR80RgsD0kbRtdF02phs+sWfu0dp6XFx8QSZ2i7n3M573gMgUU8MvpBvxnUA+mF3QelcAY7jusNCDHIlGF5qDjDbw4tQJ6tj+wRbnDy2DXaTgh+BEKCN5ZLIKAOVzmyOD99KJUurvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465598; c=relaxed/relaxed;
	bh=blSVM7WjU1kRlDj3TK9DsSHo6TzO87ZSZqqbWB5NS9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aOqrYzXWXmPIBQHuYOXciHdT+e4xm8vLmPn/8yB1XUmi9mndGnsrfAS+TU5OdWIbW7SJATK1Bc6EzCle/CoCV56pM6a97gX7nXSWFeJyvxHfCmGs56+YoyJywyalHbBWJ7zjBYlGe3cZMF7Dnv/o2KdVumgnsr2TDaXH3atGb4NIqxkhYp5f9+xMgFaGLNpDCUm1NwBVQxd4diA3G/S9gtD3CuYWalCP5CF2mZ54pVP2j9CZtssD1B/msjbw3wsrxRbvwfQRsX+ax+EW3nuwKWAnA5K37DdM/J1pFVSkXd4bzUXvwBlBy/JcfdM4gINGyu3XR9QuQJBsMVGponzU5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ffDzJNUX; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ffDzJNUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Gkg0Zgtz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:26:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465595; x=1809001595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=StUIvDAZe7jSwmt+KbusiTw3cp/VUh8LhDiUJd1ZEnM=;
  b=ffDzJNUXi4Jr+UuhOsZEXR6lFprxd2ZG/FNcOY13E+68VPUmf/2rUUD+
   YuMeOnUtQUpuOZ0c3s6cVBXmNu/LbTFeSWcNcZXe6M1J201t5jtw9G4y6
   mUdbpSUnlW+Rs2q9NpLPWZ+GLohw64GHtLFkS2X4a9glh17zH22de86Cp
   mdEBxuWwqNP10+M917eHKZzf2K2BDqSW0JB2IgjT2Oeo10r8sUHxuqOXA
   Aul0Nkgnx/r2EouBNptYD9nrbG+oxP3jjLU9RsX8TbIkO1zCkXaQimnni
   Y2ezrc9quzQNMkVcFrWGete5o1qZloOfFKmUhjcERn17av26pa8G14vPj
   Q==;
X-CSE-ConnectionGUID: 4T1jU3C2QgKjOOdeu2qnNg==
X-CSE-MsgGUID: XplUtCQFTa6Cl15KsG3NpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557647"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557647"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:28 -0700
X-CSE-ConnectionGUID: e2ynKkGnQ/mCfV7EGabTDQ==
X-CSE-MsgGUID: UMOQ/jvuTpGe6w8nQEajNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669615"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/11] PCI: pci_resource_alignment() improvement + cleanups
Date: Wed, 29 Apr 2026 15:26:06 +0300
Message-Id: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
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

pci_resource_alignment() returns 0 when resource is already assigned
and in case of disabled bridge windows. This has caused problems to
calculations relying on pci_resource_alignment():

https://lore.kernel.org/linux-pci/LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM/

This series reworks pci_resource_alignment() interface to return always
non-zero alignment if the resource exists. For assigned bridge windows,
the calculation is using heuristic based on size and start address
alignment as calculating the alignment again is costly (would require
sizing the entire sub-hierarchy).

As pci_resource_alignment() is becoming more complicated, it's also
moved to setup-res.c. While moving pci_resource_alignment()'s arguments
are converted into const to tell compiler it can rely on resource
remaining the same across the call.

This was intended to be part of a larger series that addresses some
shortcomings in pci=realloc. The pci=realloc changes will recalculate
bridge window sizes considering also assigned resources which required
making these changes to pci_resource_alignment().

As this also relates to the issue linked above, I'm sending it already
now without pci=realloc changes that are still incomplete. The first
patches originate from the large pci=realloc work but seem generally
useful even if independent of the alignment improvements so I've
included them here without reorganizing the series to contain only
alignment related changes.

Ilpo Järvinen (11):
  PCI: Log all resource claims
  PCI: Rename added to add_list
  PCI: Consolidate add_list (aka realloc_head) empty sanity checks
  PCI: Remove const removal cast
  resource: Make resource_alignment() input const resource
  powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get()
    pci_dev const
  PCI: Make pci_sriov_resource_alignment() pci_dev const
  PCI: Convert pci_resource_alignment() input parameters to const
  PCI: Move pci_resource_alignment() to setup-res.c file
  PCI: Lower bound bridge windown alignment
  PCI: Return valid alignment for assigned resources

 arch/powerpc/include/asm/machdep.h         |  2 +-
 arch/powerpc/kernel/pci-common.c           |  2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c |  4 +-
 arch/powerpc/platforms/powernv/pci.h       |  5 ++-
 arch/powerpc/platforms/pseries/setup.c     |  5 ++-
 drivers/pci/iov.c                          |  7 +--
 drivers/pci/pci.h                          | 24 ++++-------
 drivers/pci/setup-bus.c                    | 50 ++++++++++++----------
 drivers/pci/setup-cardbus.c                |  2 +-
 drivers/pci/setup-res.c                    | 37 ++++++++++++++++
 include/linux/ioport.h                     |  2 +-
 include/linux/pci.h                        |  8 ++--
 kernel/resource.c                          |  2 +-
 13 files changed, 94 insertions(+), 56 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.39.5


