Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C51C5AE5E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 23:14:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DC32054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 23:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DC32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hGx120hlzDrBc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 10:14:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hGvM39VJzDr0N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 10:13:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43hGvM1ZX9z8sxv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 10:13:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43hGvM0xxMz9sDT; Sat, 19 Jan 2019 10:13:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43hGvK6nDWz9sDP
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2019 10:13:01 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0INCkQM002275;
 Fri, 18 Jan 2019 17:12:46 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x0INCiql002273;
 Fri, 18 Jan 2019 17:12:44 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 18 Jan 2019 17:12:43 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] powerpc/64s: Add slb_full_bitmap rather than
 hard-coding U32_MAX
Message-ID: <20190118231243.GV14180@gate.crashing.org>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-2-mpe@ellerman.id.au>
 <20190117163017.GS14180@gate.crashing.org>
 <87ef9a40bb.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef9a40bb.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 11:28:24PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> 
> > On Thu, Jan 17, 2019 at 11:13:26PM +1100, Michael Ellerman wrote:
> >> The recent rewrite of the SLB code into C included the assumption that
> >> all CPUs we run on have at least 32 SLB entries. This is currently
> >> true but a bit fragile as the SLB size is actually defined by the
> >> device tree and so could theoretically change at any time.
> >
> > It also is guaranteed by the architecture, since at least 2.02, FWIW.
> 
> True. Actually 2.00 says at least 32.
> 
> Unfortunately we don't live in a world where "the architecture
> guarantees it" has any bearing on reality :)

It's a pretty strong hint.  I don't remember any hardware where it is not
true, either.  (That might be selective memory ;-) )

> But given it *should* always be at least 32 maybe I should optimise for
> that case. We could use a static key to skip the U32_MAX comparison and
> go down the else path.

Ah that sounds like a good idea :-)


Segher
