Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D64EDDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 06:27:41 +1100 (EST)
Date: Thu, 17 Jan 2008 11:27:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.24-rc8-mm1: powerpc: include/asm/nvram.h:62: error: field
	'partition' has incomplete type
Message-Id: <20080117112755.896f2c74.akpm@linux-foundation.org>
In-Reply-To: <200801171918.09645.m.kozlowski@tuxland.pl>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801171918.09645.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008 19:18:07 +0100 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

>   CC [M]  sound/ppc/awacs.o
> In file included from sound/ppc/awacs.c:24:
> include/asm/nvram.h:62: error: field 'partition' has incomplete type
> make[1]: *** [sound/ppc/awacs.o] Error 1
> make: *** [sound/ppc/awacs.o] Error 2

hm.

--- a/include/asm-powerpc/nvram.h~include-asm-powerpc-nvramh-needs-listh
+++ a/include/asm-powerpc/nvram.h
@@ -11,6 +11,7 @@
 #define _ASM_POWERPC_NVRAM_H
 
 #include <linux/errno.h>
+#include <linux/list.h>
 
 #define NVRW_CNT 0x20
 #define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
_

I wonder why mainline isn't busted actually.
