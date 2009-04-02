Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id DFED6DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 23:36:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: [v0 PATCH 5/5] EDAC: CPC925 MC platform device setup
Date: Thu, 2 Apr 2009 14:36:44 +0200
References: <1238652440-9224-1-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-5-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-6-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1238652440-9224-6-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904021436.44822.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com, linux-kernel@vger.kernel.org,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 April 2009, Harry Ciao wrote:
> +#ifdef CONFIG_EDAC
> +#define CPC925_MC_START=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00=
xf8000000
> +#define CPC925_MC_END=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xf8ffffff /* sizeof =
16MB */
> +/* Register a platform device for CPC925 memory controller */
> +static int __init maple_cpc925_edac_setup(void)

It's not good to have these encoded as magic numbers.
Can't you find the addresses in the device tree? Maybe it's
even possible to make this an of_platform_driver if you
find a good node to bind to.

Does the driver also work on a G5 Mac, or is it limited
to the maple platform?

	Arnd <><
