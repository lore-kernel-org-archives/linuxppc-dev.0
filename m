Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5703C1975A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 06:25:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64B020719
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 06:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64B020719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nJ4y0PLHzDqg8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 17:25:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 48nJ376KXFzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 17:23:31 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02P6NOmb001139;
 Wed, 25 Mar 2020 01:23:25 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 02P6NNtI001138;
 Wed, 25 Mar 2020 01:23:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 25 Mar 2020 01:23:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] powerpc/boot: Delete unneeded .globl _zimage_start
Message-ID: <20200325062323.GS22482@gate.crashing.org>
References: <20200325051820.163253-1-maskray@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325051820.163253-1-maskray@google.com>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>, clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 24, 2020 at 10:18:20PM -0700, Fangrui Song wrote:
> .globl sets the symbol binding to STB_GLOBAL while .weak sets the
> binding to STB_WEAK. They should not be used together. It is accidetal
> rather then intentional that GNU as let .weak override .globl while
> clang integrated assembler let the last win.

Nothing is "overridden".

The as manual says (.weak):

  This directive sets the weak attribute on the comma separated list of
  symbol 'names'.  If the symbols do not already exist, they will be
  created.

so this behaviour is obviously as intended (or was later documented in
any case), so LLVM has a bug to fix (whether you like this (much saner)
behaviour or not).


Segher
