Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BDD767A33
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 13:45:49 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D25@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D25@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12cdcb5f3594a4e2b4869f3666079a8e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 31 Mar 2005 22:45:39 -0500
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2005, at 2:17 PM, Fillod Stephane wrote:

> What I don't understand, is how the FP load/store operations
> in misc.S can "work" on a system with no FPU and *no* math-emu?

What should happen is to follow the example used by 8xx for
many years.  As I said, when math emulation is disabled, there is
still code that will emulate the load/store FP instructions.  These
instructions are used in may places even if user applications
are compiled without any FP usage.

> Many years? Allow me to doubt it's really used :).

I wrote it in 1998 for the 8xx.  I thought 4xx and e500 used the
same model.  If they don't, they should.

> Though, it does work for 8xx thanks to Soft_emulate_8xx, but doesn't
> for other FPU-less cores when CONFIG_MATH_EMULATION is disabled.

Well, then that should get fixed.

> So here is another patch,

The only patch I'm interested in is making the 4xx and e500 follow the
same path as 8xx.  All of the non-FP cores should work the same way.
The e500 is a special case because it doesn't have a classic FPU but
rather can utilize the SPE for floating point.  Put some thought into 
that.

Thanks.


	-- Dan
