Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6BAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 20:15:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACEA613D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 20:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3ACEA613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gtk4m4V5nz2yg3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 06:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Gtk4K4jsCz2xr1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 06:14:56 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17NKCUqC005302;
 Mon, 23 Aug 2021 15:12:30 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 17NKCOGl005277;
 Mon, 23 Aug 2021 15:12:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 23 Aug 2021 15:12:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/booke: Avoid link stack corruption in several
 places
Message-ID: <20210823201219.GZ1583@gate.crashing.org>
References: <d7435e616336fd5f07bb19ec61e97d71e5c53568.1629705153.git.christophe.leroy@csgroup.eu>
 <20210823155837.GX1583@gate.crashing.org>
 <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 23, 2021 at 07:05:38PM +0200, Christophe Leroy wrote:
> Le 23/08/2021 à 17:58, Segher Boessenkool a écrit :
> >On Mon, Aug 23, 2021 at 07:53:01AM +0000, Christophe Leroy wrote:
> >>  /* Be careful, this will clobber the lr register. */
> >>  #define LOAD_REG_ADDR_PIC(reg, name)		\
> >>-	bl	0f;				\
> >>+	bcl	20,31,0f			\
> >>  0:	mflr	reg;				\
> >>  	addis	reg,reg,(name - 0b)@ha;		\
> >>  	addi	reg,reg,(name - 0b)@l;
> >
> >The code ended each line with a semicolon before, for absolutely no
> >reason that I can see, but still.  Fixing that would be nice, but only
> >doing it on one line isn't good.
> 
> Sure, forgetting the semicolon broke the build. That's because the 
> backslash removes the newline.

Ah right, one of the surprises you get from using the C preprocessor on
non-C code :-)

> The cleanest way I found to fix that quite of stuff is by using GAS macro, 
> as I did for LOAD_REG_IMMEDIATE() some time ago.

Yeah, good plan.  You can use loops and saner parameters etc. as well if
you do :-)

> >Btw.  Both the 7450 and the modern cores implementing this really need
> >this to be $+4, so it is a lot clearer to write that instead of 1f or
> >a named label.
> 
> I like that, removing unneeded labels will make it smoother and clearer. 
> I'll do it.

Cool, thanks!


Segher
