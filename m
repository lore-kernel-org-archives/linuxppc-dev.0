Return-Path: <linuxppc-dev+bounces-28211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A2C98328
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:26:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzfh5gXPz2yNH;
	Sat, 26 Sep 2026 04:26:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790360764;
	cv=none; b=iS8xI68XjJGO2pRQpgesYlspkCLBocP7fX+TxNzcffyD9uE1RkFHtozUVdqSPi1IA7ipEPJRqXkdeWOkXSwsMcFmhU/EcQvzEiQg6UbhIe7djYo0R0RL1Dve/t+Oq0rknIovBf8Jh8X+x0I0YnYcLHUrxqSIhV8c1zj+pXWHZ2sy17SWsWIrjkGPP9CyowS+Kum5cfUkPKmDZhKLnn1vIHCKV/NZTeOOthXXJVEMU318lHhAVfkCjo8uIgx2mGHu050+beATyEurgVq3jolhIoPvmY0ylWJBbff4nvBM1T4ZzQTL8qGyBjcvKQwAdJQUkLuUiOJbaUAbnQ9z6M22cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790360764; c=relaxed/relaxed;
	bh=P/nOfrXY7ig6ifFinS5KxkTiEptLwWs4qGfCLMELEQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LINNRZL7hnktmq8x8SlGwT3DU346ThLwdg1z6QN5cfCMbcAmSi8eETaOLuJ519FAU2M7WulXZ+DMAA9wk9O7WP1mp9y0h5cct9E2qV3V4wJvKv8PhryTMZ1vHBZ2v7xYNx2rdWCMhSWorTF0bew994LuZWNgnARuZhWTH4QwPf3MJssIO4lI4/eaoZRnTWEpc/pGe4LvqFvLb7EapL9AIbWjU7M8+Fq7dZ03/49xU2qIyLfN2O2J02OlcPTI+kV9UjGx/CExFEnYCULeDNXk1KGVIpVNZGkpcPEL9a9UXoYkO3t900xgPMcUFBvOBTLlXP/LWrOF3r6hXPoyMTCQ7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jD9ax1Ie; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jD9ax1Ie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Sat, 26 Sep 2026 04:26:01 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzfd6F4dz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:26:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790360763; x=1821896763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QkfjOc0sQlINp0dlL4tsqbRzARDUfMnXVuM6+kbNa+M=;
  b=jD9ax1IeB/NYKvx4jxDcTNZBlp5sFNAJP6+AIXfmqx1rVwsVOh/Feg9G
   gXhVY/MpaHdBvx6gjKIKHFFrldUGN4QF70CZF41vjToR+LJlC1TnEHCo2
   Ey8gW5LA3+MLSzwjj0tfn6LzcHJA/u3PKbYxHv0W2PeYWvEHic1QsQ8t8
   PgBuPfkWjH04dCAxesXGP9InoXEo/m2Ty83M5SQ99BkdZaVD5W96dA6Ij
   S/tT+27klyKdOt7g+ZR5VNe5Gc0GVHERFgIiZkNpf9a2rqZ55eUXc3ATt
   IvHy8j1Mg+U/l1J4pcFbr+ZoRf940uAL4Hoj1wkIh5dNW2i7DRG5hBgl5
   Q==;
X-CSE-ConnectionGUID: Ubi72zAwSCWYIizdfb1g3Q==
X-CSE-MsgGUID: rkyiV/FoRj+1oapRoFGjXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90370722"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90370722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:24:54 -0700
X-CSE-ConnectionGUID: CbPUjuojTVKmcaWccXdU9w==
X-CSE-MsgGUID: MHDen00fS6+3za6IRsAvZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272205388"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:24:54 -0700
Message-ID: <4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linux.intel.com>
Date: Fri, 25 Sep 2026 11:24:53 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
To: Priyank Rathod <rathodpriyank@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/18/2026 10:24 AM, Priyank Rathod wrote:
> When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
> APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
> ghes_estatus_pool to store the aer_capability_regs registers before
> enqueuing the error record into aer_recover_ring.
> 
> aer_recover_queue() returns void, so ghes_handle_aer() cannot release that
> buffer itself; ownership is handed to the AER code, which until now freed
> it only on the fully successful path. If the record cannot be enqueued, or
> if a dequeued record cannot be mapped to a pci_dev, the allocation is
> silently leaked. Under a sustained error storm this exhausts
> ghes_estatus_pool, which then breaks GHES hardware error reporting
> system-wide.
> 
> This series fixes both leak paths:
> 
> Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
>          aer_recover_ring (capacity 16) is full. The rejected entry is
>          freed immediately via ghes_estatus_pool_region_free().
> 
> Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
>          an active PCI device (pdev is NULL). The loop is restructured so
>          ghes_estatus_pool_region_free() runs unconditionally for every
>          dequeued item.
> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---

I'm fine with the current approach. aer_recover_work_func() already
owns and frees the buffer, so freeing it on the enqueue failure path
keeps the ownership in one place, and it keeps the stable backport
minimal. It might be worth adding a kernel-doc comment on
aer_recover_queue() stating that it takes ownership of @aer_regs,
which must be allocated from ghes_estatus_pool, so future callers
don't trip over it.

For the series:

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes in v4:
> - Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as
>   well. No conflicts with the Advisory Non-Fatal Error support that landed
>   in the meantime.
> - Added missing Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption
>   when error status data has multiple sections") and Cc: stable to both
>   patches; that commit (v6.7-rc1) introduced the ghes_estatus_pool
>   allocation whose ownership these paths drop.
> - Patch 1: use braces on both arms of the if/else and fix the continuation
>   alignment (checkpatch --strict).
> - Both patches now build warning-free with W=1 and CONFIG_ACPI_APEI_PCIEAER=y
>   (earlier revisions were only build-tested with APEI disabled, which
>   compiles neither of the modified functions).
> - Explained in both commit messages why the caller cannot free the buffer,
>   and when the missing-pci_dev path is reachable.
> - Cc: Lukas Wunner, who has been active in this code.
> - Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com
> 
> Changes in v3:
> - Resent to fix threading of the series.
> - Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com
> 
> Changes in v2:
> - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
>   is called unconditionally for every dequeued record.
> - Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
>   buffer overflow.
> - Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com
> 
> ---
> Priyank Rathod (2):
>       PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
>       PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
> 
>  drivers/pci/pcie/aer.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> ---
> base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
> change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
> 
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


