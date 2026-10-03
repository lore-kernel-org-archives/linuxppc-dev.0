Return-Path: <linuxppc-dev+bounces-28815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABDFCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 07:36:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxcrv3vSZz2y1W;
	Sat, 03 Oct 2026 17:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791012959;
	cv=none; b=j5VGj5Uqah9fe6U7GP+GzhcgPa1qyFdp5cTkiHmEtfYFSUbNR2xNkxbXn0pFo1HboF1EDF+NRTYAwc8cc58k2mhjhJMV5v6F+bvHv+qdwbS1w5hN93vRVv+jy54ppjVRKtR8p0HisOAtQKq5mzBRaBAAnzGuq9FisDF5ICYVmvicIab/gbj7FsGntqzF5qtuVXogeuN2JDMg0mDwhCteUN72QWQwNxaFBKvL/U2ZUFHSx0Geft3uPSoSI50ZW2VkVcaiDRwezSDs3C0L84PP08Vj5xD+zNEV2ubKQd2e3l7O9ux1mBkz6OxHt8J+IVa24euM/QXL3qzM5qQT1IahzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791012959; c=relaxed/relaxed;
	bh=JFPOBU+P6ZZb4SCiluBbDmaGyRTWTJXi4hi93ytzIPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzrgLzme/IKTDt6tUA6o5KSVce/19A47a/UnJQz8z1sLwFxxbxyW8WrQRYrDe4vx7ouxrSM7PWFs3WWdy1WJnRujnvSpvmhJRQ1zdrjgkcLcXig1629FmlBia2/IHhJN0rb1GR7dvrxLP06q7aqMZUUGDFSEgQ6j2gRlOEHuf+ac7O0TTXwcccKQ8qmfRZZQg3kO2QWYZJ3M+4oiLcpgQj+UIrG+Fqk/W2Ou0rBxAZj4WgugWW9gme9ZPqK1FeHguRvZB0+GaMwc4gKHYkBnleR+8Jl/8/9aYEBXwYVcdDo7rqEDRTBKdSYdW31U3fDx6BUIfGiszSLSt/Fu6BIp+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuSqPlG2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuSqPlG2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxcrt03ksz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 17:35:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6B9E602C2;
	Sat,  3 Oct 2026 07:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B591F0089B;
	Sat,  3 Oct 2026 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791012953;
	bh=JFPOBU+P6ZZb4SCiluBbDmaGyRTWTJXi4hi93ytzIPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OuSqPlG2cg1hKygLYSI8va59uM7xCTKh9l5yIwpsd6kif0nV24Hd0hp75TdCmztzT
	 GInBgJi0hBta0500J9FGWq1yihGbAFQZfoXV9iKh7jD22cRJLtpEcQM1noSEOlGWM4
	 Am+yt5rFwEWgqYVwWQ33gVeVEtpZU4+kycrmBsquHF1S7+1sg1VZcVC33grUmYHyYw
	 TKBiWHKIy9IYuMMABhhMebZF//GA897ynfBTpNmPvnSJLH+O9XCPzjr+T1hhDEXXIX
	 Vyg47z4n19JGz0NetMfF99FACWEyPMmNJxtU+Z04DrOQZzlbDcxcGnuzG96SWBjert
	 Zmtj/Sa2hkD4A==
Date: Sat, 3 Oct 2026 09:35:49 +0200
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/boot: Drop unused min_t()/max_t() helpers
Message-ID: <asCwVazUjoGp6Bjh@kernel.org>
References: <20260828130622.576064-3-blum@kernel.org>
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
In-Reply-To: <20260828130622.576064-3-blum@kernel.org>

On Fri, Aug 28, 2026 at 03:06:22PM +0200, Thorsten Blum wrote:
> Commit c762c69e106f ("powerpc/boot: Add support for XZ compression")
> added min_t() and max_t() to support XZ in the boot wrapper. However,
> since commit 9f121705503a ("lib/xz: replace min_t with min") XZ no
> longer depends on these helpers. Remove them from the boot wrapper.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Mention the commit that removed XZ's dependency on min_t(), fixing the
>   build failure seen with v1
> - v1: https://lore.kernel.org/r/20260525091839.817778-3-thorsten.blum@linux.dev/
> ---
>  arch/powerpc/boot/types.h | 3 ---
>  1 file changed, 3 deletions(-)

Gentle ping?

Thanks,
Thorsten

