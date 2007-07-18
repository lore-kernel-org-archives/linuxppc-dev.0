Return-Path: <scottwood@freescale.com>
Message-ID: <469E3C11.1090809@freescale.com>
Date: Wed, 18 Jul 2007 11:13:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 17/61] bootwrapper: Add 8xx support.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013318.GP15238@ld0162-tx32.am.freescale.net>
	<20070718033026.GG18251@localhost.localdomain>
In-Reply-To: <20070718033026.GG18251@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Jul 17, 2007 at 08:33:18PM -0500, Scott Wood wrote:
> [snip]
> 
>>diff --git a/arch/powerpc/boot/cuboot-8xx.c b/arch/powerpc/boot/cuboot-8xx.c
>>new file mode 100644
>>index 0000000..35476a0
>>--- /dev/null
>>+++ b/arch/powerpc/boot/cuboot-8xx.c
>>@@ -0,0 +1,47 @@
>>+/*
>>+ * Old U-boot compatibility for 8xx
>>+ *
>>+ * Author: Scott Wood <scottwood@freescale.com>
>>+ *
>>+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify it
>>+ * under the terms of the GNU General Public License version 2 as published
>>+ * by the Free Software Foundation.
>>+ */
>>+
>>+#include "ops.h"
>>+#include "stdio.h"
>>+#include "cuboot.h"
>>+
>>+#define TARGET_8xx
>>+#define TARGET_HAS_ETH1
> 
>            ^^^^^^^^^^^^^^^
> Is that really true for all 8xx boards?

Well, no.  Even on a given board, it depends on the version of u-boot.

There's nothing after enet1addr that the bootwrapper cares about, 
though, so the only harm is if the device tree has a second network 
interface but u-boot doesn't know about it, and the bootwrapper ends up 
pulling in junk rather than leaving zeroes.

-Scott
