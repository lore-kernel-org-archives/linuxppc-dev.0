Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0C48DDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 18:39:05 +1100 (EST)
Date: Thu, 17 Jan 2008 23:38:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc8-mm1 build failure on headers_check
Message-Id: <20080117233853.1b782123.akpm@linux-foundation.org>
In-Reply-To: <479050BF.1090107@linux.vnet.ibm.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<479050BF.1090107@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Jan 2008 12:39:51 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Hi Andrew,
> 
> The kernel build fails during the headers_check on power box
> 
>   CHECK   include/asm/nvram.h
> /usr/local/autobench/autotest/tmp/build/linux/usr/include/asm/nvram.h requires linux/list.h, which does not exist in exported headers
> make[3]: *** [/usr/local/autobench/autotest/tmp/build/linux/usr/include/asm/.check.nvram.h] Error 1

doh.

--- a/include/asm-powerpc/nvram.h~include-asm-powerpc-nvramh-needs-listh-fix
+++ a/include/asm-powerpc/nvram.h
@@ -11,7 +11,6 @@
 #define _ASM_POWERPC_NVRAM_H
 
 #include <linux/errno.h>
-#include <linux/list.h>
 
 #define NVRW_CNT 0x20
 #define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
@@ -59,6 +58,9 @@ struct nvram_header {
 };
 
 #ifdef __KERNEL__
+
+#include <linux/list.h>
+
 struct nvram_partition {
 	struct list_head partition;
 	struct nvram_header header;
_
