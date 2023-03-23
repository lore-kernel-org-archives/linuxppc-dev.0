Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C835DC6FD1D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Mar 2023 10:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pj1TD2bl3z3cfY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Mar 2023 21:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=<UNKNOWN>)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pj1Sd4fnYz3c2j
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2023 21:15:45 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 93C88B81EBF;
	Thu, 23 Mar 2023 10:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B040BC4339C;
	Thu, 23 Mar 2023 10:15:36 +0000 (UTC)
Date: Thu, 23 Mar 2023 10:15:33 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 02/14] arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZBwmxbRJrF8RxZEp@arm.com>
References: <20230323092156.2545741-1-rppt@kernel.org>
 <20230323092156.2545741-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323092156.2545741-3-rppt@kernel.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Zi Yan <ziy@nvidia.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 23, 2023 at 11:21:44AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> It is not a good idea to change fundamental parameters of core memory
> management. Having predefined ranges suggests that the values within
> those ranges are sensible, but one has to *really* understand
> implications of changing MAX_ORDER before actually amending it and
> ranges don't help here.
> 
> Drop ranges in definition of ARCH_FORCE_MAX_ORDER
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e60baf7859d1..bab6483e4317 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1489,9 +1489,7 @@ config XEN
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
>  	default "13" if ARM64_64K_PAGES
> -	range 11 13 if ARM64_16K_PAGES
>  	default "11" if ARM64_16K_PAGES
> -	range 10 15 if ARM64_4K_PAGES
>  	default "10"

I don't mind rewriting the help text as in the subsequent patch but I'd
keep the ranges as a safety measure. It's less wasted time explaining to
people why some random max order doesn't work. Alternatively, we can
drop the ranges but make this option configurable only if EXPERT.

-- 
Catalin
