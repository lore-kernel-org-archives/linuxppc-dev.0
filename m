Return-Path: <SRS0=3D1i=7S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73230C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 00:04:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251012067B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 00:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251012067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49dND81khqzDqhC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 10:04:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49dNBD0lwKzDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2020 10:02:27 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 055028I3021733;
 Thu, 4 Jun 2020 19:02:09 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 055028FT021732;
 Thu, 4 Jun 2020 19:02:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 4 Jun 2020 19:02:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Daniel Kolesa <daniel@octaforge.org>
Subject: Re: [musl] Re: ppc64le and 32-bit LE userland compatibility
Message-ID: <20200605000207.GO31009@gate.crashing.org>
References: <20200602142337.GS25173@kitsune.suse.cz>
 <3aeb6dfe-ae23-42f9-ac23-16be6b54a850@www.fastmail.com>
 <20200604171232.GG31009@gate.crashing.org>
 <20200604171844.GO1079@brightrain.aerifal.cx>
 <20200604173312.GI31009@gate.crashing.org>
 <a43aeb5d-3704-4540-969e-085790ff0477@www.fastmail.com>
 <20200604211009.GK31009@gate.crashing.org>
 <60fa8bd7-2439-4403-a0eb-166a2fb49a4b@www.fastmail.com>
 <alpine.DEB.2.21.2006042154060.8237@digraph.polyomino.org.uk>
 <4ca9d8f4-4d61-4e99-969c-03a99e4fd3cc@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca9d8f4-4d61-4e99-969c-03a99e4fd3cc@www.fastmail.com>
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
Cc: Rich Felker <dalias@libc.org>, libc-alpha@sourceware.org, eery@paperfox.es,
 musl@lists.openwall.com, Will Springer <skirmisher@protonmail.com>,
 Palmer Dabbelt via binutils <binutils@sourceware.org>,
 via libc-dev <libc-dev@lists.llvm.org>,
 Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Joseph Myers <joseph@codesourcery.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Fri, Jun 05, 2020 at 12:26:22AM +0200, Daniel Kolesa wrote:
> Either way I'll think about it some more and possibly prepare an RFC port. I'm definitely willing to put in the work and later maintenance effort if that's what it takes to make it happen.

Yeah, you'll need to convince all parties involved that it will not be
more work to them then they are willing to put in.  Initial development
and ongoing work, as you say.

For GCC it is probably an easy decision (but we'll see your proposed ABI
amendments): it shouldn't be much work at all, and it even benefits us
directly (it'll fill some holes in our testing matrix).


Segher
