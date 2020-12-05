Return-Path: <SRS0=6dJf=FJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500CC4361A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 05:19:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AE822D2B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 05:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AE822D2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnyZ40lHrzDqk7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 16:19:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CnyXL4xNFzDqdx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2020 16:18:26 +1100 (AEDT)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <oss@buserror.net>)
 id 1klPwU-0005xK-RW; Fri, 04 Dec 2020 23:17:11 -0600
Message-ID: <d99b6d7dee253d7e2d85d863d96b8702bb1aa389.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Fri, 04 Dec 2020 23:17:09 -0600
In-Reply-To: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
References: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@csgroup.eu, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 1/2] powerpc: Retire e200 core (mpc555x processor)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-11-17 at 05:07 +0000, Christophe Leroy wrote:
> There is no defconfig selecting CONFIG_E200, and no platform.
> 
> e200 is an earlier version of booke, a predecessor of e500,
> with some particularities like an unified cache instead of both an
> instruction cache and a data cache.
> 
> Remove it.	
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Makefile                     |  1 -
>  arch/powerpc/include/asm/cputable.h       | 11 -----
>  arch/powerpc/include/asm/mmu.h            |  2 +-
>  arch/powerpc/include/asm/reg.h            |  5 --
>  arch/powerpc/include/asm/reg_booke.h      | 12 -----
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |  9 ----
>  arch/powerpc/kernel/cputable.c            | 46 ------------------
>  arch/powerpc/kernel/head_booke.h          |  3 +-
>  arch/powerpc/kernel/head_fsl_booke.S      | 57 +----------------------
>  arch/powerpc/kernel/setup_32.c            |  2 -
>  arch/powerpc/kernel/traps.c               | 25 ----------
>  arch/powerpc/mm/nohash/fsl_booke.c        | 12 ++---
>  arch/powerpc/platforms/Kconfig.cputype    | 13 ++----
>  13 files changed, 11 insertions(+), 187 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


