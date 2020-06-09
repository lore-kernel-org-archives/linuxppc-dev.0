Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:31:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120F520760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120F520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0cz74J7zDqbG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:31:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFn68KKzDqRx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49gzFZ19fkz9sVM; Tue,  9 Jun 2020 15:29:22 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFY3z4Cz9sVP; Tue,  9 Jun 2020 15:29:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200527145843.2761782-1-mpe@ellerman.id.au>
References: <20200527145843.2761782-1-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/4] powerpc/64s: Don't init FSCR_DSCR in __init_FSCR()
Message-Id: <159168035387.1381411.17014434723427003932.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:20 +1000 (AEST)
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
Cc: alistair@popple.id.au, mikey@neuling.org, npiggin@gmail.com,
 jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 May 2020 00:58:40 +1000, Michael Ellerman wrote:
> __init_FSCR() was added originally in commit 2468dcf641e4 ("powerpc:
> Add support for context switching the TAR register") (Feb 2013), and
> only set FSCR_TAR.
> 
> At that point FSCR (Facility Status and Control Register) was not
> context switched, so the setting was permanent after boot.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/64s: Don't init FSCR_DSCR in __init_FSCR()
      https://git.kernel.org/powerpc/c/0828137e8f16721842468e33df0460044a0c588b
[2/4] powerpc/64s: Don't let DT CPU features set FSCR_DSCR
      https://git.kernel.org/powerpc/c/993e3d96fd08c3ebf7566e43be9b8cd622063e6d
[3/4] powerpc/64s: Save FSCR to init_task.thread.fscr after feature init
      https://git.kernel.org/powerpc/c/912c0a7f2b5daa3cbb2bc10f303981e493de73bd
[4/4] powerpc/64s: Don't set FSCR bits in INIT_THREAD
      https://git.kernel.org/powerpc/c/c887ef5707591e84f80271e95e99ff9fb38987b5

cheers
