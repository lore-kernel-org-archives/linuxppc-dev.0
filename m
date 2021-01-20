Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92150C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 01:15:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8996E23109
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 01:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996E23109
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DL6yq6L5lzDqrZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 12:15:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DL6wX26KFzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 12:13:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by ozlabs.org (Postfix) with ESMTP id 4DL6wX17hYz9sWH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 12:13:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4DL6wW75RZz9sVy; Wed, 20 Jan 2021 12:13:31 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by ozlabs.org (Postfix) with ESMTP id 4DL6wW1Ls6z9sVr;
 Wed, 20 Jan 2021 12:13:26 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 10K1CNrC018109;
 Tue, 19 Jan 2021 19:12:24 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 10K1CLs7018104;
 Tue, 19 Jan 2021 19:12:21 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 19 Jan 2021 19:12:21 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Only test lwm/stmw on big endian
Message-ID: <20210120011221.GG30983@gate.crashing.org>
References: <20210119041800.3093047-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119041800.3093047-1-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, msuchanek@suse.de, lpechacek@suse.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Jan 19, 2021 at 03:18:00PM +1100, Michael Ellerman wrote:
> Newer binutils (>= 2.36) refuse to assemble lmw/stmw when building in
> little endian mode. That breaks compilation of our alignment handler
> test:
> 
>   /tmp/cco4l14N.s: Assembler messages:
>   /tmp/cco4l14N.s:1440: Error: `lmw' invalid when little-endian
>   /tmp/cco4l14N.s:1814: Error: `stmw' invalid when little-endian
>   make[2]: *** [../../lib.mk:139: /output/kselftest/powerpc/alignment/alignment_handler] Error 1
> 
> These tests do pass on little endian machines, as the kernel will
> still emulate those instructions even when running little
> endian (which is arguably a kernel bug).

The opposite: in older ISAs it is *required* to.  On all very old ISA
versions, and when not on the Server Environment on everything before
ISA 2.07.

Many older implementations did an alignment interrupt, but that was an
implementation detail (they could still be compliant with proper system
software support, e.g. kernel emulation handlers).  Nowadays that
interrupt is required, so you can still support it like that.

(The patch is fine of course.)


Segher
