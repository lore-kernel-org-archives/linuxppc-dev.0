Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 02:38:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C2F2068D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 02:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C2F2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bbp04WK2zDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 12:38:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49bbll6jWwzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 12:36:51 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0522aWBE016043;
 Mon, 1 Jun 2020 21:36:32 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0522aV7k016042;
 Mon, 1 Jun 2020 21:36:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 1 Jun 2020 21:36:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Daniel Kolesa <daniel@octaforge.org>
Subject: Re: [musl] Re: ppc64le and 32-bit LE userland compatibility
Message-ID: <20200602023630.GP31009@gate.crashing.org>
References: <2047231.C4sosBPzcN@sheen>
 <alpine.DEB.2.21.2006012119010.11121@digraph.polyomino.org.uk>
 <c821b608-f14f-4a68-bbec-b7b6c1d8bddc@www.fastmail.com>
 <20200602015802.GN31009@gate.crashing.org>
 <51122625-15b3-408b-822c-69cdb7b8d5d9@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51122625-15b3-408b-822c-69cdb7b8d5d9@www.fastmail.com>
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
Cc: libc-alpha@sourceware.org, eery@paperfox.es, musl@lists.openwall.com,
 Will Springer <skirmisher@protonmail.com>,
 Palmer Dabbelt via binutils <binutils@sourceware.org>,
 via libc-dev <libc-dev@lists.llvm.org>, linuxppc-dev@lists.ozlabs.org,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 02, 2020 at 04:12:26AM +0200, Daniel Kolesa wrote:
> On Tue, Jun 2, 2020, at 03:58, Segher Boessenkool wrote:
> > I recommend new ports that cannot jump to IEEE QP float directly to use
> > long double == double for the time being, avoiding the extra
> > complications that IBM double double would bring.  But you'll still have
> > a transition to IEEE 128 if you ever want to go there.
> > 
> > But if you already use double-double, I don't know if the cost changing
> > away from that is worth it now.
> 
> The transition cost is relatively low, which is why I'm thinking about this in the first place. For one, relatively few things use long double in the first place.

Then your cost switching to QP float later will be low as well.  I envy
you :-)

> For two, on ppc*, at least the bfd linker (which we use always in Void) always tags ELFs with an FP ABI tag, and things not using long double (or using 64-bit long double) don't receive this tag. It even tags *which* ABI is used. See:

That works for statically linked stuff, sure.  That is the easy case :-/

> I went through this once already (I had the 64-bit ldbl transition nearly done) and the number of packages to rebuild in the whole repo was about 200-300 out of ~12000.

Cool!  Do you perchance have info you can share about which packages?
Offline, if you want.

> > > There is also one more thing while we're at this. The 64-bit big endian Void port uses the ELFv2 ABI, even on glibc. This is not officially supported on glibc as far as I can tell, but it does work out of box, without any patching (things in general match little endian then, i.e. ld64.so.2 etc, but they're big endian). Is there any chance of making that support official?
> > 
> > (I don't talk for glibc).
> > 
> > The first thing needed is for "us" to have faith in it.  That starts
> > with seeing test results for the testsuites!
> > 
> > (Something similar goes for the GCC port -- there is no official support
> > for BE ELFv2, but of course it does work, and if we get test results we
> > may keep it that way, hint hint :-) )
> 
> Well, FreeBSD defaults to it since 13; OpenBSD's new powerpc64 port (which is supposedly dual-endian) defaults to it; musl defaults to it on LE and BE.

... and no one ever has sent us (GCC) test results (nothing I have seen
anyway).  All we "officially" know is that Power7 BE ELFv2 was a
bring-up vehicle for the current powerpc64le-linux.  Everyone tries not
to break things without reason to, of course, and things are a little
bit tested anyway because it is convenient to build ELFv2 stuff on BE
systems as well (if only to figure out effortlessly if some bug is due
to the ABI or due to the endianness), but if we do not know something is
used and we never officially supported it, we might just want to take it
away if it is inconvenient.

> FreeBSD and OpenBSD have to, since they primarily target LLVM system toolchain (with GCC in ports) and ld.lld doesn't support ELFv1 (at all). Void's port was new (and any precompiled binaries would generally be enterprisey stuff which doesn't concern us enough - people can just make a chroot/container with say, Debian, if they really need to),

Yeah, enterprisey enough, then just rebuild :-)

> so I felt like it didn't make sense to go with the legacy ABI (besides, function descriptors are gross ;)).

Descriptors are Great, you just do not understand the True Way!

> The situation in the overall userland has been improving too, so the patch burden is actually very low nowadays.

Is that because long double just isn't used a lot?  Or are there more
reasons?


Segher
