Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58372C3A5A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 19:14:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF382184D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 19:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF382184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Hz7c2hnHzDqVZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 05:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Hz5N6DxgzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 05:12:08 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7RJBseI002906;
 Tue, 27 Aug 2019 14:11:54 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7RJBrZL002905;
 Tue, 27 Aug 2019 14:11:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 27 Aug 2019 14:11:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
Message-ID: <20190827191153.GC31406@gate.crashing.org>
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr>
 <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr>
 <1566909844.x4jee1jjda.astroid@bobo.none>
 <20190827172909.GA31406@gate.crashing.org>
 <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
 <20190827182616.GB31406@gate.crashing.org>
 <00cc71bd-35f5-b0d5-e4fa-8368fe4fe78c@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cc71bd-35f5-b0d5-e4fa-8368fe4fe78c@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 27, 2019 at 08:33:45PM +0200, Christophe Leroy wrote:
> >So
> >   asm("add%I2 %0,%1,%2" : "=r"(dst) : "r"(src1), "ri"(src1));
> 
> "ri", not "n" as for wrtee ?

"n" means a number.  "i" means any constant integer.  The difference is
mostly that "n" does not allow relocations.  This probably does not matter
for this asm, not if you call it with correct values anyway.

(If you want to pass other than small numbers here, you need different
constraints; let's not go there).


Segher
