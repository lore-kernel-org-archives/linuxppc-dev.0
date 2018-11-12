Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4A5C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:45:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EC1223DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EC1223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tr8805KZzF3Ww
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 23:45:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tr5c3CsvzF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 23:43:16 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wACCh5hW005564;
 Mon, 12 Nov 2018 06:43:06 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wACCh4D9005561;
 Mon, 12 Nov 2018 06:43:04 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 12 Nov 2018 06:43:04 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
Message-ID: <20181112124302.GI23873@gate.crashing.org>
References: <20181102033713.31916-1-joel@jms.id.au>
 <CAKwvOdnVr8_bg-ND29PWihzdD_YVcGH6z+0zHZhK8nEv-k0-2A@mail.gmail.com>
 <CACPK8XcPxOot2-Abn-o0-5ECyz6KfmkUfKSh6L5+pok7eNtCFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcPxOot2-Abn-o0-5ECyz6KfmkUfKSh6L5+pok7eNtCFQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 10:03:34PM +1030, Joel Stanley wrote:
> arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
> inline asm context requiring an l-value: remove
>       the cast or build with -fheinous-gnu-extensions

...

> ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
> macro 'sub_ddmmss'
>                : "=r" ((USItype)(sh)),                                  \
>                        ~~~~~~~~~~^~~

This was fixed in GCC over 16 years ago ( https://gcc.gnu.org/r56600 ),
and in GMP (where it comes from) presumably before that.

There are many projects around which still have old GMP snippets in
them.  Like, the Linux kernel for powerpc, or GCC for x86!


Segher
