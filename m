Return-Path: <SRS0=eRxT=7Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43756C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EA520731
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EA520731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49jghP05T2zDqvg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 09:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49jgfM39D9zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 09:53:14 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 05BNqwH1028941;
 Thu, 11 Jun 2020 18:52:58 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 05BNquVt028940;
 Thu, 11 Jun 2020 18:52:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 11 Jun 2020 18:52:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
Message-ID: <20200611235256.GL31009@gate.crashing.org>
References: <49YBKY13Szz9sT4@ozlabs.org>
 <20200611224355.71174-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611224355.71174-1-ndesaulniers@google.com>
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
Cc: christophe.leroy@c-s.fr, patch-notifications@ellerman.id.au,
 linux-kernel@vger.kernel.org, npiggin@gmail.com,
 clang-built-linux@googlegroups.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 11, 2020 at 03:43:55PM -0700, Nick Desaulniers wrote:
> Segher, Cristophe, I suspect Clang is missing support for the %L and %U
> output templates [1].

The arch/powerpc kernel first used the %U output modifier in 0c176fa80fdf
(from 2016), and %L in b8b572e1015f (2008).  include/asm-ppc (and ppc64)
have had %U since 2005 (1da177e4c3f4), and %L as well (0c541b4406a6).

> I've implemented support for some of these before
> in Clang via the documentation at [2], but these seem to be machine
> specific?

Yes, almost all output modifiers are.  Only %l, %a, %n, and part of %c
are generic (and %% and %= and on some targets, %{, %|, %}).

> Can you please point me to documentation/unit tests/source for
> these so that I can figure out what they should be doing, and look into
> implementing them in Clang?

The PowerPC part of
https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
(sorry, no anchor) documents %U.

Traditionally the source code is the documentation for this.  The code
here starts with the comment
      /* Write second word of DImode or DFmode reference.  Works on register
         or non-indexed memory only.  */
(which is very out-of-date itself, it works fine for e.g. TImode as well,
but alas).

Unit tests are completely unsuitable for most compiler things like this.

The source code is gcc/config/rs6000/rs6000.c, easiest is to search for
'L' (with those quotes).  Function print_operand.

HtH,


Segher
