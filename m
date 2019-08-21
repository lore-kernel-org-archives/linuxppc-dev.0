Return-Path: <SRS0=9oUV=WR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F5C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 11:46:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1C422D6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C422D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46D5Ts3QVfzDr4g
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 21:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D5Rh2FRjzDqsq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2019 21:44:31 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7LBiNDR002345;
 Wed, 21 Aug 2019 06:44:24 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7LBiN5q002343;
 Wed, 21 Aug 2019 06:44:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 21 Aug 2019 06:44:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH] powerpc/vdso64: inline __get_datapage()
Message-ID: <20190821114423.GC31406@gate.crashing.org>
References: <6662919bd80773aaf339e85b14af1ea1ddbfd841.camel@kernel.crashing.org>
 <20190821092959.16066-1-santosh@fossix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092959.16066-1-santosh@fossix.org>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Wed, Aug 21, 2019 at 02:59:59PM +0530, Santosh Sivaraj wrote:
> except for a couple of calls (1 or 2 nsec reduction), there are no
> improvements in the call times. Or is 10 nsec the minimum granularity??
> 
> So I don't know if its even worth updating vdso64 except to keep vdso32 and
> vdso64 equal.

Calls are cheap, in principle...  It is the LR stuff that can make it
slower on some cores, and a lot of calling sequence stuff may have
considerable overhead of course.

> +.macro get_datapage ptr, tmp
> +	bcl	20,31,888f
> +888:
> +	mflr	\ptr
> +	addi	\ptr, \ptr, __kernel_datapage_offset - 888b
> +	lwz	\tmp, 0(\ptr)
> +	add	\ptr, \tmp, \ptr
> +.endm

(You can just write that as
	bcl 20,31,$+4
	mflr \ptr
etc.  Useless labels are useless :-) )

One thing you might want to do to improve performance is to do this without
the bcl etc., because you cannot really hide the LR latency of that.  But
that isn't very many ns either...  Superscalar helps, OoO helps, but it is
mostly just that >100MHz helps ;-)


Segher
