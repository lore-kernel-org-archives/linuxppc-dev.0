Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF8C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:30:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47878206E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47878206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bwvz1Z9yzDqS1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 01:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bwry14C6zDqMV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 01:27:29 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 21747AF39;
 Tue,  2 Jun 2020 15:27:29 +0000 (UTC)
Date: Tue, 2 Jun 2020 17:27:24 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Daniel Kolesa <daniel@octaforge.org>
Subject: Re: ppc64le and 32-bit LE userland compatibility
Message-ID: <20200602152724.GU25173@kitsune.suse.cz>
References: <2047231.C4sosBPzcN@sheen>
 <alpine.DEB.2.21.2006012119010.11121@digraph.polyomino.org.uk>
 <c821b608-f14f-4a68-bbec-b7b6c1d8bddc@www.fastmail.com>
 <alpine.DEB.2.21.2006012329420.11121@digraph.polyomino.org.uk>
 <b44b3aa7-f9cc-43e1-b2c4-0edb6ea06189@www.fastmail.com>
 <alpine.DEB.2.21.2006021334170.24059@digraph.polyomino.org.uk>
 <20200602142337.GS25173@kitsune.suse.cz>
 <3aeb6dfe-ae23-42f9-ac23-16be6b54a850@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aeb6dfe-ae23-42f9-ac23-16be6b54a850@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, Jun 02, 2020 at 05:13:25PM +0200, Daniel Kolesa wrote:
> On Tue, Jun 2, 2020, at 16:23, Michal Suchánek wrote:
> > On Tue, Jun 02, 2020 at 01:40:23PM +0000, Joseph Myers wrote:
> > > On Tue, 2 Jun 2020, Daniel Kolesa wrote:
> > > 
> > > > not be limited to being just userspace under ppc64le, but should be 
> > > > runnable on a native kernel as well, which should not be limited to any 
> > > > particular baseline other than just PowerPC.
> > > 
> > > This is a fairly unusual approach to bringing up a new ABI.  Since new 
> > > ABIs are more likely to be used on new systems rather than switching ABI 
> > > on an existing installation, and since it can take quite some time for all 
> > > the software support for a new ABI to become widely available in 
> > > distributions, people developing new ABIs are likely to think about what 
> > > new systems are going to be relevant in a few years' time when working out 
> > > the minimum hardware requirements for the new ABI.  (The POWER8 minimum 
> > > for powerpc64le fits in with that, for example.)
> > That means that you cannot run ppc64le on FSL embedded CPUs (which lack
> > the vector instructions in LE mode). Which may be fine with you but
> > other people may want to support these. Can't really say if that's good
> > idea or not but I don't foresee them going away in a few years, either.
> 
> well, ppc64le already cannot be run on those, as far as I know (I don't think it's possible to build ppc64le userland without VSX in any configuration)

What hardware are you targetting then? I did not notice anything
specific mentioned in the thread.

Naturally on POWER the first cpu that has LE support is POWER8 so you
can count on all other POWER8 features to be present. With other
architecture variants the situation is different.

Thanks

Michal
