Return-Path: <pochini@shiny.it>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by ozlabs.org (Postfix) with ESMTP id 154D0DDE07
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 23:24:45 +1100 (EST)
Date: Sun, 22 Feb 2009 13:17:46 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: CPU hotplug /sys entries are missing on 2.6.28 [PATCH]
Message-Id: <20090222131746.9a80b647.pochini@shiny.it>
In-Reply-To: <20090218221821.ca5d29eb.pochini@shiny.it>
References: <20090218221821.ca5d29eb.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Feb 2009 22:18:21 +0100
Giuliano Pochini <pochini@shiny.it> wrote:

> /sys/devices/system/cpu/cpu*/online don't exist anymore.

I think I found the bug. Is this patch ok ?


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- linux-2.6.29-rc5/arch/powerpc/platforms/powermac/setup.c__orig	2009-02-14 00:31:30.000000000 +0100
+++ linux-2.6.29-rc5/arch/powerpc/platforms/powermac/setup.c	2009-02-21 22:44:14.000000000 +0100
@@ -746,4 +746,7 @@ define_machine(powermac) {
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
 	.cpu_die		= pmac_cpu_die,
 #endif
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+	.cpu_die		= generic_mach_cpu_die,
+#endif
 };



--
Giuliano.
