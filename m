Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1F429DDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 10:44:19 +1100 (EST)
Date: Wed, 19 Dec 2007 17:50:37 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
Message-ID: <20071219235037.GA2309@lixom.net>
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
	<47698773.1010004@freescale.com>
	<20071219211250.GA21416@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071219211250.GA21416@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 12:12:50AM +0300, Anton Vorontsov wrote:

> I though about it. Is your device tree source out of tree? Otherwise
> it should be trivial to upgrade the dtb, instead of producing cruft in
> the kernel. I vote for less legacy code, but lets see what others will
> say. So far count is 1:1. ;-)

It's not just that. kexec:ing a new kernel from an older that has the
old device tree breaks if you don't consider older device trees. Or you
might have an old firmware with a flashed device tree that you need to
keep compatibility with.

You should either fix up the "broken" (not latest and greatest) device
trees in the wrapper before using them, or make sure that your code is
still compatible with the old trees.

The fact that the device tree source code is distributed with the kernel
isn't an excuse to break backwards compatibility with older versions.


-Olof
