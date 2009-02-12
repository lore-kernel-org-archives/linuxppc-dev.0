Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4994A460.8000807@am.sony.com>
Date: Thu, 12 Feb 2009 14:36:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] powerpc/ps3: Move ps3_mm_add_memory to device_initcall
References: <49935F81.7060203@am.sony.com>
In-Reply-To: <49935F81.7060203@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the PS3 hotplug memory routine ps3_mm_add_memory() from
a core_initcall to a device_initcall.

core_initcall routines run before the powerpc topology_init()
startup routine, which is a subsys_initcall, resulting in
failure of ps3_mm_add_memory() when CONFIG_NUMA=y.  When
ps3_mm_add_memory() fails the system will boot with just the
128 MiB of boot memory 

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Ben,

Please send upstream for 2.6.29, as this effects the current
Fedora 11 development kernel, and maybe other distros which
are based on 2.6.29.

 arch/powerpc/platforms/ps3/mm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -328,7 +328,7 @@ static int __init ps3_mm_add_memory(void
 	return result;
 }
 
-core_initcall(ps3_mm_add_memory);
+device_initcall(ps3_mm_add_memory);
 
 /*============================================================================*/
 /* dma routines                                                               */
