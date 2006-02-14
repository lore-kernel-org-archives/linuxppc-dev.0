Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3002267B26
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2006 08:26:43 +1100 (EST)
Date: Tue, 14 Feb 2006 22:26:37 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] kprobes needs emulate_step()
Message-ID: <20060214212637.GA12380@suse.de>
References: <20060214131050.GA25820@suse.de> <20060214195442.GA21583@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060214195442.GA21583@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Feb 14, Christoph Hellwig wrote:

> On Tue, Feb 14, 2006 at 02:10:50PM +0100, Olaf Hering wrote:
> > 
> > KPROBES depends on XMON.
> > arch/powerpc/lib/step.c is only compiled if CONFIG_XMON is enabled.
> > 
> > arch/powerpc/kernel/built-in.o:
> > In function `resume_execution':arch/powerpc/kernel/kprobes.c:331: undefined reference to
> > `.emulate_step'
> 
> Please compile step.o if either CONFIG_KPROBES or CONFIG_XMON is defined
> instead of adding a depency.
(This one seems to work without warning about duplicate object files or
something.)

KPROBES needs emulate_step()

arch/powerpc/kernel/built-in.o:
In function `resume_execution':arch/powerpc/kernel/kprobes.c:331: undefined reference to
`.emulate_step'

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/lib/Makefile |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.16-rc3-olh/arch/powerpc/lib/Makefile
===================================================================
--- linux-2.6.16-rc3-olh.orig/arch/powerpc/lib/Makefile
+++ linux-2.6.16-rc3-olh/arch/powerpc/lib/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PPC64)	+= checksum_64.o cop
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   strcase.o
 obj-$(CONFIG_PPC_ISERIES) += e2a.o
+obj-$(CONFIG_KPROBES)	+= sstep.o
 obj-$(CONFIG_XMON)	+= sstep.o
 
 ifeq ($(CONFIG_PPC64),y)
