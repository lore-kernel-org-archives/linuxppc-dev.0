Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 53459DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 17:26:44 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 21 Sep 2007 09:26:41 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070921072641.58620@gmx.net>
MIME-Version: 1.0
Subject: Triggered BUG_ON in prom.c/of_get_flat_dt_root()
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I was able to boot the first cuImage build from a 2.6.23-rc7 kernel source
on my AmigaOne. Unfortunately the kernel triggers a BUG_ON statement in
of_get_flat_dt_root(), which is called in the probe function of my
platform code.
I wasn't able to capture the kernel log, but it looks similar to this:

Invalid tag 0 scanning flattened device tree !
Invalid tag 0 scanning flattened device tree !
Invalid tag 0 scanning flattened device tree !
Invalid tag 0 scanning flattened device tree !
Bug in prom.c at line 162.

This is the cuboot-amigaone.c file:
#include "ops.h"
#include "stdio.h"
#include "cuboot.h"

#include "ppcboot.h"

static bd_t bd;
extern char _dtb_start[], _dtb_end[];

static void platform_fixups(void)
{
        dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
        dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4,
                            bd.bi_busfreq);
}

void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                   unsigned long r6, unsigned long r7)
{
        CUBOOT_INIT();
        ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
        serial_console_init();
        platform_ops.fixups = platform_fixups;
}

The device tree compiles fine, so I wonder what could trigger this
problem. Any ideas?

Thanks!

regards,

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
