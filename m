Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3EC2BB55
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 16:28:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57D720857
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 16:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4934Qk45SWzDrnp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 02:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=libc.org
 (client-ip=216.12.86.13; helo=brightrain.aerifal.cx;
 envelope-from=dalias@libc.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=libc.org
Received: from brightrain.aerifal.cx (216-12-86-13.cv.mvl.ntelos.net
 [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4933MV0pnxzDqw0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 01:40:16 +1000 (AEST)
Date: Thu, 16 Apr 2020 11:40:12 -0400
From: Rich Felker <dalias@libc.org>
To: Jeffrey Walton <noloader@gmail.com>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
Message-ID: <20200416154012.GV11469@brightrain.aerifal.cx>
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
 <1586994952.nnxigedbu2.astroid@bobo.none>
 <CAH8yC8k7dJdVS1LJRrGkxhbeVeXeGX2CWfC6sT--aso69Ksp6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8k7dJdVS1LJRrGkxhbeVeXeGX2CWfC6sT--aso69Ksp6Q@mail.gmail.com>
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
Cc: libc-alpha@sourceware.org, musl@lists.openwall.com,
 linuxppc-dev@lists.ozlabs.org, libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 16, 2020 at 11:21:56AM -0400, Jeffrey Walton wrote:
> On Wed, Apr 15, 2020 at 8:17 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Excerpts from Rich Felker's message of April 16, 2020 8:55 am:
> > > On Thu, Apr 16, 2020 at 07:45:09AM +1000, Nicholas Piggin wrote:
> > >> I would like to enable Linux support for the powerpc 'scv' instruction,
> > >> as a faster system call instruction.
> > >>
> > >> This requires two things to be defined: Firstly a way to advertise to
> > >> userspace that kernel supports scv, and a way to allocate and advertise
> > >> support for individual scv vectors. Secondly, a calling convention ABI
> > >> for this new instruction.
> > >> ...
> > > Note that any libc that actually makes use of the new functionality is
> > > not going to be able to make clobbers conditional on support for it;
> > > branching around different clobbers is going to defeat any gains vs
> > > always just treating anything clobbered by either method as clobbered.
> >
> > Well it would have to test HWCAP and patch in or branch to two
> > completely different sequences including register save/restores yes.
> > You could have the same asm and matching clobbers to put the sequence
> > inline and then you could patch the one sc/scv instruction I suppose.
> 
> Could GCC function multiversioning work here?
> https://gcc.gnu.org/wiki/FunctionMultiVersioning
> 
> It seems like selecting a runtime version of a function is the sort of
> thing you are trying to do.

On glibc it potentially could. This is ifunc-based functionality
though and musl explicitly does not (and will not) support ifunc
because of lots of fundamental problems it entails. But even on glibc
the underlying mechanisms for ifunc are just the same as a normal
indirect call and there's no real reason to prefer implementing it
with ifunc/multiversioning vs directly.

Rich
