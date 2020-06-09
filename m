Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF2AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:08:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EE220760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EE220760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49hFRP26LLzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 02:08:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=libc.org
 (client-ip=216.12.86.13; helo=brightrain.aerifal.cx;
 envelope-from=dalias@libc.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=libc.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49hFNx1QYdzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2020 02:06:39 +1000 (AEST)
Date: Tue, 9 Jun 2020 12:06:34 -0400
From: Rich Felker <dalias@libc.org>
To: Will Springer <skirmisher@protonmail.com>
Subject: Re: [musl] ppc64le and 32-bit LE userland compatibility
Message-ID: <20200609160633.GF1079@brightrain.aerifal.cx>
References: <2047231.C4sosBPzcN@sheen>
 <20200529192426.GM1079@brightrain.aerifal.cx>
 <14083731.JCcGWNJJiE@sheen> <20948555.hxa6pUQ8Du@sheen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20948555.hxa6pUQ8Du@sheen>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 09, 2020 at 10:29:57AM +0000, Will Springer wrote:
> On Saturday, May 30, 2020 3:56:47 PM PDT you wrote:
> > On Friday, May 29, 2020 12:24:27 PM PDT Rich Felker wrote:
> > > The argument passing for pread/pwrite is historically a mess and
> > > differs between archs. musl has a dedicated macro that archs can
> > > define to override it. But it looks like it should match regardless of
> > > BE vs LE, and musl already defines it for powerpc with the default
> > > definition, adding a zero arg to start on an even arg-slot index,
> > > which is an odd register (since ppc32 args start with an odd one, r3).
> > > 
> > > > [6]:
> > > > https://gist.github.com/Skirmisher/02891c1a8cafa0ff18b2460933ef4f3c
> > > 
> > > I don't think this is correct, but I'm confused about where it's
> > > getting messed up because it looks like it should already be right.
> > 
> > Hmm, interesting. Will have to go back to it I guess...
> > 
> > > > This was enough to fix up the `file` bug. I'm no seasoned kernel
> > > > hacker, though, and there is still concern over the right way to
> > > > approach this, whether it should live in the kernel or libc, etc.
> > > > Frankly, I don't know the ABI structure enough to understand why the
> > > > register padding has to be different in this case, or what
> > > > lower-level component is responsible for it.. For comparison, I had
> > > > a
> > > > look at the mips tree, since it's bi-endian and has a similar 32/64
> > > > situation. There is a macro conditional upon endianness that is
> > > > responsible for munging long longs; it uses __MIPSEB__ and
> > > > __MIPSEL__
> > > > instead of an if/else on the generic __LITTLE_ENDIAN__. Not sure
> > > > what
> > > > to make of that. (It also simply swaps registers for LE, unlike what
> > > > I did for ppc.)
> > > 
> > > Indeed the problem is probably that you need to swap registers for LE,
> > > not remove the padding slot. Did you check what happens if you pass a
> > > value larger than 32 bits?
> > > 
> > > If so, the right way to fix this on the kernel side would be to
> > > construct the value as a union rather than by bitwise ops so it's
> > > 
> > > endian-agnostic:
> > > 	(union { u32 parts[2]; u64 val; }){{ arg1, arg2 }}.val
> > > 
> > > But the kernel folks might prefer endian ifdefs for some odd reason...
> > 
> > You are right, this does seem odd considering what the other archs do.
> > It's quite possible I made a silly mistake, of course...
> > 
> > I haven't tested with values outside the 32-bit range yet; again, this
> > is new territory for me, so I haven't exactly done exhaustive tests on
> > everything. I'll give it a closer look.
> 
> I took some cues from the mips linux32 syscall setup, and drafted a new 
> patch defining a macro to compose the hi/lo parts within the function, 
> instead of swapping the args at the function definition. `file /bin/bash` 
> and `truncate -s 5G test` both work correctly now. This appears to be the 
> correct solution, so I'm not sure what silly mistake I made before, but 
> apologies for the confusion. I've updated my gist with the new patch [1].
> [...]
> 
> [1]: https://gist.github.com/Skirmisher/02891c1a8cafa0ff18b2460933ef4f3c

This patch looks correct. I prefer the union approach with no #ifdef
but I'm fine with either.

Rich
