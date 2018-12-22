Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA94C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:22:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721AF219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721AF219FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MNQB1GkkzDqcF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:22:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MMvX2vDWzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 21:59:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43MMvM4WvbzB09ZF;
 Sat, 22 Dec 2018 11:59:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 5VKYeJhGg9ss; Sat, 22 Dec 2018 11:59:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43MMvM3TdXzB09ZD;
 Sat, 22 Dec 2018 11:59:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AB448B785;
 Sat, 22 Dec 2018 11:59:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id c65tkpDvU0p9; Sat, 22 Dec 2018 11:59:30 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 18B6E8B74B;
 Sat, 22 Dec 2018 11:59:30 +0100 (CET)
Subject: Re: Pull request: scottwood/linux.git next
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181222044250.GA7651@home.buserror.net>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <f6c6b33a-f228-2ef6-6e94-8161c6440d9d@c-s.fr>
Date: Sat, 22 Dec 2018 11:50:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181222044250.GA7651@home.buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 181222-0, 22/12/2018), Outbound message
X-Antivirus-Status: Clean
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Scott,

Le 22/12/2018 à 05:42, Scott Wood a écrit :
> Highlights include elimination of legacy clock bindings use from dts
> files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
> some minor cleanup.
> 
> The following changes since commit 8c6c942d33f2a79439e86f8f406afae40a5bc767:
> 
>    powerpc/eeh: Fix debugfs_simple_attr.cocci warnings (2018-12-20 22:59:03 +1100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to 5f470b3638a4ed03df79b993ece819cac2f4ca7e:
> 
>    powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL (2018-12-21 22:07:54 -0600)
> 
> ----------------------------------------------------------------
> Alexandre Belloni (1):
>        powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
> 
> Christoph Hellwig (1):
>        powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
> 
> Christophe Leroy (1):
>        powerpc/83xx: handle machine check caused by watchdog timer

kbuild robot reported a build failure, most likely due to missing 
asm/debug.h
Did you fix it or do you need an updated patch ?

Christophe

> 
> Sabyasachi Gupta (1):
>        arch/powerpc/fsl_rmu: Use dma_zalloc_coherent
> 
> Scott Wood (3):
>        powerpc/fsl: Use new clockgen binding
>        powerpc/dts/fsl: Fix dtc-flagged interrupt errors
>        powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL
> 
> Yuantian Tang (1):
>        clk: qoriq: add more compatibles strings
> 
>   .../devicetree/bindings/clock/qoriq-clock.txt      |   6 +
>   arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   4 +-
>   arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  15 ---
>   arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         | 128 ++++++++++-----------
>   arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     | 128 ++++++++++-----------
>   arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |   2 +
>   arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |   4 +-
>   arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  18 ---
>   arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  18 ---
>   arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  70 -----------
>   arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |  16 +--
>   arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   4 +-
>   arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  18 ---
>   arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |  47 --------
>   arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |  30 -----
>   arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  16 ---
>   arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   4 +-
>   arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  44 -------
>   arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  22 ----
>   arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   8 +-
>   arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  61 ----------
>   arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  24 ++--
>   arch/powerpc/boot/dts/mpc832x_rdb.dts              |   4 -
>   arch/powerpc/configs/fsl-emb-nonhw.config          |   1 +
>   arch/powerpc/include/asm/cputable.h                |   1 +
>   arch/powerpc/include/asm/reg.h                     |   2 +
>   arch/powerpc/kernel/cputable.c                     |  10 +-
>   arch/powerpc/platforms/83xx/misc.c                 |  17 +++
>   arch/powerpc/sysdev/fsl_pci.c                      |   6 +-
>   arch/powerpc/sysdev/fsl_rio.h                      |   2 +-
>   arch/powerpc/sysdev/fsl_rmu.c                      |   4 +-
>   36 files changed, 218 insertions(+), 556 deletions(-)
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

