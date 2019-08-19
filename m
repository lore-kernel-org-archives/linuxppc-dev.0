Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7AC3A5A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:31:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7454F20651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BxDn6rQmzDqFB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 00:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Bx630z42zDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 00:25:14 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7JEOx1K022323;
 Mon, 19 Aug 2019 09:25:00 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7JEOxlG022322;
 Mon, 19 Aug 2019 09:24:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 19 Aug 2019 09:24:59 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 3/3] powerpc/64: optimise LOAD_REG_IMMEDIATE_SYM()
Message-ID: <20190819142459.GJ31406@gate.crashing.org>
References: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
 <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 19, 2019 at 01:58:12PM +0000, Christophe Leroy wrote:
> -#define LOAD_REG_IMMEDIATE_SYM(reg,expr)	\
> -	lis     reg,(expr)@highest;		\
> -	ori     reg,reg,(expr)@higher;	\
> -	rldicr  reg,reg,32,31;		\
> -	oris    reg,reg,(expr)@__AS_ATHIGH;	\
> -	ori     reg,reg,(expr)@l;
> +#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
> +	lis	reg, (expr)@highest;		\
> +	lis	tmp, (expr)@__AS_ATHIGH;	\
> +	ori	reg, reg, (expr)@higher;	\
> +	ori	tmp, reg, (expr)@l;		\
> +	rldimi	reg, tmp, 32, 0

That should be

#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
	lis	tmp, (expr)@highest;		\
	ori	tmp, tmp, (expr)@higher;	\
	lis	reg, (expr)@__AS_ATHIGH;	\
	ori	reg, reg, (expr)@l;		\
	rldimi	reg, tmp, 32, 0

(tmp is the high half, reg is the low half, as inputs to that rldimi).


Segher
