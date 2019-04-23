Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C8C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:15:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6956921738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cEWmbTVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6956921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pMq71rvBzDqLV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:15:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cEWmbTVd"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pMmx1dt5zDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 22:13:50 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pMmm62sFz9tyxp;
 Tue, 23 Apr 2019 14:13:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=cEWmbTVd; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9cm37OnEqL7j; Tue, 23 Apr 2019 14:13:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pMmm4vgMz9tyxn;
 Tue, 23 Apr 2019 14:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556021624; bh=ZSWCQaVKOW7fqWiLpfrxZ7imR8ZOa4ryrSiJZ5Tq0mA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cEWmbTVdTNTgSTtkHxh/k/ds0PhuGIznZTxQM6o+rfiNRInWTRWye9bjOqbFSdYsM
 VQqVx7YA5VnaONLNuw3WWgbkyBUttl+3GJpuC3AfQGYEH+eRkHkRj4PcD6upgTgx0/
 MxVmm3n3KmXDDHsATcTMNUh4yRCBlTgt6LLXEohI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 068118B8D6;
 Tue, 23 Apr 2019 14:13:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6UB9kJNgSZdG; Tue, 23 Apr 2019 14:13:45 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 76ED38B8C4;
 Tue, 23 Apr 2019 14:13:45 +0200 (CEST)
Subject: Re: [powerpc:next-test 40/58] WARNING: vmlinux.o(.text+0xb038):
 Section mismatch in reference from the function setup_kup() to the function
 .init.text:setup_kuep()
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
References: <201904220037.le30gXgO%lkp@intel.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1d55b63d-3f7d-b8f5-03c8-ac59a3a98acf@c-s.fr>
Date: Tue, 23 Apr 2019 14:13:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904220037.le30gXgO%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild test robot <lkp@intel.com>,
 kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russel, Michael,

Looks like the reported problem comes from b28c97505eb1 ("powerpc/64: 
Setup KUP on secondary CPUs") 
(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=b28c97505eb1a5265e367c398c3406be6ce5e313)

Is it really necessary to remove the __init tag on setup_kup() ?

Christophe

Le 21/04/2019 à 18:23, kbuild test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
> head:   26ad26718dfaa7cf49d106d212ebf2370076c253
> commit: 06fbe81b5909847aa13f9c86c2b6f9bbc5c2795b [40/58] powerpc/8xx: Add Kernel Userspace Execution Prevention
> config: powerpc-mpc885_ads_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 06fbe81b5909847aa13f9c86c2b6f9bbc5c2795b
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.2.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> All warnings (new ones prefixed by >>):
> 
>>> WARNING: vmlinux.o(.text+0xb038): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuep()
>     The function setup_kup() references
>     the function __init setup_kuep().
>     This is often because setup_kup lacks a __init
>     annotation or the annotation of setup_kuep is wrong.
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
