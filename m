Return-Path: <linuxppc-dev+bounces-23721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:54:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvnQ61QL8z2xWY;
	Wed, 08 Jul 2026 02:54:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783443278;
	cv=none; b=BUjHzzZEEOHdLJLpRwsMOa/DWALllKUneOR0/E7fEu3C6nOBfxhINlij3/KmfveMmkyiH5M8l+/PsJH3ntxEEAMV59mwWqBFt8u8bJmOj7f2WtLnEZch+f7l2VQ2IlPHstjUeumLvwYaNMZerd1YkCHQK/tdHp/AVSA7tbmKDXZDsSg0WVe0oJ+1XcLiYI34Wfl2G0G758KMzxeMKrLKChUiU7zpAAmPp2/FKvmHqYy+QeIFrQPp0BzX1b2yIMED2kukwLroZ9LIoOlum7yD2NX7vQZs4C0b3UA2bqhTHKDf0PmDOCFHxxtocAbw0Jm9t1wG9GnOOsshTSEDLSks8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783443278; c=relaxed/relaxed;
	bh=j2Rqn1Z44LxF7P3FTLDUbHYmw1rGJj24sZvFbQfBOow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkPXtm3dVATmdS/dl2HalOQidbh7c3aNM0M5AFv5eyp93rKavL+w9tIA68iYqAeMK19C3U69zPeg8Jwcx7kjZGacIkyMF3v/mQlrWwnZfZbqy7nE/mTU6hjer72U/r00cNn8I1aulvGzbGATnNoNY2KsIp1hJeP+W+e/p5AMt8lkli80QsSz/3ob7yM11p1CLHKD8so2rWLWiavVU4iiQmEeKCesZWiQH1Y/Rsofu0n2bcaqYcNT/C+LcMzj9BqhsSjrMBaUL1hed3UgXH1nKCqaJym6nNyR5sQMErgkwkW45X74aHC6kkZKCrnylMFTI+uRb/gx475QN3ujM+Np1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Pl4p1yal; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Pl4p1yal;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvnQ50CqNz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:54:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=j2Rqn1Z44LxF7P3FTLDUbHYmw1rGJj24sZvFbQfBOow=; b=Pl4p1yalKmm+mrZN7WFY+OF3pM
	EKFT9R+1VEqiL2myq3u6bDdn34eocPOjGy9JrK477auMsnFu7fLI5bKaCGN2GvnTsj3kBl6mV7AcU
	4YBbRFNWwR3rWAFsVDWI1ibDYxasy5K/hDqoS3SBo/MCJcDQqsx19Spietc/z21PqdKLeXsNQHs+1
	wSqtBxnD+ylek2GfjgWVFqC6hyb8pS3dIofyFEnYVP/ia3JodiWWQ9PNFlbDtW3fw8LDlDUszQc1s
	p9v1z5eBEx7PinOyrxu7eLDXRctpsmbQKHA3d+AabcpgqwuctT2osEXUEMxp42Y990eiWJOEXngH3
	0SzOND0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh93F-002KMz-26;
	Tue, 07 Jul 2026 16:53:42 +0000
Date: Tue, 7 Jul 2026 09:53:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <ak0sGAX_NWMyeofC@gmail.com>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
 <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
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
In-Reply-To: <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
X-Debian-User: leitao

On Tue, Jul 07, 2026 at 09:02:47AM -0700, Borislav Petkov wrote:
> On Tue, Jul 07, 2026 at 07:02:34AM -0700, Breno Leitao wrote:
> > Move the implementation to drivers/ras/hwerr_tracking.c and the
> > declaration (with its no-op stub) to <linux/ras.h>.  Give it a dedicated
> > CONFIG_RAS_HWERR (bool, under RAS, default y) rather than riding
> 
> Definitely not default y.

The current vmcoreinfo implementation defaults to enabled, so I wanted to
preserve that behavior to avoid silently removing symbols that existing
tools may depend on. Would you prefer a different default?

> Do not explain the WHAT - that's visible from the diff below; explain the WHY.

Will do.

> > Link: https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/ [1]
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Once we move it outside of vmcore info, I am planning to add new
> > features that are in the limbo now, given they don't belong to vmcore
> > info, such as:
> > 
> > Track fatal hardware errors
> > 	https://lore.kernel.org/all/20260617-hwerr-v1-0-ff131cd6203c@debian.org/
> > 
> > Expose hardware error recovery statistics via sysfs
> > 	https://lore.kernel.org/all/20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org/
> 
> We already have rasdaemon and a whole pile of infrastructure around reporting
> errors. Why isn't what we have, enough?
> 
> The stick-the-error-into-vmcore makes sense as a use case, sure. But this
> other information we already have plenty. I think you should use/extend that
> instead of adding more.

I agree the sysfs exposure duplicates existing infrastructure, points
taken. However, tracking fatal hardware errors provides value at crash
analysis time—it lets us quickly determine whether a fatal hardware
error occurred during the kernel's lifetime, which is useful for
root-cause attribution.

> The stick-the-error-into-vmcore makes sense as a use case

For this, would you like to keep it in vmcore info (as of today), or
move to RAS subsystem?

Thanks for the review and direction,
--breno

