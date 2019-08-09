Return-Path: <SRS0=hB4d=WF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04506C433FF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Aug 2019 22:13:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37908208C3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Aug 2019 22:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37908208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 464zyj02BxzDrQV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Aug 2019 08:13:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464zwN0ymWzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2019 08:11:15 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x79MAsUH030114;
 Fri, 9 Aug 2019 17:10:54 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x79MArRl030113;
 Fri, 9 Aug 2019 17:10:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 9 Aug 2019 17:10:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
Message-ID: <20190809221052.GP31406@gate.crashing.org>
References: <87h873zs88.fsf@concordia.ellerman.id.au>
 <20190809182106.62130-1-ndesaulniers@google.com>
 <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
 <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
 <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
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
Cc: kbuild test robot <lkp@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 09, 2019 at 10:12:56PM +0200, Arnd Bergmann wrote:
> @@ -106,7 +106,7 @@ static inline u##size name(const volatile u##size
> __iomem *addr)    \
>  {                                                                      \
>         u##size ret;                                                    \
>         __asm__ __volatile__("sync;"#insn" %0,%y1;twi 0,%0,0;isync"     \
> -               : "=r" (ret) : "Z" (*addr) : "memory");                 \
> +               : "=r" (ret) : "m" (*addr) : "memory");                 \
>         return ret;                                                     \
>  }

That will no longer compile something like
  u8 *p;
  u16 x = in_le16(p + 12);
(you'll get something like "invalid %y value, try using the 'Z' constraint").

So then you remove the %y, but that makes you get something like
  sync;lhbrx 3,12(3);twi 0,3,0;isync
which is completely wrong.


Segher
