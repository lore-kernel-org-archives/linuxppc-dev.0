Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 00:20:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA776205CB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 00:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA776205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2GzM60gFzDqxF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 10:20:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B2GxJ1FtjzDq9k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 10:18:43 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0690Ic1A019905;
 Wed, 8 Jul 2020 19:18:38 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0690IcnS019903;
 Wed, 8 Jul 2020 19:18:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 8 Jul 2020 19:18:37 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Failure to build librseq on ppc
Message-ID: <20200709001837.GD3598@gate.crashing.org>
References: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
 <20200708005922.GW3598@gate.crashing.org> <87k0ze2nv4.fsf@mpe.ellerman.id.au>
 <20200708235331.GA3598@gate.crashing.org>
 <1968953502.5815.1594252883512.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1968953502.5815.1594252883512.JavaMail.zimbra@efficios.com>
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
Cc: Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Jeanson <mjeanson@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 08, 2020 at 08:01:23PM -0400, Mathieu Desnoyers wrote:
> > > #define RSEQ_ASM_OP_CMPEQ(var, expect, label)                                   \
> > >                 LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"                   \
> > 
> > The way this hardcodes r17 *will* break, btw.  The compiler will not
> > likely want to use r17 as long as your code (after inlining etc.!) stays
> > small, but there is Murphy's law.
> 
> r17 is in the clobber list, so it should be ok.

What protects r17 *after* this asm statement?


Segher
