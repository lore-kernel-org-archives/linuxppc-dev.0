Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D7B41007DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 00:46:28 +1100 (EST)
Subject: Re: [RFC PATCH 13/17] powerpc/e500: Add a new CONFIG_FSL_E5500 option
 for the e5500
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320883635-17194-14-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 10 Nov 2011 07:46:08 -0600
Message-Id: <20F26EAB-5DDA-4B65-913E-479653AD27D3@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-14-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 6:07 PM, Kyle Moffett wrote:

> As part of splitting CONFIG_E500 into separate options for e500v1/v2 =
and
> e500mc/e5500, some code only needs to be built when e5500 support is
> required.
>=20
> This adds a new internal-use config option for both 32-bit and 64-bit
> builds that enables only the e5500 support code.
>=20
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig    |    2 +-
> arch/powerpc/platforms/Kconfig.cputype |    4 ++++
> 2 files changed, 5 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
> index 248f87c..72488d4 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -231,8 +231,8 @@ endif # PPC32
> config P5020_DS
> 	bool "Freescale P5020 DS"
> 	depends on FSL_E500MC || PPC_BOOK3E_64
> +	select FSL_E5500
> 	select DEFAULT_UIMAGE
> -	select E500
> 	select PHYS_64BIT_DT_REQUIRED
> 	select SWIOTLB
> 	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/powerpc/platforms/Kconfig.cputype =
b/arch/powerpc/platforms/Kconfig.cputype
> index fd37bb2..cff45e3 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -144,6 +144,10 @@ config 8xx
> config PPC_85xx
> 	bool
>=20
> +config FSL_E5500
> +	bool
> +	select E500
> +
> config E500
> 	select FSL_EMB_PERFMON
> 	select PPC_FSL_BOOK3E
> --=20
> 1.7.2.5

Nak, I don't want to add a unique build option for 64-bit E5500 vs =
E500MC.  We have E6500 coming and I don't want to introduce =
CONFIG_FSL_E6500 at that point.

- k
