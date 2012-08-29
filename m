Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A9C892C010F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 07:59:02 +1000 (EST)
Message-ID: <503E8E6E.1010101@wwwdotorg.org>
Date: Wed, 29 Aug 2012 14:49:34 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clk: Make the generic clock API available by default
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mackerras <paulus@samba.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/28/12 13:35, Mark Brown wrote:
> Rather than requiring platforms to select the generic clock API to make
> it available make the API available as a user selectable option unless the
> user either selects HAVE_CUSTOM_CLK (if they have their own implementation)
> or selects COMMON_CLK (if they depend on the generic implementation).
>
> All current architectures that HAVE_CLK but don't use the common clock
> framework have selects of HAVE_CUSTOM_CLK added.
>
> This allows drivers to use the generic API on platforms which have no need
> for the clock API at platform level.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> @@ -674,6 +676,7 @@ config ARCH_TEGRA
>   	select GENERIC_CLOCKEVENTS
>   	select GENERIC_GPIO
>   	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK

For 3.7, Tegra will switch to the common clock framework. I think this 
patch would then disable that. How should we resolve this - rebase the 
Tegra common-clk tree on top of any branch containing this patch in 
order to remove that select statement?
