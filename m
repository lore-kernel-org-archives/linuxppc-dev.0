Return-Path: <linuxppc-dev+bounces-29080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECF1CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 04:57:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1F3j3kk0z2ynZ;
	Fri, 09 Oct 2026 15:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791521873;
	cv=none; b=i8qf05WJ1ReNqnF6sjzW7sXv4XCJW5QUnRjqoeGvDPcSmCvSQP6MPGRR4vL+dER7QfXZZrnJu5Twq7b+efWOzZIv2YdJwz8EbnPBgVSV8g+ylNsbs7kHUlKHXfaUlc3bN8sw9cAotlU7vTAOmJpRgHcqZpTXzpqqxLHiTjEA8GxfsXXUPaBcdx4EeqcxsYTH67CrXX5Bmz/xYgZo6oZCrFf5eZqYtKxZoppK/lKOfWREAo1Q1fr5IsBCKEPAgdjO8BfEwARyIgSjjN0Mje8CyCH65WgfrZRCmwdKIJkza2Hy87FHiTK6daJ6Z1DSV/RJg9BhCZ5Rp/4aoSdnCEHTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791521873; c=relaxed/relaxed;
	bh=xKN5BMe1klbFjp4/twHjytepvpA+p8x3DCkY5f9rB6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyTl5Vrjh8FSHGgiGNw/ozvmJMy8A1jIodXtBVue7EmRBu3vLQwx170OPlbiNqJpnNZOjZK1jIiv5zBSiGTYcSbVsU5uyZRah2g71OesyzpPiSppSz8XA5zRzdvFL3TPBIRC7/9U/8y6MmzjxKj+maILGJJRLmqD1vRWE62EPUbqBe/gPE0aLZRXYke3ztsktjBLZBX/3GPwktIwp21tY+mcES6wckZcBH4bfeBZUbH0PI8UOEJiHHT5vSVxJNOUywpScXQpO/Cq1hiiIMZP1JvIh7cLeoe2Qx/UZBkzPRxYeNtMyI/hJ//kCHDSski9RVvV34KNWE5zh2Bravnbxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 59501 seconds by postgrey-1.37 at boromir; Fri, 09 Oct 2026 15:57:51 AEDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1F3g677mz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 15:57:48 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 9F678377;
	Fri, 09 Oct 2026 06:57:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 754216013EAB; Fri,  9 Oct 2026 06:57:42 +0200 (CEST)
Date: Fri, 9 Oct 2026 06:57:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <ash0Rn78gwlQ87Fg@wunner.de>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas>
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
In-Reply-To: <20261008191705.GA917105@bhelgaas>

On Thu, Oct 08, 2026 at 02:17:05PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> > 
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
[...]
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
[...]
> Applied to pci/for-linus for v7.3, thanks!
[...]
> If we're confident that this also fixes the MacBookPro16,1 power-off
> issue reported by Jason (it would be ideal if you could test this,
> Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> If so, I'd like to add Jason's Reported-by and link.
> 
> But if we're not sure whether this fixes the MacBookPro16,1 power-off
> issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> it with this fix and try again for v7.4.

Apple products with a T2 Secure Enclave will require a separate patch
which avoids enabling Advisory Non-Fatal Errors on this particular device.
A quirk, in other words.

I think the firmware on the T2 is upgradable in principle, but Apple isn't
going to do us the favor to fix it.  So we don't have any other option
than keeping a blacklist for ANFE-incompatible devices, with the T2 being
the first device on that blacklist and maybe others to follow.

I was going to work on this for the remainder of the week, but if you feel
the feature needs another cycle to mature, I have no objections to
reverting eddba19b8b5f for v7.3 and re-applying it together with the two
required fixes to pci/aer.  (The two required fixes being the one for Alex
and the one for the T2.)

Thanks,

Lukas

