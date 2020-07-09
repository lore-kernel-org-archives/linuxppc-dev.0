Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F62C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 20:48:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA9F20775
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 20:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA9F20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2pCg50v2zDrCP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2020 06:47:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B2p9h4V0xzDr5j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2020 06:46:16 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 069KkAns021000;
 Thu, 9 Jul 2020 15:46:11 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 069KkAAp020997;
 Thu, 9 Jul 2020 15:46:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 9 Jul 2020 15:46:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Failure to build librseq on ppc
Message-ID: <20200709204609.GQ3598@gate.crashing.org>
References: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
 <87k0ze2nv4.fsf@mpe.ellerman.id.au> <20200708235331.GA3598@gate.crashing.org>
 <1968953502.5815.1594252883512.JavaMail.zimbra@efficios.com>
 <20200709001837.GD3598@gate.crashing.org>
 <1769596686.6365.1594302227962.JavaMail.zimbra@efficios.com>
 <20200709173712.GL3598@gate.crashing.org>
 <1584179170.7410.1594316576293.JavaMail.zimbra@efficios.com>
 <1682947575.7422.1594317379612.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682947575.7422.1594317379612.JavaMail.zimbra@efficios.com>
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

On Thu, Jul 09, 2020 at 01:56:19PM -0400, Mathieu Desnoyers wrote:
> > Just to make sure I understand your recommendation. So rather than
> > hard coding r17 as the temporary registers, we could explicitly
> > declare the temporary register as a C variable, pass it as an
> > input operand to the inline asm, and then refer to it by operand
> > name in the macros using it. This way the compiler would be free
> > to perform its own register allocation.
> > 
> > If that is what you have in mind, then yes, I think it makes a
> > lot of sense.
> 
> Except that asm goto have this limitation with gcc: those cannot
> have any output operand, only inputs, clobbers and target labels.
> We cannot modify a temporary register received as input operand. So I don't
> see how to get a temporary register allocated by the compiler considering
> this limitation.

Heh, yet another reason not to obfuscate your inline asm: it didn't
register this is asm goto.

A clobber is one way, yes (those *are* allowed in asm goto).  Another
way is to not actually change that register: move the original value
back into there at the end of the asm!  (That isn't always easy to do,
it depends on your code).  So something like

	long start = ...;
	long tmp = start;
	asm("stuff that modifies %0; ...; mr %0,%1" : : "r"(tmp), "r"(start));

is just fine: %0 isn't actually modified at all, as far as GCC is
concerned, and this isn't lying to it!


Segher
