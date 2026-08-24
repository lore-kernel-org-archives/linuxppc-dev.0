Return-Path: <linuxppc-dev+bounces-26058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AA0C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 07:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT2Yx3CtPz2y2c;
	Mon, 24 Aug 2026 17:27:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787556469;
	cv=none; b=Gng2Ue/eHZ+4jFtGdaUnCaPMJjZrRY/A+WzKlXPeTE9fQEy9mqh7pyTA0dB3Ck/lx1vAA9xXMFP8MSPTNkC9hhUHoJdqBnMIBQVx+5zwTR1HKpF02OGIR0Z7PXXrsIPRYHyYtNyqYZZG7nxoBTkp2IWfnjXMWm5wh9K/XVwnPhxJsBNgKL5gRC//3MFVy6kg9ZMYMGo4PHsY3BGg5Q8VauthZR8MLSbyaIis3mLK4NcaefFtsYX3NfVFYgCYqqxdX+zxqNl5TPKTfQF20zBKciTSmqM4RLMcDFlbaEfTkXrQU2gwdJZXy/CxYyNu2etI7n3KlbdfEMtwXsCa3wARpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787556469; c=relaxed/relaxed;
	bh=hpXldSP37oQmlhckItfAzwUOG6JobW41WzP0kSdLesI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CXMOFNQF2Ee5K8tIqbRwbaN/yBjA4eNBViipbS36VIkEh+9ovKD3cBqCOCVjFAgfZGu7elvdqhVcXvtIRGdvfWp54zijLL/737UMUswQwAR4VBRHeF+vZ7cWto+Pg4ZmX9PQ1Ir/l5G50kd/nAoc0DBQo/CuPYiNQvo/8SbaWLWHL5j6jk2SbwDr9Tz9pbo+9PORnnJPScPvKc+ngyHKD21kBthJKWWHFtkcc9L2u2k1EotR78eD6eWpAVQNGxd/mpY2Yq+Jj8H8H6RrOzMh3tzsF96HtT5O1vbAI0uJ/4QCDLI3ONBrNlJnJWsytEpcwqZiQsny82KcZFAfY26VVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hghfi3F3; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hghfi3F3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT2Yw5T87z2y06
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 17:27:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 300B1600AD;
	Mon, 24 Aug 2026 07:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B017B1F000E9;
	Mon, 24 Aug 2026 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556464;
	bh=hpXldSP37oQmlhckItfAzwUOG6JobW41WzP0kSdLesI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Hghfi3F3hhjgblfEVPUEEPHALjTTBAgKBK8MbewWtmMLpyrYB+8Jo29/224FAiShM
	 0SLcU5txHHDDVRBQmZbs0Km1ZqbqYphsVzR3okw73rVZzhWFSwmbPshMJk+4ij8Gwk
	 wBlW/tVqVoMXtxSb8VWH+7r37m/WC7KmAwdV5lxYZr50+jzu/iInwaVg4PoIgWPYV+
	 C5co0jxq4J2+miGm/bYP5+zECjtlCOUz+jUuPUU4mw1mdcjIPjf5Qqh658+sfYqF50
	 oCrhxE7AzAMSOiSyXc8TzEpXzk6qb68sZUnHfTQBzsRUMB6GzKuCnUN8V+wutnGyd3
	 qgVllw8rmVK3Q==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC V3 0/8] mm: Drop pxd_ERROR()
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
Date: Mon, 24 Aug 2026 10:27:34 +0300
Message-Id: <178755645423.3606540.14531883744138096395.b4-review@b4>
X-Mailer: b4 0.17-dev

On Tue, 18 Aug 2026 09:30:33 +0530, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> mm: Drop pxd_ERROR()
> 
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


