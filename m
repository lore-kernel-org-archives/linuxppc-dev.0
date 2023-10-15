Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A2CCDB47E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Oct 2023 10:12:25 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Jgv8/cUx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S7bdh2jlGz3vd8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Oct 2023 21:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Jgv8/cUx;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S7bVl6vdYz3vhH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2023 21:06:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1697364383;
	bh=lQ471ge3JT3D/IyXiBK6OqZg4gy00/Wz1cpF1NMX1CI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jgv8/cUxgQM27y6U//UT8VctmRJrqlUlqIr1QQTvvhugWnDzvcBYSj+SLZifK2jTQ
	 owmdqqRmmp8iY6chJq2Mlnpjbq6RAj8jt0kTavOSSUm2KQgIWHKXgDY5hnkI1rXRb9
	 NIdVXDDuIe1rtwQ5evX8B8s9Peo+r//MyCvLnEJu3WQv7amCnhXoAL+d5jvpc0YjYY
	 35406tFs9oyMdUOOMphj3mCWt3yUm5zVp0ckK6CxgcejWbG+0vkHDPW3MGFNsWQ5DX
	 tEUDQT8EKLC+kMhx0X8thKh1EhRV8sMxpXYvKiRh1qX2qbrIMTQ4XvICpOiJdoeKvz
	 ZQx5NpTCbYS3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVc4t2xz4wnw;
	Sun, 15 Oct 2023 21:06:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: reiserfs-devel@vger.kernel.org, Peter Lafreniere <peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Subject: Re: (subset) [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-Id: <169736429854.960528.1442206910501555108.b4-ty@ellerman.id.au>
Date: Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: tsbogend@alpha.franken.de, jack@suse.cz, linux-sh@vger.kernel.org, ink@jurassic.park.msu.ru, richard@nod.at, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, linux-alpha@vger.kernel.org, linux@armlinux.org.uk, johannes@sipsolutions.net, richard.henderson@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, anton.ivanov@cambridgegreys.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 18 Sep 2023 17:56:09 +0000, Peter Lafreniere wrote:
> ReiserFS has been considered deprecated for 19 months since commit
> eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> several architectures that still build it into their defconfig kernels.
> 
> As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> from defconfig files before the filesystem's removal.
> 
> [...]

Applied to powerpc/next.

[2/7] arch: powerpc: remove ReiserFS from defconfig
      https://git.kernel.org/powerpc/c/c945e6f453a361b0e9daddd2be9c099d1b80d6f8

cheers
