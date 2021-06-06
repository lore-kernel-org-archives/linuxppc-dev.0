Return-Path: <SRS0=3A4D=LA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75906C47096
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:16:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18516613EF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18516613EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fyb7m24fGz3ds6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 22:16:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fyb3J5W9Lz30D8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jun 2021 22:12:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fyb3H68zTz9sXS; Sun,  6 Jun 2021 22:12:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20210512202809.95363-1-danielhb413@gmail.com>
References: <20210512202809.95363-1-danielhb413@gmail.com>
Subject: Re: [PATCH v2 0/4] Unisolate LMBs DRC on removal error + cleanups
Message-Id: <162298131981.2353459.7679023338118080572.b4-ty@ellerman.id.au>
Date: Sun, 06 Jun 2021 22:08:39 +1000
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
Cc: david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 12 May 2021 17:28:05 -0300, Daniel Henrique Barboza wrote:
> changes from v1:
> - patch 1: added David's r-b
> - patch 2:
>     * removed the DRCONF_MEM_RESERVED assumption for
>     dlpar_memory_remove_by_ic()
>     * reworded the commit msg
> - patch 3: dropped. the differences between dlpar_memory_remove_by_ic()
>   and dlpar_memory_remove_by_count() makes a helper function too complex
>   to handle both cases
> - (new) patch 3 and 4: minor enhancements
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/pseries: Set UNISOLATE on dlpar_memory_remove_by_ic() error
      https://git.kernel.org/powerpc/c/feb0e079f43dee055701c1a294785d37341d6f97
[2/4] powerpc/pseries: check DRCONF_MEM_RESERVED in lmb_is_removable()
      https://git.kernel.org/powerpc/c/2ad216b4d6ff0f92fc645c1bd8838f04fbf09b9d
[3/4] powerpc/pseries: break early in dlpar_memory_remove_by_count() loops
      https://git.kernel.org/powerpc/c/163e7921750f6cd965666f472c21de056c63dcbc
[4/4] powerpc/pseries: minor enhancements in dlpar_memory_remove_by_ic()
      https://git.kernel.org/powerpc/c/40999b041e03b32434b2f4a951668e9865a3cb6b

cheers
