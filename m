Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id A78EE67A87
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 22:25:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 14:24:39 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D30@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
>> What I don't understand, is how the FP load/store operations
>> in misc.S can "work" on a system with no FPU and *no* math-emu?
>
>What should happen is to follow the example used by 8xx for
>many years.  As I said, when math emulation is disabled, there is
>still code that will emulate the load/store FP instructions.  These
>instructions are used in may places even if user applications
>are compiled without any FP usage.

Ok.

>> Many years? Allow me to doubt it's really used :).
>
>I wrote it in 1998 for the 8xx.  I thought 4xx and e500 used the
>same model.  If they don't, they should.

Let's get it fixed.

>> Though, it does work for 8xx thanks to Soft_emulate_8xx, but doesn't
>> for other FPU-less cores when CONFIG_MATH_EMULATION is disabled.
>
>Well, then that should get fixed.

What's the right way to fix it?

>> So here is another patch,
[..]
>The only patch I'm interested in is making the 4xx and e500 follow the
>same path as 8xx.  All of the non-FP cores should work the same way.

Speaking for myself, I don't plan on using the SPE FPU of the e500, but
would like to see the MATH_EMULATION=3Dn fixed. So how should we fix it?

It seems you didn't like my last patch which lets make enter the
math-emu
subdirectory only to compile the load/store (8xx could do that too).
Would you prefer a fix along the line of Soft_emulate_8xx() ?
Then should we make it a Soft_emulate_85xx and Soft_emulate_4xx or can
we attempt to fuse them altogether and rename(+make it generic)
Soft_emulate_8xx as Soft_emulate_classic?

>The e500 is a special case because it doesn't have a classic FPU but
>rather can utilize the SPE for floating point.  Put some thought into=20
>that.

I don't know what Kumar and his team have in mind for the e500, whether
they will use SPE FPU for the classic load/store "emulation". Kumar,
can you please enlighten us on this topic?


Thanks,
--=20
Stephane
