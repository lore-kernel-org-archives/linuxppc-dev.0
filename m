Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C5606A332
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6dxepis
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR6Xr2jTYz2xLG;
	Sat, 14 Nov 2026 06:20:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794597628;
	cv=none; b=HEchnbyVy3woXVaQ514FAXVZRnYzUYIM+T6kI4MxCgjVRUSfh1rgTejVp5dSyaadtczClnTjE3dBv2p7/CdQz4AI5rznj8qpAZqy3lZ9CznHJ+gSF0wiUTILKTGnnwgYbxDSvVkPJhwMEyIGrm6z5kUUFNQwTEpvbcEQUF2h1LgtQNxPApeQXLK7A49LqEJisBsLFyi8cdwRigPPRXhGxysxY2EIP+kAFxJJ2Z2iwNRUiHirsWGsH/3Ubu5Q78gRqu7heFOGdYfXxbQyrFzkL6KWmLFYlaih50Jk/sJV3XelQTBfRAEQyQFhvbilwW4P48/LbNae46h/5uNiN/I+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794597628; c=relaxed/relaxed;
	bh=Yme8xVrfiJB9JtUWZsCWQb4f6bpQ8C2lB7x46RDJgew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+0O9CI1I2w16wAD457I1CCblz6kKc0FYvFfE1lgLwVkcPAWE+oCAtK29i137bMPAC/1cR865X4r+VEEn1BoCqAek0E9BXIqH2K48/pWAw54cOHBJuDZXSucsJVYHA/WmdvK5cpKYWa93j3/EWqlUnES2wcMYJ9hyVVXT6O7ttK/YCevFZ/RhYrU62b3iWr/X90/vwCzALNhWlZ20c6qgIGjtA+jijZYzcvK81pUleHlnWfUbYiT5nPh7IQfbWn76DoJvEZQ5GZVy8uMJPcMkwVndZwtTdB2odEK+Yk0XT38sDJIjZGs6uerit+wD3EpOCmSAotM4MAfmRiUO4Wriw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6dxepis; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6dxepis;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR6Xq3Zy7z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 06:20:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0896061D75;
	Fri, 13 Nov 2026 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40361F000C4;
	Fri, 13 Nov 2026 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597624;
	bh=Yme8xVrfiJB9JtUWZsCWQb4f6bpQ8C2lB7x46RDJgew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W6dxepisHpNNsxivi81mY2JUyom8vDvbtSJGZ79fX/VnHuW46WgDlfEp5w7M4L57I
	 LCYDzH5U0zSkM86UX6S5jGE9QpxapZ2vXxyGRwBFCxzwa1hnqIs2B5C1sd9o1Obgcp
	 MFZVnbFcDAFxRX01z+kkFJPV818yQD1kIbDRb8w1KLadEiSWsjM6L69B0/DeYUaKKJ
	 JnHV9Zjv20wthE9X+dPxf1pxS/GCxyevGUDxAU7fMzVkPg2hHRB2S01RE3gZ9BRIKm
	 zBYjPZQY9VUggt4Lrn/MTj4XrA5pKIELlXIqABDX1noeaFuneVjKllspDykcclkRE9
	 OuumQ6HJ3hVhQ==
Date: Fri, 13 Nov 2026 19:20:17 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@infradead.org>, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 6/6] ARM: add CONFIG_VMSPLIT_2G_OPT option
Message-ID: <avdfH-r5kDSrPUI4@gremlin>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-7-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-7-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:28PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
> of lowmem on Arm. Since 2GiB is still a relatively common configuration
> on embedded systems, it makes sense to allow this to be used in
> non-highmem builds.
>
> Add the Kconfig option and make this the default for non-LPAE builds
> with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
> the vmsplit to be on a gigabyte boundary, so this is only available for
> classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
>
> Tested in qemu -M virt, both with and without HIGHMEM enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With sashiko fix, LGTM and:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/arm/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 797705a94b28..8992fedfdf37 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1025,7 +1025,8 @@ config BL_SWITCHER_DUMMY_IF
>  choice
>  	prompt "Memory split"
>  	depends on MMU
> -	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
> +	default VMSPLIT_2G if ARM_LPAE
> +	default VMSPLIT_2G_OPT if HIGHMEM
>  	default VMSPLIT_3G_OPT
>  	help
>  	  Select the desired split between kernel and user memory.
> @@ -1042,6 +1043,9 @@ choice
>  		bool "3G/1G user/kernel split (for full 1G low memory)"
>  	config VMSPLIT_2G
>  		bool "2G/2G user/kernel split"
> +	config VMSPLIT_2G_OPT
> +		depends on !ARM_LPAE
> +		bool "2G/2G user/kernel split (for full 2G low memory)"
>  	config VMSPLIT_1G
>  		bool "1G/3G user/kernel split"
>  endchoice
> @@ -1050,6 +1054,7 @@ config PAGE_OFFSET
>  	hex
>  	default PHYS_OFFSET if !MMU
>  	default 0x40000000 if VMSPLIT_1G
> +	default 0x70000000 if VMSPLIT_2G_OPT
>  	default 0x80000000 if VMSPLIT_2G
>  	default 0xB0000000 if VMSPLIT_3G_OPT
>  	default 0xC0000000
> @@ -1058,6 +1063,7 @@ config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN
>  	default 0x1f000000 if PAGE_OFFSET=0x40000000
> +	default 0x4f000000 if PAGE_OFFSET=0x70000000
>  	default 0x5f000000 if PAGE_OFFSET=0x80000000
>  	default 0x9f000000 if PAGE_OFFSET=0xC0000000
>  	default 0x8f000000 if PAGE_OFFSET=0xB0000000
> --
> 2.53.0
>

--
Cheers, Lorenzo

