Return-Path: <linuxppc-dev+bounces-28941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF8CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:27:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzFsn23TFz304x;
	Tue, 06 Oct 2026 10:27:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791242845;
	cv=none; b=edcsqGn3mL2GWlO83Y1eXkZj3I84+wKkIAQtLMC/9O1vsWR8gp7raRHjNfryCc0FdkmEZWNEMQ4Pa8h+jyj1snBY5PtTRaAT3yzBAhMS6aybOClWQBxABZXwmMKWzOcGohCfvfuMSQ1z75vi8bw6LqJCqCmRBGk8wGfuqrEhDFL0uuPvkeJbZQExW+fDrzyOzk4/hFehqJQKnuwYBi/Nu4fFWHrS7zRk8ifWIMjgMJwns3WnV0dBKxfQsNO4KkPZBzvuxrD/gjS3eErhb4s9nFS9JSyI+p6aeAGfUg9djABRTK7jRp2zM/P9q7udaCPNHcWwi5z/s7ya/O6PBnYWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791242845; c=relaxed/relaxed;
	bh=WBg20LLYaRPC5p8DnVDECrTO6jgh2E+qFuXSSu1+OPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B7toltJzilzHgfDlq2gt5jisWfwYST1AHmo9k/PKt2M0JOhgNH2BvN2EYTGr0ZFQ1WC0jwXauChBt6mLrw9slxmG8PmVVS5QAPC9GgXpGjEkJ7c+a6mgfrUcxJmlkdq+EJIIGRBLCFG9ZRhTnoWW2B9LmtYE59cmx5aivBHsYGTlJDzcUOFt63jKDmdnS9GaJWWnyizb+Iyw+rtJ+6yVInhXlXFSt2AIoFWRIhnI7keUz3V700UN2E06wvmhY/EcBejSXuEjwUrWLz3IHOfrL7T/ao5/ng70GchTxUICBkwDidDDKmvBmTm5lRFd+1C9aHUat06/GZXNQ1t17jwBLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiAtA938; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiAtA938;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzFsl4Zhdz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 10:27:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2CC3E60008;
	Mon,  5 Oct 2026 23:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56601F000FF;
	Mon,  5 Oct 2026 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242839;
	bh=WBg20LLYaRPC5p8DnVDECrTO6jgh2E+qFuXSSu1+OPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JiAtA9389pKiNZ/CFNdNGZg9ElYghY3oQCZaMIdG7HN1kBL+JCey9eKAJbuxAXkIM
	 D5TNRQ4bL6Bc9bnSaYT00Cfla7K2k95ur+YyPKYhXOrs8tln3u2NGmWfVONYo4RHuA
	 qHVr2g17PYxa6ZWaP9e+qSo/9dmJtJbGYTdh9Zxr6aCBMMeoRh1rpyeQ7WWRosLAcS
	 7Eu3PUUZnf741EfbF54G9O4QMgoCfFfDDVqE9anoy3l8VUI6apGYzzyZeUNmVDlDHU
	 BtrFFsqJyrf5OlmlUUFODHWzMCreON7H3qXeHYXEsz20oOvlTg6PM0C9WJtIDkOTwO
	 lFKUUaO+Kl8yA==
Date: Mon, 5 Oct 2026 18:27:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
Message-ID: <20261005232718.GA644801@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>

On Mon, Sep 28, 2026 at 05:40:11PM +0000, Priyank Rathod wrote:
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
> This series fixes both leak paths and documents the ownership rule:
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
> Patch 3: Add a kernel-doc comment stating that aer_recover_queue() takes
>          ownership of @aer_regs, which must be allocated from
>          ghes_estatus_pool. This is documentation only, so unlike
>          patches 1 and 2 it has no Fixes: or Cc: stable tag.
> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Applied to pci/aer for v7.4, thanks!

> ---
> Changes in v5:
> - Add patch 3, a kernel-doc comment on aer_recover_queue() stating that
>   it takes ownership of @aer_regs, which must come from ghes_estatus_pool
>   (suggested by Kuppuswamy Sathyanarayanan). It is a separate patch so
>   that the two fixes stay minimal for stable backports, and because the
>   comment is only accurate once patch 2 is applied.
> - Add Kuppuswamy's Reviewed-by to patches 1 and 2. Their code is
>   unchanged from v4.
> - Still applies cleanly to pci/next (94e8d4e94266), before or after
>   Lukas' "Error reporting for AER-incapable devices" series:
>   https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
> - Cc Kuppuswamy Sathyanarayanan, Jonathan Cameron, Ilpo Järvinen and
>   Dave Jiang, plus Shiju Jose and Rafael J. Wysocki as the author and
>   committer of the commit in Fixes:.
> - Link to v4: https://lore.kernel.org/r/20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com
> 
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
> Priyank Rathod (3):
>       PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
>       PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
>       PCI/AER: Document that aer_recover_queue() takes ownership of aer_regs
> 
>  drivers/pci/pcie/aer.c | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> ---
> base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
> change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
> 
> Best regards,
> -- 
> Priyank Rathod <rathodpriyank@google.com>
> 

