Return-Path: <olof@lixom.net>
Date: Wed, 22 Aug 2007 19:26:37 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@ozlabs.org
Subject: [PATCH] Move serial_dev_init to device_initcall()
Message-ID: <20070823002637.GA24332@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
initcall is now called before I/O space is setup, but it's dependent on
it being available.

Since there's no way to make dependencies between initcalls, we'll just
have to move it to device_initcall(). Yes, it's suboptimal but I'm not
aware of any better solution at this time.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

I think I might have one of the few hardware platforms with UART on PIO,
at least if noone else has already hit this. It was introduced by BenH's
rewrite of the I/O space allocation earlier, and the problem is that by
the time serial_dev_init() runs, the hose io_base_virt isn't available.

I still see the platform devices register before the PCI ones, so it
looks like init order is undisturbed by this change. Still, it'd be good
to hear test feedback from other platforms as needed. It's uncertain what
platforms the comments above serial_dev_init() about needing overrides
applies for, so I don't know which ones might be sensitive to call order
changes.


Index: mainline/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- mainline.orig/arch/powerpc/kernel/legacy_serial.c
+++ mainline/arch/powerpc/kernel/legacy_serial.c
@@ -493,7 +493,7 @@ static int __init serial_dev_init(void)
 
 	return platform_device_register(&serial_device);
 }
-arch_initcall(serial_dev_init);
+device_initcall(serial_dev_init);
 
 
 /*
