Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E8B7DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 06:27:11 +1100 (EST)
Message-ID: <45D36285.2010102@am.sony.com>
Date: Wed, 14 Feb 2007 11:27:01 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] ps3: don't call ps3_system_bus_driver_register on other
	platforms
References: <200702140704.l1E74IqP013586@toshiba.co.jp>
In-Reply-To: <200702140704.l1E74IqP013586@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: greg@kroah.com, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou wrote:
> ps3_system_bus_driver_register is PS3 platform specific function.
> On other platforms, it triggers WARN_ON in kref_get.

> +++ linux-powerpc-git/drivers/usb/host/ehci-hcd.c
> +++ linux-powerpc-git/drivers/usb/host/ohci-hcd.c

I would think we only need to modify ps3_system_bus_driver_register()
and ps3_system_bus_driver_unregister() to do the proper thing, not the
usb host drivers that make those calls.  I'll look into that solution.

-Geoff
