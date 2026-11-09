Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A80606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB6bYnhx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmQf57Xcz2xns;
	Tue, 10 Nov 2026 10:36:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794267418;
	cv=none; b=l3Fv9mzytCJtlSfJnxnxTwpNxYUABEzZkmweOkesQ7NPES0HRsXojE6HajTRtEXzA2iLM1qQkbtVlY72Kp3i7SwALk3W3UxEz3I3N+/mzsMYOeCtSeRLMOq2ghaSyt1EqGfIcGOoSX3Fxr3AbUclYzcJ4dtZ8f1MYPWkzi2hO8Qs4CUKSIeOpjG6gqb357Uzp7bxxVJYqf8DQIlYJ3i1Jb7Vm3L7GUc8KLrhEQwXgUFP9pRf5cbUnLlmGYZi5HDnR246gFPFRA2UdJt9HuKBfvdgyPdNnj2tMX8ilEzQxofTlvIaegzgdTlIHVMIxhtNCV/sUWTkTdz+ikk5osdDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794267418; c=relaxed/relaxed;
	bh=PV3NgAozrqWqxEQMaX8OxVWRTrAfPuHUQuyLRIB/awY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ooc20fSjd0UtWRwNgO6TLKsPI4skeg1A5vAJgJC/RLF8+te4Z840dYrl96iWqgpk9+Y6vQ0D22HLNxdiouuLzCulYWVgtMIuA/uqxUKscIjvywtB0vk3OYJ9Bu5MJu2v7zI87DqtPSnDJTjyNO7pBqRlr/8HpFldt613Gsc96YQ3QRT/l/Oz1Oe7h8LJFhs889EuVBUHBrHac3yBLyX/UJ17FpZu0S9RmW1fKpfBZ/XtAQAqj6sJ9GX9klL2oFVew54g/n8am6pZMUTUkgEioz+CcWJRbVjwzYNxv8OOXaWYtsZ3krysBgsMYd0kNgpg2BJoDt1WqODZUqbexd4hJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB6bYnhx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB6bYnhx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmQd5yQDz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:36:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3949241789;
	Mon,  9 Nov 2026 23:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04571F0089F;
	Mon,  9 Nov 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267415;
	bh=PV3NgAozrqWqxEQMaX8OxVWRTrAfPuHUQuyLRIB/awY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=iB6bYnhx6g6QEs7lsu1UTZqFL75zvpk1qGfm79ao77Hqt7va+eT8Q66FpHlIfYcEU
	 OpEui55VyqIAT8xuu5i0bo153L82kfvP9GYeHBy6ZFR0IAZJeUwlweKqw6NcVQ0fWm
	 eRAVCH28/gQ4zFjCnM7dxwEm5JjwsJuvdNlY+bJjsqY2zqepdXe6/acRq6iq9Atpjf
	 AiCB++lHxqdbmD02KPmNlbcCAvAw4YzhY0aRUtDoFTpuQ8UoHSfaAbIJ0TvCe3gHaP
	 LsrzxWZRQ84RapPwXp/G44uw+LUhjOamcTTXF/eGMgT8jGiM3S0SDRbL6uO1ByH0Tu
	 m1kau6/jNpKfA==
Date: Mon, 9 Nov 2026 17:36:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 0/2] PCI/AER: Improve Error Source handling
Message-ID: <20261109233653.GA349541@bhelgaas>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793982724.git.lukas@wunner.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 05:38:00PM +0100, Lukas Wunner wrote:
> While analyzing log output provided by Alex, I noticed that the AER driver
> fails to find the error-signaling device if the Error Source ID register
> contains an invalid, non-zero value.  Fix it (patch [2/2]).
> 
> While at it, fix a potential NULL pointer deref in that portion of the code
> (patch [1/2]).
> 
> Changes versus v1 in patch [2/2]:
>   Reorder a < b && b < c comparisons (Ilpo, Bjorn)
>   Amend kernel-doc of find_source_device() (Sathya)
>   s/subordinate/secondary/ in commit message (Bjorn)
>   Document behavioral change in commit message (sashiko)
> 
> Link to v1:
>   https://lore.kernel.org/r/cover.1793697480.git.lukas@wunner.de
> 
> Lukas Wunner (2):
>   PCI/AER: Avoid NULL pointer deref on search for Error Source
>   PCI/AER: Check validity of Error Source ID register
> 
>  drivers/pci/pci.h       |  7 ++++++-
>  drivers/pci/pcie/aer.c  | 37 +++++++++++++++++++++++++++----------
>  drivers/pci/pcie/rcec.c | 14 ++++++++++++++
>  3 files changed, 47 insertions(+), 11 deletions(-)

Applied to pci/aer for v7.5, thank you!

