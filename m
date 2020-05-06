Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02FC4724C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB4020736
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB4020736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49HQJ25y2SzDqRS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 04:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49HPlB0ykxzDr2s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2020 04:10:13 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 046I9r6r015436;
 Wed, 6 May 2020 13:09:53 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 046I9rPL015416;
 Wed, 6 May 2020 13:09:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 6 May 2020 13:09:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
Message-ID: <20200506180952.GU31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
 <87sggecv81.fsf@mpe.ellerman.id.au>
 <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu>
 <20200505155944.GO31009@gate.crashing.org>
 <87lfm5dev3.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfm5dev3.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 06, 2020 at 11:36:00AM +1000, Michael Ellerman wrote:
> >> As far as I understood that's mandatory on recent gcc to get the 
> >> pre-update form of the instruction. With older versions "m" was doing 
> >> the same, but not anymore.
> >
> > Yes.  How much that matters depends on the asm.  On older CPUs (6xx/7xx,
> > say) the update form was just as fast as the non-update form.  On newer
> > or bigger CPUs it is usually executed just the same as an add followed
> > by the memory access, so it just saves a bit of code size.
> 
> The update-forms are stdux, sthux etc. right?

And stdu, sthu, etc.  "x" is "indexed form" (reg+reg addressing).

> I don't see any change in the number of those with or without the
> constraint. That's using GCC 9.3.0.

It's most useful in loops (and happens more often there).  You probably
do not have many loops that allow update form insns.

> >> Should we ifdef the "m<>" or "m" based on GCC 
> >> version ?
> >
> > That will be a lot of churn.  Just make 4.8 minimum?
> 
> As I said in my other mail that's not really up to us. We could mandate
> a higher minimum for powerpc, but I'd rather not.

Yeah, I quite understand that.

> I think for now I'm inclined to just drop the "<>", and we can revisit
> in a release or two when hopefully GCC 4.8 has become the minimum.

An unhappy resolution, but it leaves a light on the horizon :-)

In that case, leave the "%Un", if you will but the "<>" back soonish?
Not much point removing it and putting it back later (it is harmless,
there are more instances of it in the kernel as well, since many years).

Thanks!


Segher
