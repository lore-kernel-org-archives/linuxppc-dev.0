Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAC9EB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 00:24:31 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
Date: Mon, 20 Feb 2012 13:24:22 +0000
Message-ID: <4F424985.2020706@freescale.com>
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
In-Reply-To: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> console_initcall() is not defined for modules.

Hmmm... the patch you posted is a good short-term fix, but I wonder if=20
makes sense for the driver to support modules at all.  I have this in the=20
driver:

#include <linux/module.h>
...
module_init(ehv_bc_init);
module_exit(ehv_bc_exit);

although to be honest, I can't remember the last time I tried to compile=20
it as a module.

The problem stems from the fact that it's a console driver *and* a tty=20
driver.  It makes sense that a tty driver can be compiled as a module, but=
=20
not a console driver.

So Greg, can I do something like this:

#ifdef MODULE
module_initcall(ehv_bc_console_init)
#else
console_initcall(ehv_bc_console_init);
#endif

--=20
Timur Tabi
Linux kernel developer at Freescale=
