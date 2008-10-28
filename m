Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id A226BDDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 09:48:08 +1100 (EST)
Date: Tue, 28 Oct 2008 15:41:11 -0700
Subject: Reserving Early RAM Regions and Porting Denx's CONFIG_LOGBUFFER to
	arch/powerpc
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Message-ID: <C52CE317.12884%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am working on attempting to migrate the Denx CONFIG_LOGBUFFER feature from
arch/ppc:

http://git.denx.de/?p=linux-2.6-denx.git;a=blob_plain;f=arch/ppc/mm/init.c;h
b=3df65660bbfa769b10b141351b0ea10427b0b709
http://git.denx.de/?p=linux-2.6-denx.git;a=blob_plain;f=kernel/printk.c;hb=3
df65660bbfa769b10b141351b0ea10427b0b709

In the historical implementation, basically, u-boot (if so configured)
allocates 16 KiB + 4 KiB of memory at the end of physical RAM to store log
messages that are compatible with the Linux kernel's printk. When Linux (if
so configured with CONFIG_LOGBUFFER) starts up, it redirects the normal
log_buf to this "external log buffer" and appends any existing printk
messages to those already pushed by u-boot. Future printk messages are then
sent off to this new "external log buffer".

What is the preferred method for hiding/reserving chunks of memory such as
this during early boot? The device tree? The 'mem=' parameter? Adding an
lmb_reserve() in prom.c:early_reserve_mem()? Twiddling things auto-magically
such as the historical implementation? Some combination thereof?

The arch/ppc historical implementation simply twiddled total_memory and
total_lowmem and then ioremap'd the 20 KiB off the end of memory.

However, such an approach in arch/powerpc falters because an attempt to
prematurely reduce total_lowmem results in mapin_ram(), via mmu_mapin_ram(),
only covering part of the total, say 128 MiB or 256 MiB, RAM with 16 MiB and
4 MiB large pages, leaving a residual, of say 4 MiB, to cover with smaller 4
KiB map_page() pages.

However, when map_page() runs, it eventually calls lmb_alloc_base() which
returns a page in that 4 MiB "tail" unmapped region. This then explodes due
to a page fault when clear_page() is called on the page in unmapped RAM at
the dcbz instruction in clear_pages().

Regards,

Grant
