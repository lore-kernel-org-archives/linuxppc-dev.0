Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC232C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:22:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9713206E5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9713206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch0QJ6sCgzDqLB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 23:22:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cgzsj6RRJzDqdW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 22:57:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Cgzsg3RSRz9sRK; Wed, 25 Nov 2020 22:57:42 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 anton@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, nathanl@linux.ibm.com
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v13 0/8] powerpc: switch VDSO to C implementation
Message-Id: <160630540103.2174375.15062873523136699514.b4-ty@ellerman.id.au>
Date: Wed, 25 Nov 2020 22:57:42 +1100 (AEDT)
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 3 Nov 2020 18:07:11 +0000 (UTC), Christophe Leroy wrote:
> This is a series to switch powerpc VDSO to generic C implementation.
> 
> Changes in v13:
> - Reorganised headers to avoid the need for a fake 32 bits config for building VDSO32 on PPC64
> - Rebased after the removal of powerpc 601
> - Using DOTSYM() macro to call functions directly without using OPD
> - Explicitely dropped .opd and .got1 sections which are now unused
> 
> [...]

Patch 1 applied to powerpc/next.

[1/8] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing CPU_FTRS_GENERIC_32
      https://git.kernel.org/powerpc/c/78665179e569c7e1fe102fb6c21d0f5b6951f084

cheers
