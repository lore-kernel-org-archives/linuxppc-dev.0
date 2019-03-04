Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E87C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 13:57:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A28206B8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JxWGIw6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A28206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ChRW2TqRzDqJj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 00:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="JxWGIw6L"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ChP72BZzzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 00:55:20 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ChNs696tz9v4fD;
 Mon,  4 Mar 2019 14:55:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=JxWGIw6L; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WmAUoYQa360v; Mon,  4 Mar 2019 14:55:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ChNs54PBz9v4dx;
 Mon,  4 Mar 2019 14:55:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551707709; bh=Aa0XKSQN+EWeMMM7AQTBGeBF408jUCk+J37X0eSfOPc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JxWGIw6L7axArpjX+SHXqWMLF+SkRJHiqHPXREbL7f1cMQ8zLXHC9tosKWhpzaASl
 pD98RVoFlxDsKgO3uqpXI33zqkHW8Byhr8iVZlCcLwMwvTWWsxCDqyKmHZi8OShauz
 INfRrUjqfXvDL0U5AvyfJ3OZyvNHJMIXqi+e7HhE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 24F758B768;
 Mon,  4 Mar 2019 14:55:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZUFDg7vxz4qp; Mon,  4 Mar 2019 14:55:14 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B84928B792;
 Mon,  4 Mar 2019 14:55:13 +0100 (CET)
Subject: Re: [PULL REQUEST] powerpc generic command line
To: Daniel Walker <danielwa@cisco.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e80b18e3-92fe-3726-a7d7-72f98cdd0b86@c-s.fr>
Date: Mon, 4 Mar 2019 14:55:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> Here are the generic command line changes for powerpc.
> 
> These changes have been in linux-next for two cycles, with few problems reported.
> It's also been used at Cisco Systems, Inc. in production products for many many
> years with no problems.
> 
> Please pull these changes.
> 
> 
> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> 
>    Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> 
> are available in the git repository at:
> 
>    https://github.com/daniel-walker/cisco-linux.git for-powerpc
> 
> for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
> 
>    powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
> 
> ----------------------------------------------------------------
> Daniel Walker (3):
>        add generic builtin command line
>        powerpc: convert to generic builtin command line
>        powerpc: convert config files to generic cmdline

Hello,

This series is in total contradiction with the work being done to add 
KASAN support to powerpc.

It also modifies the behaviour for powerpc.

Please do not apply this series as is, see my comments on the individual 
patchs for details.

Thanks
Christophe

> 
>   arch/powerpc/Kconfig                          | 23 +--------
>   arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++-----
>   arch/powerpc/configs/44x/iss476-smp_defconfig | 24 ++++-----
>   arch/powerpc/configs/44x/warp_defconfig       | 12 ++---
>   arch/powerpc/configs/holly_defconfig          | 12 ++---
>   arch/powerpc/configs/mvme5100_defconfig       | 25 +++++-----
>   arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++---------
>   arch/powerpc/configs/storcenter_defconfig     | 15 +++---
>   arch/powerpc/kernel/prom.c                    |  4 ++
>   arch/powerpc/kernel/prom_init.c               |  8 +--
>   arch/powerpc/kernel/prom_init_check.sh        |  2 +-
>   include/linux/cmdline.h                       | 72 +++++++++++++++++++++++++++
>   init/Kconfig                                  | 69 +++++++++++++++++++++++++
>   13 files changed, 231 insertions(+), 112 deletions(-)
>   create mode 100644 include/linux/cmdline.h
> 
