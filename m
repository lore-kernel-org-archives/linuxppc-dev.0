Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE748C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:30:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D79610A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D79610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcps5gLvz3c6t
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:30:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcp41FRJz30Ng
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:31 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcp31Dnzz9sWT; Sun, 11 Apr 2021 00:29:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
References: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Remove powerpc specific definition of
 'ptrdiff_t'
Message-Id: <161806493833.1467223.5146603896377356295.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 5 Apr 2021 09:57:27 +0000 (UTC), Christophe Leroy wrote:
> For unknown reason, old commit d27dfd388715 ("Import pre2.0.8")
> changed 'ptrdiff_t' from 'int' to 'long'.
> 
> GCC expects it as 'int' really, and this leads to the following
> warning when building KFENCE:
> 
>   CC      mm/kfence/report.o
> In file included from ./include/linux/printk.h:7,
>                  from ./include/linux/kernel.h:16,
>                  from mm/kfence/report.c:10:
> mm/kfence/report.c: In function 'kfence_report_error':
> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
>       |                  ^~~~~~~~
> ./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
>   343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~
> mm/kfence/report.c:213:3: note: in expansion of macro 'pr_err'
>   213 |   pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%td):\n",
>       |   ^~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Remove powerpc specific definition of 'ptrdiff_t'
      https://git.kernel.org/powerpc/c/c46bbf5d2defae50d61ddf31502017ee8952af83

cheers
