Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 18:42:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EE9206DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 18:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EE9206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TKkW353CzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 05:42:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TKhh3D59zDqDd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 05:41:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44TKhh1D4Vz8t1D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 05:41:08 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44TKhh0wdCz9sT8; Wed, 27 Mar 2019 05:41:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44TKhc50vMz9sRY
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Mar 2019 05:41:03 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2QIdqAl016803;
 Tue, 26 Mar 2019 13:40:00 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2QIdbLe016760;
 Tue, 26 Mar 2019 13:39:37 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 26 Mar 2019 13:39:34 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
Message-ID: <20190326183933.GT3969@gate.crashing.org>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
 <20190322182943.GF3969@gate.crashing.org>
 <877ecnp1zf.fsf@concordia.ellerman.id.au>
 <20190325175431.GJ3969@gate.crashing.org>
 <87va06ngds.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va06ngds.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 26, 2019 at 08:18:07PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Mon, Mar 25, 2019 at 11:33:56PM +1100, Michael Ellerman wrote:
> >> Segher Boessenkool <segher@kernel.crashing.org> writes:
> >> > On Fri, Mar 22, 2019 at 11:37:24PM +1100, Michael Ellerman wrote:
> >> >> +	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff
> >> >
> >> > You can just write
> >> >   rlwinm r6,r4,0,0x0fff
> >> 
> >> > if that is clearer?  Or do you still want a comment with that :-)
> >> 
> >> I don't think it's clearer doing a rotate of zero bits :)
> >> 
> >> And yeah I'd probably still leave the comment, so I'm inclined to stick
> >> with the clrldi?
> >
> > I always have to think what the clrldi etc. do exactly, while with rlwinm
> > it is obvious.  But yeah this may be different for other people who are
> > used to different idiom.
> 
> Interesting, I'm the opposite. You know ppc assembler better than me so
> I guess I just need to spend more time on it and embrace the zen of the
> rotate instructions.

There is only one rlwinm instruction, but there are 9 extended mnemonics
for it.  (And similarly for the 64-bit ops, where there are 3 basic
mnemonics but 9 extended mnemonics).  Of course I use {s,rot}{l,r}{w,d}i,
those are actually *simpler* than rlwinm / rldic{,l,r}, but not the other
stuff.

It may also be because the disassembler doesn't show these things.  Dunno.

> I'm not sure it's vastly more hostile though than `andi. 6,4,0xffff`
> being valid but `andi. 6,4,0x1ffff` being not valid.

But that is the same for *all* UIMM insns.

> Yeah, I guess a new `andi` instruction is the only real answer :)

Too bad there is no space in the opcode map for it, already not in the
original POWER architecture (where this is "andil.") :-/


Segher
