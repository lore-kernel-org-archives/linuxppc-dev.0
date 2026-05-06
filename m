Return-Path: <linuxppc-dev+bounces-20529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7437CCD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 18:14:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9k7D47Dsz2xnM;
	Thu, 07 May 2026 04:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778091288;
	cv=none; b=aclTRrpSLqf3l3hDjnYybw8n1B8E/wQMelNGsAqYJsAGbWdoBYOpRGwPSD83fgyBUQYYbOhmSOgIfj9lujEQpeD1iQMPrXpZet0lS68Si/XjFQOfm+CpCD9kpIXQw0G4ZG0l+xQYHurC/jx+EpG9z2GDfBVBpnN3ziHyF2jASLv2D7g8UQte1oL9YZpvyEluUM1O8ngq8gOBS7SqUdBxsSbs3h/GwltgQ+ESxmxXLrInWVZI928/5n1XXIBONsspb2Bt12IPzchygMbT6VcKz1Gxo4PWXUbsFD3FWkBsIAsVEfgljqDYxbR08QP1CXf5+ujeJWLljrF7S74NDAg4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778091288; c=relaxed/relaxed;
	bh=FwFMwCwIqeUoTXb2TVk7xs07S/CpukkQLm17aHm1vqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eX8jztmTWb68UXt69RZjV83LokWCqXxa16S+sa/7DjQjMz4n9hC8WFqgTDF0ijzyJ7b8jprXQ8DsnoWO4WYtbv24EQvs1BqXalSLwxvO32P1zATw5wj77gKCjB/howYPL/IwuXY/jTkiDIjZU9FvzdCMBkNZhOaVPVDOZOlViqcJ4dLmAJkd0mD3SFgT/ZX3Wx4dl9gYIjcVH3HPS0AN/Onsev5JNfgmm41ZMJGe1Dagm/tnXXgHN6ic8CUbTaBywg2OFh+NqXqUi0WLH/WESSPbEuPzxjcmjtWwjxJ65mZppUhFWYbqpcJ3noz8Lz5QcOoavbTFM2vKjHJpWFSMZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qmQ6k5Qm; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qmQ6k5Qm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9k7C3BxLz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 04:14:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 333B660181;
	Wed,  6 May 2026 18:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE22C2BCB0;
	Wed,  6 May 2026 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778091284;
	bh=c/09Dj8C+PYr3EcGytaD3pkNgvnZRe+8FnSy5cU6O2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qmQ6k5QmvqOHLJ9mTiSkOLDLIy5fZcfiUtV8ZK5n3kmAsEADxh/DDanOE1nlv6Yes
	 Q1m5LZcGxb4zyhXTViuEUtuW+u1f2YCGmq42PrfPdCkWIsnoUUZrRdb3Pajn1eh2qG
	 StEr0KXZ+ihay4w+Ngizt9yOI7G3tyXnQ9+FBJYpSzrfo+909VmpalnVx2yxwO+rMf
	 9Oy0p92HPWGTf5p/FNFZnYZT+gKIZxdlRYbZNHwQ0/KQqmArtGjBUop96S3gHFJnHq
	 QLyDfTOrpBLJi1MsIr/PHX7UdgIevqKLFBY7/jQIZPkeRthMRAlnbi0BKAqJwCT1/t
	 W/xsnPXiHAvbw==
Date: Wed, 6 May 2026 13:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] PCI: pci_resource_alignment() improvement +
 cleanups
Message-ID: <20260506181443.GA804153@bhelgaas>
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
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>

On Wed, Apr 29, 2026 at 03:26:06PM +0300, Ilpo Järvinen wrote:
> pci_resource_alignment() returns 0 when resource is already assigned
> and in case of disabled bridge windows. This has caused problems to
> calculations relying on pci_resource_alignment():
> 
> https://lore.kernel.org/linux-pci/LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM/
> 
> This series reworks pci_resource_alignment() interface to return always
> non-zero alignment if the resource exists. For assigned bridge windows,
> the calculation is using heuristic based on size and start address
> alignment as calculating the alignment again is costly (would require
> sizing the entire sub-hierarchy).
> 
> As pci_resource_alignment() is becoming more complicated, it's also
> moved to setup-res.c. While moving pci_resource_alignment()'s arguments
> are converted into const to tell compiler it can rely on resource
> remaining the same across the call.
> 
> This was intended to be part of a larger series that addresses some
> shortcomings in pci=realloc. The pci=realloc changes will recalculate
> bridge window sizes considering also assigned resources which required
> making these changes to pci_resource_alignment().
> 
> As this also relates to the issue linked above, I'm sending it already
> now without pci=realloc changes that are still incomplete. The first
> patches originate from the large pci=realloc work but seem generally
> useful even if independent of the alignment improvements so I've
> included them here without reorganizing the series to contain only
> alignment related changes.
> 
> Ilpo Järvinen (11):
>   PCI: Log all resource claims
>   PCI: Rename added to add_list
>   PCI: Consolidate add_list (aka realloc_head) empty sanity checks
>   PCI: Remove const removal cast
>   resource: Make resource_alignment() input const resource
>   powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get()
>     pci_dev const
>   PCI: Make pci_sriov_resource_alignment() pci_dev const
>   PCI: Convert pci_resource_alignment() input parameters to const
>   PCI: Move pci_resource_alignment() to setup-res.c file
>   PCI: Lower bound bridge windown alignment
>   PCI: Return valid alignment for assigned resources
> 
>  arch/powerpc/include/asm/machdep.h         |  2 +-
>  arch/powerpc/kernel/pci-common.c           |  2 +-
>  arch/powerpc/platforms/powernv/pci-sriov.c |  4 +-
>  arch/powerpc/platforms/powernv/pci.h       |  5 ++-
>  arch/powerpc/platforms/pseries/setup.c     |  5 ++-
>  drivers/pci/iov.c                          |  7 +--
>  drivers/pci/pci.h                          | 24 ++++-------
>  drivers/pci/setup-bus.c                    | 50 ++++++++++++----------
>  drivers/pci/setup-cardbus.c                |  2 +-
>  drivers/pci/setup-res.c                    | 37 ++++++++++++++++
>  include/linux/ioport.h                     |  2 +-
>  include/linux/pci.h                        |  8 ++--
>  kernel/resource.c                          |  2 +-
>  13 files changed, 94 insertions(+), 56 deletions(-)

Applied to pci/resource for v7.2, thanks!

Powerpc folks, the arch/powerpc changes here are minor (just adding
const), but heads up in case you see any issue.

