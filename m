Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4589AB6F91
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 05:31:39 +1000 (EST)
Received: from mail79-tx2 (localhost.localdomain [127.0.0.1])	by
	mail79-tx2-R.bigfish.com (Postfix) with ESMTP id E8F7F11052A	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2011 19:31:34 +0000 (UTC)
Message-ID: <4E56A30F.4010509@freescale.com>
Date: Thu, 25 Aug 2011 14:31:27 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: Kernel boot up
References: <07ACDFB8ECA8EF47863A613BC01BBB22035E3A70@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB22035E3A70@HYD-MKD-MBX02.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/25/2011 02:57 AM, smitha.vanga@wipro.com wrote:
> Hi Scott,
> 
> I am currently trying to bring up 2.6.39 kernel on a target based on MPC8247
> Processor, using the attched .dts  file . I get the below logs while the
> kernel is booting.
> I see that the unflattening of the device tree and the initial loading
> of the kernel and ramdisk file system is happening correctly. Can you
> point me where exactly I can look for this issue. I am attaching the
> .config and .dts file I am using.

Which error are you referring to?

> of-flash ff800000.flash: do_map_probe() failed

What kind of flash chip do you have?  Does the node in the device tree
accurately describe it (four interleaved 8-bit chips that only do JEDEC
and not CFI)?

> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> eth0: fs_enet: 00:00:00:00:00:00
> eth1: fs_enet: 00:00:00:00:00:00

These MAC addresses should have been set in the device tree.  If you're
using U-Boot, it should be doing the fixup.

> Populating /dev using udev: /sbin/udevd: '/lib/libc.so.6' library
> contains unsup
> ported TLS
> /sbin/udevd: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevd: can't load library 'libc.so.6'
> FAIL
> /sbin/udevstart: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevstart: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevstart: can't load library 'libc.so.6'
> FAIL

This is a problem with the root filesystem, not the kernel.

-Scott
