Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 09:41:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E8A2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XQEQAx14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E8A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447v3F20TvzDqMC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 20:41:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XQEQAx14"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447v1F0gbNzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 20:39:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 447v156GFBz9v4dR;
 Tue, 26 Feb 2019 10:39:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XQEQAx14; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id AEtuCHN-VBZi; Tue, 26 Feb 2019 10:39:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 447v154VmLz9v4dC;
 Tue, 26 Feb 2019 10:39:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551173993; bh=xXN40Vwh3wlW58Ru/d+ATref4NUOHAbtkcxEYxTw9f8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XQEQAx14WqfxOb84WHrUxBfYREKIED6UeGfi6KDRZDRQllYu/vYFPJjwlE/Rfojr8
 lmvx7cLgup/SnFq3gMW8cIQu4uSTlOiPsLzVy131gRrGhOG+8utK02I80wcS+lyrOn
 722UJ1I5mw0DBBIn9is+IeE5BYZKh/xMQAQRTYuE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A1BD28B91F;
 Tue, 26 Feb 2019 10:39:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MO9wNNl0kpjR; Tue, 26 Feb 2019 10:39:54 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DB268B912;
 Tue, 26 Feb 2019 10:39:54 +0100 (CET)
Subject: Re: build failure of current mmotm with skiroot_defconfig
To: Mike Rapoport <rppt@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190226081224.GA11981@rapoport-lnx>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
Date: Tue, 26 Feb 2019 10:39:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226081224.GA11981@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/02/2019 à 09:12, Mike Rapoport a écrit :
> Hi,
> 
> I've encountered the following error when building skyroot_defconfig with
> current mmotm tree:
> 
> make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux- ARCH=powerpc vmlinux
>    ...
>    CC      arch/powerpc/kernel/dbell.o
> In file included from arch/powerpc/kernel/dbell.c:20:
> arch/powerpc/include/asm/kvm_ppc.h: In function 'xics_on_xive':
> arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function 'xive_enabled'; did you mean 'eeh_enabled'? [-Werror=implicit-function-declaration]
>    return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
>           ^~~~~~~~~~~~
>           eeh_enabled

I can neither find the above in arch/powerpc/include/asm/kvm_ppc.h in 
the powerpc tree, nor a patch removing it.

Where does that comes from ?

Christophe

> cc1: all warnings being treated as errors
> scripts/Makefile.build:278: recipe for target 'arch/powerpc/kernel/dbell.o' failed
> make[3]: *** [arch/powerpc/kernel/dbell.o] Error 1
> scripts/Makefile.build:493: recipe for target 'arch/powerpc/kernel' failed
> make[2]: *** [arch/powerpc/kernel] Error 2
> Makefile:1049: recipe for target 'arch/powerpc' failed
> make[1]: *** [arch/powerpc] Error 2
> 
> 
