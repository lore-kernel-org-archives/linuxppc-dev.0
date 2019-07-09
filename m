Return-Path: <SRS0=CkO+=VG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF08C73C41
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 13:38:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FFC20861
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 13:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FFC20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jk1K0Hq6zDqXs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 23:38:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jjy56MkwzDqVN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 23:35:57 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x69DZgCw003161;
 Tue, 9 Jul 2019 08:35:42 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x69DZfPa003160;
 Tue, 9 Jul 2019 08:35:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 9 Jul 2019 08:35:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190709133540.GJ30355@gate.crashing.org>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org> <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> Le 08/07/2019 à 21:14, Nathan Chancellor a écrit :
> >On Mon, Jul 08, 2019 at 11:19:30AM +1000, Michael Ellerman wrote:
> >>On Fri, 2019-05-10 at 09:24:48 UTC, Christophe Leroy wrote:
> >>>Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
> >>>that are summed to obtain the target address. Using 'Z' constraint
> >>>and '%y0' argument gives GCC the opportunity to use both registers
> >>>instead of only one with the second being forced to 0.
> >>>
> >>>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> >>>Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >>Applied to powerpc next, thanks.
> >>
> >>https://git.kernel.org/powerpc/c/6c5875843b87c3adea2beade9d1b8b3d4523900a
> >>
> >>cheers
> >
> >This patch causes a regression with clang:
> 
> Is that a Clang bug ?

I would think so, but cannot tell from the given information.

> Do you have a disassembly of the code both with and without this patch 
> in order to compare ?

That's what we need to start debugging this, yup.

> Segher, any idea ?

There is nothing I recognise, no.


Segher
