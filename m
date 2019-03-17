Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A00C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 09:51:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FD62148D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RHT48WtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FD62148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MZMs5mHdzDqRP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 20:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="RHT48WtL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MZL23Pr0zDqPT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 20:49:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44MZKm6L81z9v1Gs;
 Sun, 17 Mar 2019 10:49:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=RHT48WtL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sT8CcZf2zqfl; Sun, 17 Mar 2019 10:49:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44MZKm4yBTz9v1Gr;
 Sun, 17 Mar 2019 10:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552816188; bh=JexzP74NgSbTGG53tnkwucClhQLnIRsH+m7fBdRtOTs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RHT48WtLIMtMkQo0fZKjG2YrPTJUajDMYzGvPHaJKIzQnxFucv14A9rE7wZB20Aab
 tyx4u30RPwBu5PwgHOARnDBFCbJO5tUppMh538IPlcfQJpNKEKNZ17MjxrlLnjnAOP
 ObbMlyAdD+8Y4sWLwO9qLzjtpyKwU0i9ro9VOMj8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 837258B847;
 Sun, 17 Mar 2019 10:49:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZuaFFjIe5l_3; Sun, 17 Mar 2019 10:49:51 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 907238B750;
 Sun, 17 Mar 2019 10:49:50 +0100 (CET)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-2 tag
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <87y35f6osv.fsf@concordia.ellerman.id.au>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <ee209282-4e53-7709-4df0-439d36e15048@c-s.fr>
Date: Sun, 17 Mar 2019 10:49:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87y35f6osv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190316-4, 16/03/2019), Outbound message
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
Cc: yanaijie@huawei.com, aik@ozlabs.ru, aneesh.kumar@linux.ibm.com,
 linux-kernel@vger.kernel.org, malat@debian.org, joel@jms.id.au,
 andrew.donnellan@au1.ibm.com, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

Le 16/03/2019 à 12:28, Michael Ellerman a écrit :
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Linus,
> 
> Please pull a few small powerpc updates for 5.1:
> 
> The following changes since commit 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff:
> 
>    powerpc/32: Clear on-stack exception marker upon exception return (2019-03-04 00:37:23 +1100)
> 
> are available in the git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-2
> 
> for you to fetch changes up to de3c83c2fd2b87cf68214eda76dfa66989d78cb6:
> 
>    powerpc/64s: Include <asm/nmi.h> header file to fix a warning (2019-03-13 15:03:13 +1100)
> 
> - ------------------------------------------------------------------
> powerpc fixes for 5.1 #2
> 
> One fix to prevent runtime allocation of 16GB pages when running in a VM (as
> opposed to bare metal), because it doesn't work.
> 
> A small fix to our recently added KCOV support to exempt some more code from
> being instrumented.
> 
> Plus a few minor build fixes, a small dead code removal and a defconfig update.
> 
> Thanks to:
>    Alexey Kardashevskiy, Aneesh Kumar K.V, Christophe Leroy, Jason Yan, Joel
>    Stanley, Mahesh Salgaonkar, Mathieu Malaterre.

Looks like the fix for 6xx/hash use of SPRN_SPRG_PGDIR is not there.

Patch at https://patchwork.ozlabs.org/patch/1053385/
(Or at https://patchwork.ozlabs.org/patch/1054213/ with better commit text)

Without that patch, 6xx with hash table silently loop forever in 
pagefault handler while trying to start init, as reported from 
linux-next by Guenter Roeck (see 
https://patchwork.ozlabs.org/patch/1046041/)

Thanks
Christophe

> 
> - ------------------------------------------------------------------
> Alexey Kardashevskiy (1):
>        powerpc/powernv: Fix compile without CONFIG_TRACEPOINTS
> 
> Aneesh Kumar K.V (1):
>        powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR configuration
> 
> Jason Yan (1):
>        powerpc: remove dead code in head_fsl_booke.S
> 
> Joel Stanley (1):
>        powerpc/configs: Sync skiroot defconfig
> 
> Mahesh Salgaonkar (1):
>        powerpc/mm: Disable kcov for SLB routines
> 
> Mathieu Malaterre (1):
>        powerpc/64s: Include <asm/nmi.h> header file to fix a warning
> 
> 
>   arch/powerpc/configs/skiroot_defconfig       | 12 +++++++++---
>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 ++++++++
>   arch/powerpc/kernel/head_fsl_booke.S         |  7 -------
>   arch/powerpc/kernel/traps.c                  |  1 +
>   arch/powerpc/mm/Makefile                     |  3 +++
>   arch/powerpc/platforms/powernv/opal-call.c   |  1 +
>   6 files changed, 22 insertions(+), 10 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> 
> iQIcBAEBAgAGBQJcjN2tAAoJEFHr6jzI4aWA/jIQAK4J2VQD8Sw+2kSm3h7wW18U
> +BDyc7fbbigQyBHFkMAdybRKsXMSCbco7jK12yUbh5xqYlo8Hc40DbKI32f0D3WE
> 7rRotjalxR9tF+u0+m8Pdge42bPmEyt6p/7w5Ys+wVj/KXqlwTJinqSvp5Qmrilk
> 19qOTaTCXEMJ7dFTXqlFNpBW+0kaahCZ6f767dPPKkiYSm/qMZjKG/KCejLDAGQL
> x5ouTpPos8sOjts7dwJuBGCxTfU7usKpy1EbguIklzYjedk1MSh5sg6STTQsH8Y4
> kAgd8T12Wo4cQPaBmjwTkD7BrCdWbjNcK5U61kKAByshM3ZyPo+xARyQMdIWVZJQ
> pX51tjmKwzGk3nf1UiMP/jdx55Cj6rhr3EsfQepjocMa9t6IWNVpasAvFRPlw8ca
> Xmhbqsjwy9wKroAYgITq1L+VfeDe+dXBgK7yrChpqSdU89iOYgjoUbnwI+OeSCbk
> Hm8w1p5+7CNxRxNzBieqBCtYUIlEwjP3rOwuNEpb0dJ4USD4jEr/8Mk0YXWJj4yg
> mplyFwUXBrWVQHlKRI2tabO8rY7KN8H+SC/EczvERxpLRc3m7dH3DIlMi8A4a9Lk
> QyvoQY7n9fZw1lm+/6ORMCNSc8lkIrsDu44rgn7WpaZDbN1woia0q5AtsNDU9jr2
> HwUoI/HIHq5FWRu4m6LN
> =TNMo
> -----END PGP SIGNATURE-----
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

