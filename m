Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 41621DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 09:06:20 +1100 (EST)
Date: Wed, 14 Nov 2007 09:06:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc2-git3 powerpc link failure
Message-Id: <20071114090624.2a6aef50.sfr@canb.auug.org.au>
In-Reply-To: <473984E2.1040006@linux.vnet.ibm.com>
References: <473984E2.1040006@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andy, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kamalesh,

On Tue, 13 Nov 2007 16:35:06 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
>
> The 2.6.24-rc2-git3 kernel build fails during linking 
> 
>   KSYM    .tmp_kallsyms1.S
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   LD      .tmp_vmlinux3
>   KSYM    .tmp_kallsyms3.S
>   AS      .tmp_kallsyms3.o
>   LD      vmlinux.o
> ld: TOC section size exceeds 64k
> make: *** [vmlinux.o] Error 1

You need the following patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 7 Nov 2007 11:56:48 +1100
Subject: [PATCH] [POWERPC] Stop the TOC overflowing for large builds.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ca51f0c..9374bc9 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,7 +3,7 @@
 #
 
 ifeq ($(CONFIG_PPC64),y)
-EXTRA_CFLAGS	+= -mno-minimal-toc
+CFLAGS_prom_init.o	+= -mno-minimal-toc
 endif
 ifeq ($(CONFIG_PPC32),y)
 CFLAGS_prom_init.o      += -fPIC
-- 
1.5.3.5
