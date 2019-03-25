Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF8C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 11:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAE42063F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="eTTVZeTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE42063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SWjR2yDxzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 22:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::2; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="eTTVZeTU"; 
 dkim-atps=neutral
X-Greylist: delayed 350 seconds by postgrey-1.36 at bilbo;
 Mon, 25 Mar 2019 22:06:56 AEDT
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SWg44YRTzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 22:06:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553512011;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:Cc:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=g/erWpd/CC4TzWI2lzo3X2fzzJMZBANtSjcCh57/mmo=;
 b=eTTVZeTUM2xww6g1N0p6m+TmFLVpfH2oHZGrNbvvZ3isHcSpK53J92XXUvDLbZ2Eh/
 YS/yZQ2/yvdspaurnd3XD7quL6DABYPwhloThQ3sPSkMGlcTb8SUO3GozRyRf4pfdGi9
 uD6a/GKq9YPa8mPRjcxFMvnhbzF0CQOo06EZv1hFavfq506QvqhvkCjAoXckDtXaXrKd
 sCbZf3lji4D+0ScOiIPaABvt//ZGOzIZJ1HAOtlzfTpCwIeFBIz367ibXs+3OA1P9hVA
 eMDC+TGYR8iRwr8DGiu/ThTq0+FzNvS0taGvnpASNMrL6TB3HTuMx6PRqpu1DhVNlXJb
 es3A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7ClcjmaGPWerH/TbwNp4jUXzZO9p5Q=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:c000:5165:6743:d73b]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id n0960bv2PB0o0C8
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 25 Mar 2019 12:00:50 +0100 (CET)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: PowerPC fixes 5.1-3: CONFIG_SPARSEMEM doesn't exist in the kernel
 source code
Message-ID: <675068dc-3874-4ff3-fdf3-8b96b8e43574@xenosoft.de>
Date: Mon, 25 Mar 2019 12:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "R.T.Dickinson" <rtd@a-eon.com>, Darren Stevens <darren@stevens-zone.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

I wasn't able to compile the RC2 today because of the following error 
messages:

   CC      arch/powerpc/mm/slb.o
In file included from ./arch/powerpc/include/asm/book3s/64/mmu.h:39:0,
                  from ./arch/powerpc/include/asm/mmu.h:360,
                  from ./arch/powerpc/include/asm/lppaca.h:36,
                  from ./arch/powerpc/include/asm/paca.h:21,
                  from ./arch/powerpc/include/asm/current.h:16,
                  from ./include/linux/thread_info.h:21,
                  from ./include/asm-generic/preempt.h:5,
                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
                  from ./include/linux/preempt.h:78,
                  from ./include/linux/spinlock.h:51,
                  from ./include/linux/mmzone.h:8,
                  from ./include/linux/gfp.h:6,
                  from ./include/linux/mm.h:10,
                  from ./arch/powerpc/include/asm/cacheflush.h:12,
                  from ./arch/powerpc/include/asm/asm-prototypes.h:16,
                  from arch/powerpc/mm/slb.c:17:
./arch/powerpc/include/asm/book3s/64/mmu-hash.h:584:6: warning: 
"MAX_PHYSMEM_BITS" is not defined [-Wundef]
  #if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
       ^
arch/powerpc/mm/slb.c: In function 'slb_allocate_kernel':
arch/powerpc/mm/slb.c:697:37: error: 'MAX_PHYSMEM_BITS' undeclared 
(first use in this function)
    if ((ea & ~REGION_MASK) > (1UL << MAX_PHYSMEM_BITS))
                                      ^
arch/powerpc/mm/slb.c:697:37: note: each undeclared identifier is 
reported only once for each function it appears in
scripts/Makefile.build:278: recipe for target 'arch/powerpc/mm/slb.o' failed
make[3]: *** [arch/powerpc/mm/slb.o] Error 1
scripts/Makefile.build:489: recipe for target 'arch/powerpc/mm' failed
make[2]: *** [arch/powerpc/mm] Error 2
/home/christian/Downloads/a/Makefile:1046: recipe for target 
'arch/powerpc' failed
make[1]: *** [arch/powerpc] Error 2
Makefile:170: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

-----

The variable MAX_PHYSMEM_BITS isn't defined. The problem is in the last 
PowerPC fixes 5.1-3: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9

Commit log: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM 
configurations

Problematic fix:

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d34ad1657d7b..598cdcdd1355 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -352,7 +352,7 @@ static inline bool strict_kernel_rwx_enabled(void)
  #if defined(CONFIG_SPARSEMEM_VMEMMAP) && 
defined(CONFIG_SPARSEMEM_EXTREME) &&   \
     defined (CONFIG_PPC_64K_PAGES)
  #define MAX_PHYSMEM_BITS        51
-#else
+#elif defined(CONFIG_SPARSEMEM)
  #define MAX_PHYSMEM_BITS        46
  #endif

The first if statement isn't successfull because the variables 
CONFIG_SPARSEMEM_EXTREME and CONFIG_PPC_64K_PAGES aren't activated in 
our kernel configuration. Therefore we need MAX_PHYSMEM_BITS 46 for our 
Nemo board. Unfortunately CONFIG_SPARSEMEM doesn't exist in the kernel 
source code so we can't activate it in the kernel config.

I replaced '#elif defined(CONFIG_SPARSEMEM)' with '#else' and after that 
the compiling of the RC2 works again.

Please check if CONFIG_SPARSEMEM exists.

Thanks,
Christian
