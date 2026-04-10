Return-Path: <linuxppc-dev+bounces-19580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8158CF44851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:19:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbT61y8Kz2yjn;
	Fri, 10 Apr 2026 22:19:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823562;
	cv=none; b=HnetdeTYdpRPRyrIvtgdS1GmlZS1T6PMR2oJGkjcDERTsgsIOucao/Dce1ha6SE4mCEb1BckLZO8nBasCk5q8aQH3JRAwH814mG3J0CkeiL7I821CX/ieey6aKnWrluCA6raI7JzxE/h3SLm1Br0rDZgs1ibtGgYmJEx8Qulf0DcxJqO9VfthB/htB1Im4bEtDUChHXAHaPsSZrE3v4oH9ma1g0LnPaZnvnVfyL2NZZFsTdyPE0KfOkpIhVKa767GvLPWJYYFaoDG/1bcVF3KLIWa+sxeXYp//ORTwVJro/iEg3ZnR+L9b//y0Xvqo6/3DP+Tcj1YShMniWMfpd6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823562; c=relaxed/relaxed;
	bh=M9a5EG3CG8Udn3B7jIZCxrZ3k3coZbiW9xz1Wj8kXaE=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RFXPb5UwC6aN5gVPgdaeNFGeC9y9dcwnCyMF7+yj2UWBohHRK/bb3F6XKorhBTWtWtPYPAUxBVo0wy788FgQWMEXNKHkjT31RJ1yJmV/TzOd8slgewmCcYWEAUCOk1qd+PARIgB6mi7ioagryaQVGgVnbTKWrA+KSJWbrpZ/iEVbquRiNLhlDyQS8AixnickwSIsYJ6mGudmlS2rTaHytpPhir04lth/VswAoFSRCjodbjGpgejqV2GOv5yZmo5T7AvAIR+Pobp0PR1BRFALYY0PvmUwzO/op2XvrNaK0qK/G+5Oi5YaNHINf/oIOmtKeqDXZYugIFK1G0S8Mf7c3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VM13lKS0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VM13lKS0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbT53t9Dz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:19:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E547D4047B;
	Fri, 10 Apr 2026 12:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E7C2BC87;
	Fri, 10 Apr 2026 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823559;
	bh=p4ul6fecafqSjuz/HWiW1SqReHpNi3SQC1heaf7AtH8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VM13lKS0vi1Fampzs2SOJUSl5pFNtZPRrbRXrfYUkEg7syYn7CVko7c7egIdexCfj
	 MaRLNlopnK85+N7I7i3OZHuHcMdHWNGNdlJV5bSYYI//COctIU1M1ukOOe7R86fGRN
	 QQ/j+jjVi+CYY1R1j+UlDL84K4FAOhCbq1OrkH36o+f5XviRftg90dsfUTYhZvjNV5
	 hk3/t6EuYClXGdWJA1CVm0r4gv7+Uuy+bWtd/uVuLx4/iO4+bV/Z+fKbXLcG7tmKkB
	 b/7xC9trAvx6oz1zNsW6Ny9Eav33gyvB9AokHXFATxUfQATArxGnp5TkYcwejIeG8o
	 hkZquPfDoH+3g==
Date: Fri, 10 Apr 2026 14:19:16 +0200
Message-ID: <20260410120318.253872322@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 10/38] arcnet: Remove function timing code
References: <20260410120044.031381086@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

ARCNET is a museums piece and the function timing can be done with
ftrace. Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: netdev@vger.kernel.org
---
 drivers/net/arcnet/arc-rimi.c  |    4 ++--
 drivers/net/arcnet/arcdevice.h |   20 +-------------------
 drivers/net/arcnet/com20020.c  |    6 ++----
 drivers/net/arcnet/com90io.c   |    6 ++----
 drivers/net/arcnet/com90xx.c   |    4 ++--
 5 files changed, 9 insertions(+), 31 deletions(-)

