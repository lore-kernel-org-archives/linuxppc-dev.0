Return-Path: <linuxppc-dev+bounces-23727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079A7C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 18:36:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvqg42r2Fz2xnp;
	Wed, 08 Jul 2026 04:36:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783449360;
	cv=none; b=ngYetyOeCP/3vqExOfSWk7dPBUt8VoRTocs9UjXmX9V7Aj+ryc4D6blee3rLbGoeaKCcWOi8r9asqYYD6hxmYbKud4MbBPMq+RIjkd3Xm2mr4ux4vcbAcXMoGfw2ckQkBvRgMuvDWQBLX1wGpOqi5Pw7MONyex5PXOHYI0WhkCRaQpjRdD1gEkZIyMEbz7zn3qPY0cYEomvpnZmrXRyv24FM2qwijKIdWHHV+wOYLD6h/J1aHz8c8nimd5BHooxx4fm2WMWPAvVHnD52VLRIBiwWEJtCZrBpCwN3ZGfa2mNtvSkHuAw1yvG9sZGb2a/FffhFrCwZX9kI4WYm/lEvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783449360; c=relaxed/relaxed;
	bh=xPqvH8m6sJZ8BPRjXX6PHX56Y4vsxNsv4zKIvUARo/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw3CAbq7uqZU5ZYPTJf2Eb76JoeYMYII1Fz6N77xMRJCR60biR4lxrINdDkTpPdWGqzyaDEBktQcLerbjC5N0iw6ZbpFwrUSN3w6BOuC4HaghMUZOFVuQ+Xmtqq1AkzugToSelY2XxmK5nYibrEJKHYeccxHLBnrhlf2NpYkd/6TOBRAz4nM0J9rSS5A450g822SBhWQ6Rx+LhDR5YYM550/pbu9MOUYnZdDXkIYj/HLsgVL3CIRxFKrMnESNMLOoYwQzt83Yg0SoHXE6msQJnPHydb45LH3NhP94BKmqAEYOuyAtYUFHF1SyyhtW+jiSqzURQJIS9d/8PaiSKlY5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=fail (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=gTc6FoWa reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=gTc6FoWa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 9142 seconds by postgrey-1.37 at boromir; Wed, 08 Jul 2026 04:35:59 AEST
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvqg32G4bz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 04:35:58 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C575B40E0140;
	Tue,  7 Jul 2026 18:35:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YwzEzrF91RIy; Tue,  7 Jul 2026 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783449343; bh=ua4u1LuUlezN8j6xu2WIJg9JtcJ7b4ThrEAFlNhjKjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTc6FoWaXOvHrcV7b24WqFshXfsrcHIgdZ87MOaPfogiTPw5w20YhQgy/iwJWZUKh
	 7yTEG9SSMwC7UT6G4waoaf4D71z4dRJdOy2a1WowEV5tYoCmuSwYdL7ssMglGvQyy7
	 8ALdrILLDVaX9LtEELvuDM1B1cCxDVsztC9DMAI483AzO7/84fyH7mZswHc+VVyM0M
	 qgfJ5ZNRxGiNzZmhkLm5Bz6I1ivFExeO6Q4+073FfymSMDZy1lK59poyzR9o8v+DNs
	 sc+r0HZLDcVk5/joZ8DLmKToROIqCn5umWnhW0+/OJG7aNstYug+GexLfXnGggWEcg
	 JRoV3XZ6r1+kHRoXFxnJA+09g5McuH6DvyuQbK6Yu26eWilxO+fIImgnJDLpoXBfZ6
	 DFWUzpXId+BxhGag8reTRp7vgLsROnQqym6A2s6ed5lmCZG8k7KejZ0xrQhjXpiJqC
	 m9YgG31jwT4MBqaxZoBM6seQMMHWR236PM/rHbyz8R3BDO7nKediqpFlJ2BJH/4M2t
	 AzYN5ZLOnGNYcyFFnfOOKroAHnspB9gmLU3/Op5NCJ9Z1hd4Z1q8ldCmsA6F0fl+Zm
	 2TuhXQ1T5kVT5y3xXFTE1skK/c/beFypQjmfNPX0eXJKqTOP0//9mTx5hZ+Ler4pxN
	 3BHds+4jjjrob0FIDCu9VWw0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C725A40E00DC;
	Tue,  7 Jul 2026 18:35:20 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:35:17 -0700
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <20260707183517.GCak1G5TKyF1ggs8WW@fat_crate.local>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
 <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
 <ak0sGAX_NWMyeofC@gmail.com>
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
In-Reply-To: <ak0sGAX_NWMyeofC@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 09:53:34AM -0700, Breno Leitao wrote:
> The current vmcoreinfo implementation defaults to enabled, so I wanted =
to
> preserve that behavior to avoid silently removing symbols that existing
> tools may depend on. Would you prefer a different default?

You do know Linus' stance on enabling things by default which are not
ubiquitous, right?

Logging hw errors in vmcore is really necessary to be enabled everywhere?

> I agree the sysfs exposure duplicates existing infrastructure, points
> taken. However, tracking fatal hardware errors provides value at crash
> analysis time=E2=80=94it lets us quickly determine whether a fatal hard=
ware
> error occurred during the kernel's lifetime, which is useful for
> root-cause attribution.

Yes, that's why you put it in vmcore. You can't read sysfs if you encount=
er
a fatal hw error.

> For this, would you like to keep it in vmcore info (as of today), or
> move to RAS subsystem?

You mean, would I like to pay attention to more patches than now?

Not really - I can barely manage as it is.

:-)

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

