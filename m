Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F609B6EEA
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 07:59:08 +1100 (EST)
Received: from mail97-tx2 (localhost.localdomain [127.0.0.1])	by
	mail97-tx2-R.bigfish.com (Postfix) with ESMTP id 51FF35C859B	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 20:59:05 +0000 (UTC)
Received: from TX2EHSMHS028.bigfish.com (unknown [10.9.14.240])	by
	mail97-tx2.bigfish.com (Postfix) with ESMTP id 7CF9219C0052	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 20:59:03 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o98Kx2O8015712	for <linuxppc-dev@ozlabs.org>;
	Fri, 8 Oct 2010 13:59:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o98KtHdK027021	for <linuxppc-dev@ozlabs.org>;
	Fri, 8 Oct 2010 15:55:17 -0500 (CDT)
Date: Fri, 8 Oct 2010 15:55:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 07/11] powerpc/fsl-booke: Add support for FSL 64-bit
	e5500 core
Message-ID: <20101008155516.626967fb@udp111988uds.am.freescale.net>
In-Reply-To: <1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Oct 2010 14:06:49 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index d361f81..19083b3 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -132,13 +132,18 @@ config PPC_E500MC
>  	select PPC_FPU
>  	depends on E500
>  
> +config PPC_E5500
> +	bool
> +	select PPC_FPU
> +	select PPC_E500MC if PPC32

Currently E500MC implies E500.  With this, E5500 would not imply E500
-- hence all the ifdefs with E500 || E5500 that this adds.  When would
we want to ifdef E500 or E500MC but not E5500?

Given how similar e500mc and e5500 are, I think we should just use
CONFIG_E500MC for it.  Any 32/64-bit distinctions would just check
CONFIG_PPC64, CONFIG_BOOK3E_64, or similar.

-Scott
