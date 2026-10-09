Return-Path: <linuxppc-dev+bounces-29104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91971CA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Vb75sBZz30TQ;
	Sat, 10 Oct 2026 02:07:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791558451;
	cv=none; b=USINaYEvROGZs5sUSqbvkKOGIqViWTXMqmrtYKRJXEcWbvE4lv1e9uWmCRx1IbGtARHUxpX9gfzvcBEE6v4skFfylFdUEAt7/fpSGz5GNtacBk/OOAOiX40YOuDfU0eR7xgpM70ckcMGcMtcPoCHgAG1Rw6XCwQHuF5/NX3chOghx1ASrg1tPUmeyyFPbxlIW7jNeemwNGt5CUjxTgQsxssp6Pu1Daykr/toxx9mEfJpzFgFab1jLUJFlIe2r2QGI4RrWVL914xb+9V+fuqrt+7qZYME44pC9oWPaWT6KjKxTcJM/w1TBQaHyc09A1NQh1VCFvUjwt5UuMtoHsfclA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791558451; c=relaxed/relaxed;
	bh=Yc4wezejOuATtX+/xD62oIcWyMlHYCGQf4E0gpjKHZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VgU5N1IAkKs9RdGUG1KN/LeZDvMyRkr66SOgAeL9wHgP3fK97F1uVk+4fcgC6VyipmclJpOnkWIMGnBguYXqH/aZDXqkedM8fNKIiXVYh9Pr+qO8Ozgpl48giTDM6E8+jzGCbhOkTzcn26UNq0g8yMxs5b5CR6JNm4sjU5jdkFAJHt8bWIEyWDlLXU0d0UbjBA79rY0azRURfKC0MuQJR00zMx77qKwWIf0maDGnr7IKwrUupv/OFyXuUvrC91+Yrc2ouuK4jVCaDy2phU4scUy1JpzpPi+f/AyxkJFMz7vimsjw0Bv+VA1jNSpyn43Slu3NXX33aBGzBI6YsZ3iNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/aRiNmV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/aRiNmV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Vb61F60z30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 02:07:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C546960098;
	Fri,  9 Oct 2026 15:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53C1F00893;
	Fri,  9 Oct 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558445;
	bh=Yc4wezejOuATtX+/xD62oIcWyMlHYCGQf4E0gpjKHZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=C/aRiNmVkNEuBLKRmeE6ewObnb27+Vw3S+hbRtFUJQqlzChgB/xrPXH+JASEb9dOz
	 wxfwRKzmIFjMyRwkcGb5WlHQ7YwFeXCqCjR0OvFgxL9qbwdY9gDjPlnvDVPovlgppc
	 EzCnIE6GsNyWGHDiNHcGfkAanpsFUhA5xMnBNbCutl34iycb4lwmpc6vrlv3+Aycrc
	 8Ac9fhtwz4hYm8tyCjNNPm20Z9a3QBAHuu71k/X34pZZom6WaMy1/u6xEf6HyiKjD8
	 EhoL4njP4J9Fh9hC3rKxA0MsO8o3r7p1cmuGg1vvFu8wAB4qMnzc0fCK+TLuXsbQ/d
	 HrRCkVAAtjjJQ==
Date: Fri, 9 Oct 2026 10:07:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261009150724.GA974326@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ash0Rn78gwlQ87Fg@wunner.de>

On Fri, Oct 09, 2026 at 06:57:42AM +0200, Lukas Wunner wrote:
> On Thu, Oct 08, 2026 at 02:17:05PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > recover from a Firmware First reported Fatal Error.
> > > 
> > > However all status registers in the Root Port's AER Extended Capability
> > > are blank, so apparently the platform firmware raised a false alarm.
> [...]
> > > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > > actually signaled.
> [...]
> > Applied to pci/for-linus for v7.3, thanks!
> [...]
> > If we're confident that this also fixes the MacBookPro16,1 power-off
> > issue reported by Jason (it would be ideal if you could test this,
> > Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> > If so, I'd like to add Jason's Reported-by and link.
> > 
> > But if we're not sure whether this fixes the MacBookPro16,1 power-off
> > issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> > it with this fix and try again for v7.4.
> 
> Apple products with a T2 Secure Enclave will require a separate patch
> which avoids enabling Advisory Non-Fatal Errors on this particular device.
> A quirk, in other words.
> 
> I think the firmware on the T2 is upgradable in principle, but Apple isn't
> going to do us the favor to fix it.  So we don't have any other option
> than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> the first device on that blacklist and maybe others to follow.
> 
> I was going to work on this for the remainder of the week, but if you feel
> the feature needs another cycle to mature, I have no objections to
> reverting eddba19b8b5f for v7.3 and re-applying it together with the two
> required fixes to pci/aer.  (The two required fixes being the one for Alex
> and the one for the T2.)

OK, it sounds like two separate issues needing two separate patches to
fix.  So I think I'll ask Linus to pull this fix today and watch for
the quirk next week.

Bjorn

