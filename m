Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6928BDE78A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:15:54 +1100 (EST)
Message-ID: <47E93350.6090806@freescale.com>
Date: Tue, 25 Mar 2008 12:16:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] CPM1: implement GPIO LIB API
References: <47E92EC8.7010700@scram.de>
In-Reply-To: <47E92EC8.7010700@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
> index 7fd224c..e12cbf0 100644
> --- a/arch/powerpc/platforms/8xx/Kconfig
> +++ b/arch/powerpc/platforms/8xx/Kconfig
> @@ -4,6 +4,8 @@ config FADS
>  config CPM1
>  	bool
>  	select CPM
> +	select GENERIC_GPIO
> +	select GPIO_LIB

Shouldn't this depend on the user enabling GPIO support?  Some 8xx 
boards are very memory-constrained, so we don't want to be making the 
kernel even bigger than it already is unless it's actually needed.

-Scott
