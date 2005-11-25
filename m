Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id CD569687FB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 00:28:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Nov 2005 14:28:17 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FE122@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linuxppc-embedded@ozlabs.org>
Subject: Badness in 2.6.15-rc1 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone seen this when booting 2.6.15-rc1 on 8xx?
  Mount-cache hash table entries: 512
  Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346
  Call trace:
   [c00039e8] check_bug_trap+0x80/0xa8
   [c0003c1c] program_check_exception+0x20c/0x480
   [c00031e0] ret_from_except_full+0x0/0x4c
   [c01b86b8] dma_alloc_init+0x40/0xcc
   [c000225c] init+0x8c/0x288
   [c00050ac] kernel_thread+0x44/0x60
  NET: Registered protocol family 16
The kernel boots just fine into user space so it seems harmless, but I
suspect it will bite me later.

Something anoying:
Why did the new cpm_uart driver change major and minor number for the
tty?
As it is now I can't boot my 2.4 rootfs as init think it should find the
console on ttyS0.
Would be great if major and minor could be configurable.

  Jocke
