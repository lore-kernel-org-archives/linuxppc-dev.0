Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD5C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 18:34:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F18217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 18:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F18217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NFwv05h0zDqlR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 04:34:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NFtP2gM4zDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 04:32:28 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x83IVx20018430;
 Tue, 3 Sep 2019 13:31:59 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x83IVvlH018429;
 Tue, 3 Sep 2019 13:31:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 3 Sep 2019 13:31:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
Message-ID: <20190903183157.GB9749@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-4-alastair@au1.ibm.com>
 <20190903130430.GC31406@gate.crashing.org>
 <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
 <20190903160415.GA9749@gate.crashing.org>
 <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
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
Cc: Alastair D'Silva <alastair@au1.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, alastair@d-silva.org, Qian Cai <cai@lca.pw>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 03, 2019 at 07:05:19PM +0200, Christophe Leroy wrote:
> Le 03/09/2019 à 18:04, Segher Boessenkool a écrit :
> >(Why are they separate though?  It could just be one loop var).
> 
> Yes it could just be a single loop var, but in that case it would have 
> to be reset at the start of the second loop, which means we would have 
> to pass 'addr' for resetting the loop anyway,

Right, I noticed that after hitting send, as usual.

> so I opted to do it 
> outside the inline asm by using to separate loop vars set to their 
> starting value outside the inline asm.

The thing is, the way it is written now, it will get separate registers
for each loop (with proper earlyclobbers added).  Not that that really
matters of course, it just feels wrong :-)


Segher
