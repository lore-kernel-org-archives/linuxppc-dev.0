Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A707C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:01:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A21260C3F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A21260C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLyb5McpzDrP6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:01:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYF4DvdzDshb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4DbKYD1Bbyz9sWg; Wed, 10 Feb 2021 23:57:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYC2HcJz9sW2; Wed, 10 Feb 2021 23:57:34 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210201012503.940145-1-mpe@ellerman.id.au>
References: <20210201012503.940145-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/akebono: Fix unmet dependency errors
Message-Id: <161296171938.3178259.4921214324490062203.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:34 +1100 (AEDT)
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
Cc: f.fainelli@gmail.com, rdunlap@infradead.org, yury.norov@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Feb 2021 12:25:03 +1100, Michael Ellerman wrote:
> The AKEBONO config has various selects under it, including some with
> user-selectable dependencies, which means those dependencies can be
> disabled. This leads to warnings from Kconfig.
> 
> This can be seen with eg:
> 
>   $ make allnoconfig
>   $ ./scripts/config --file build~/.config -k -e CONFIG_44x -k -e CONFIG_PPC_47x -e CONFIG_AKEBONO
>   $ make olddefconfig
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/akebono: Fix unmet dependency errors
      https://git.kernel.org/powerpc/c/665d8d58761cba41147fe7e98e2ceed1cbf603a2

cheers
