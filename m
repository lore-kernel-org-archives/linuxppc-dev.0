Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C6C432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 16:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB02601FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 16:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DB02601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gx4PF3wNQz306F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Aug 2021 02:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Gx4Nk3dXHz2ypP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Aug 2021 02:07:17 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17RG4ccs010710;
 Fri, 27 Aug 2021 11:04:38 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 17RG4ajV010707;
 Fri, 27 Aug 2021 11:04:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 27 Aug 2021 11:04:36 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] powerpc: Investigate static_call concept
Message-ID: <20210827160436.GQ1583@gate.crashing.org>
References: <8077899fee81f08a7dffbf185569d3a1f7a2ab68.1630057495.git.christophe.leroy@csgroup.eu>
 <YSj0R6g6HeboSk9n@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSj0R6g6HeboSk9n@hirez.programming.kicks-ass.net>
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
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Jason Baron <jbaron@akamai.com>, Paul Mackerras <paulus@samba.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Ard Biesheuvel <ardb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 27, 2021 at 04:18:47PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 27, 2021 at 09:45:37AM +0000, Christophe Leroy wrote:
> > This RFC is to validate the concept of static_call on powerpc.
> > 
> > Highly copied from x86.
> > 
> > It replaces ppc_md.get_irq() which is called at every IRQ, by
> > a static call.
> 
> The code looks saner, but does it actually improve performance? I'm
> thinking the double branch also isn't free.

It isn't, but it is very cheap, while the branch-to-count is not, even
*if* it is correctly predicted.

> The paranoid in me would've made it:
> 
> 	BUG_ON(patch_branch(...));
> 
> just to make sure to notice the target not fitting. Ohh, patch_branch()
> doesn't return the create_branch() error, perhaps that wants to be
> fixed?

Should that be allowed to fail ever?  I.e., should a failure be a fatal
error?  Sounds very fragile otherwise.


Segher
