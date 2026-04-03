Return-Path: <linuxppc-dev+bounces-19270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A76E7E37E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 11:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnHJc0HNMz2yh4;
	Fri, 03 Apr 2026 22:57:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775217423;
	cv=none; b=kCOUv1Ehof2Ox2B5sg8mUs2I+Zi7TwSW4iifPrklOT+nUyS9Rz737YSuxtJiupVpuFi+oNUnjfxlB0QII8nL0y/z5zpI5xZZBwmIcqzy3PMfns26KfD4LIYMBhid+nt2vk9BezG0kH9eobGMPhNdpq51v6XDMOxrgDQJ+t7FkayKnFSFvGDCtM3J6ZnxjsXXo9ROVlSLBRnUxAHI9fC9NvbJ0m9MnjEGfwHVb4rnhOC+QlHAxnKDaICH8KWK9VD1Noqv52Qfpte5Wb8kYmvz7Jsi6nDTPX+zHt3mcO0OR4Ki7XSUVl58lZslEYqky903ddS7AGrFeJXV/nt4lj13SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775217423; c=relaxed/relaxed;
	bh=hlI1RBQqJjfpWuFZsCc6c4R0ASQxP62EyBGuIa0hpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEeV68gJDsweNOw6iJ8RFPMK8BlShfYzALDhv4aimTHRVUzPZuRysc4Wj+hdtX6sKWmdUjpTnBb1aQzPFTre/XkKRaG2StOfEPP3X74uB11PEOLrWi1TOM8eIoCwZgqxY2IH/sd/+Qf0VWThRYcReIMB0QV5iaKczB/6fedkoxSyEl83KbnyVaLu49Z1z9znQlzlLXCf45W7SaPtBMxL6hQoikk5yZ3UhjydmT3xJFA7f/CwZqAWppf5xo/xW20BkyIiwV+EiuoSwwF9rbF85WhD9StUvLDp2NNVaZmlxV9oEFOE0tilsincjYjjhIa0iT7ofJ2emtQtgYE8l4cwYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WExiF/lE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WExiF/lE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnHJb3M6Cz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 22:57:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 975CF60121;
	Fri,  3 Apr 2026 11:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F48C4CEF7;
	Fri,  3 Apr 2026 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217421;
	bh=hlI1RBQqJjfpWuFZsCc6c4R0ASQxP62EyBGuIa0hpOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WExiF/lER3/HxYWRZ7/VYGGhEbpEpz9xoEPNjcsCFvTGNpufubq1/grWFEw4iuMUy
	 OoXV5ZN9cvTpw+MrimzFf6s9HmUgEebMHP6rxEPoVqpOak+AAKYreCCI+aI8f5Gcf8
	 zd3TXBgf41BbeUDYgDIMBFsxjCPG+plKws+G4eTYF97BpuDvffRy9f5yT7XQBVGQbe
	 XqHjaEsIVjnSBX+EIpGZbUC6lXfkWCjygMqGuZgL2M9uFpPhtTcBQ2hiVkdvbT8xp0
	 yn+PYHPMRpNNVo0RArrBjXz2Wp47lKN2V/BGSRUsMLv3YU6gYJZRfQsOsmZPjmN+O6
	 y2sPDI66WCWpQ==
Date: Fri, 3 Apr 2026 12:56:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, ardb@kernel.org,
	catalin.marinas@arm.com, chleroy@kernel.org, david@kernel.org,
	driver-core@lists.linux.dev, kees@kernel.org, kevin.brodsky@arm.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, maz@kernel.org,
	miko.lenczewski@arm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	osalvador@suse.de, oupton@kernel.org, peterz@infradead.org,
	tglx@kernel.org, will@kernel.org, yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: Re: [PATCH v3 9/9] driver core: Replace dev->offline +
 ->offline_disabled with DEV_FLAGs
Message-ID: <57452867-60be-4292-9bc5-4e2faf1f3cb4@sirena.org.uk>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AVRN0JUTTuR+6v5a"
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
X-Cookie: The Korean War must have been fun.


--AVRN0JUTTuR+6v5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 05:49:55PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "offline" and "offline_disabled" over
> to the "flags" field so modifications are safe.

Acked-by: Mark Brown <broonie@kernel.org>

--AVRN0JUTTuR+6v5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqwIACgkQJNaLcl1U
h9DTzAf+NmJvooER0KUGxju0cXbQLPzjhe+zmzezOQJa1zXjXfgBycnhieaqK7ny
S+ZKb3sGXOFz1uf62w0rkTigz6ZBhVej2811kP/v6hOK59NgZZTJQfO8dQuSxEnT
a/yLND6ngy2gm9svEKalKOxPy9JbUJjkq+j/fHmoGQtgZJzi3MQgf8Dj9JD9Hi9K
CfKa+1VEAm39ijM8hfGOPXIHopw7PmdFfwGHkxLjmh4CRnWEhvWLFCPR+FiBQ0Sn
XrkEJ4xDFRK5m2nxMzIK4mnPEH5oNBFredP+/WQ/ak8W69Tqy7XcVG1E5yZLgzci
4Y9/xe7D3PUt6PvteNaqZANk/e1zpA==
=qXM/
-----END PGP SIGNATURE-----

--AVRN0JUTTuR+6v5a--