--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -291,7 +291,7 @@ static void arcrimi_copy_to_card(struct
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + 0x800 + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_toio", count, memcpy_toio(memaddr, buf, count));
+	memcpy_toio(memaddr, buf, count);
 }
 
 static void arcrimi_copy_from_card(struct net_device *dev, int bufnum,
@@ -300,7 +300,7 @@ static void arcrimi_copy_from_card(struc
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + 0x800 + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_fromio", count, memcpy_fromio(buf, memaddr, count));
+	memcpy_fromio(buf, memaddr, count);
 }
 
 static int node;
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -11,7 +11,6 @@
 #ifndef _LINUX_ARCDEVICE_H
 #define _LINUX_ARCDEVICE_H
 
-#include <asm/timex.h>
 #include <linux/if_arcnet.h>
 
 #ifdef __KERNEL__
@@ -62,7 +61,7 @@
 #define D_RX		512	/* show rx packets                        */
 #define D_SKB		1024	/* show skb's                             */
 #define D_SKB_SIZE	2048	/* show skb sizes			  */
-#define D_TIMING	4096	/* show time needed to copy buffers to card */
+#define D_TIMING	4096	/* Not longer supported. Use tracing instead */
 #define D_DEBUG         8192    /* Very detailed debug line for line */
 
 #ifndef ARCNET_DEBUG_MAX
@@ -95,23 +94,6 @@ do {									\
 		pr_cont(fmt, ##__VA_ARGS__);				\
 } while (0)
 
-/* see how long a function call takes to run, expressed in CPU cycles */
-#define TIME(dev, name, bytes, call)					\
-do {									\
-	if (BUGLVL(D_TIMING)) {						\
-		unsigned long _x, _y;					\
-		_x = get_cycles();					\
-		call;							\
-		_y = get_cycles();					\
-		arc_printk(D_TIMING, dev,				\
-			   "%s: %d bytes in %lu cycles == %lu Kbytes/100Mcycle\n", \
-			   name, bytes, _y - _x,			\
-			   100000000 / 1024 * bytes / (_y - _x + 1));	\
-	} else {							\
-		call;							\
-	}								\
-} while (0)
-
 /*
  * Time needed to reset the card - in ms (milliseconds).  This works on my
  * SMC PC100.  I can't find a reference that tells me just how long I
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -70,8 +70,7 @@ static void com20020_copy_from_card(stru
 	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
-	TIME(dev, "insb", count,
-	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count);
 }
 
 static void com20020_copy_to_card(struct net_device *dev, int bufnum,
@@ -84,8 +83,7 @@ static void com20020_copy_to_card(struct
 	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
-	TIME(dev, "outsb", count,
-	     arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count);
 }
 
 /* Reset the card and check some basic stuff during the detection stage. */
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -332,15 +332,13 @@ static void com90io_setmask(struct net_d
 static void com90io_copy_to_card(struct net_device *dev, int bufnum,
 				 int offset, void *buf, int count)
 {
-	TIME(dev, "put_whole_buffer", count,
-	     put_whole_buffer(dev, bufnum * 512 + offset, count, buf));
+	put_whole_buffer(dev, bufnum * 512 + offset, count, buf);
 }
 
 static void com90io_copy_from_card(struct net_device *dev, int bufnum,
 				   int offset, void *buf, int count)
 {
-	TIME(dev, "get_whole_buffer", count,
-	     get_whole_buffer(dev, bufnum * 512 + offset, count, buf));
+	get_whole_buffer(dev, bufnum * 512 + offset, count, buf);
 }
 
 static int io;			/* use the insmod io= irq= shmem= options */
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -633,7 +633,7 @@ static void com90xx_copy_to_card(struct
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_toio", count, memcpy_toio(memaddr, buf, count));
+	memcpy_toio(memaddr, buf, count);
 }
 
 static void com90xx_copy_from_card(struct net_device *dev, int bufnum,
@@ -642,7 +642,7 @@ static void com90xx_copy_from_card(struc
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_fromio", count, memcpy_fromio(buf, memaddr, count));
+	memcpy_fromio(buf, memaddr, count);
 }
 
 MODULE_DESCRIPTION("ARCnet COM90xx normal chipset driver");


