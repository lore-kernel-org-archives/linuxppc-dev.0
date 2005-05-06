Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 5EE9667B4E
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 00:53:16 +1000 (EST)
Date: Fri, 6 May 2005 07:53:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050506145313.GE1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
	<17017.44421.790813.918463@cargo.ozlabs.ibm.com>
	<205f4a46b0d9eddd5c46ff1678c9e4ca@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <205f4a46b0d9eddd5c46ff1678c9e4ca@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 06, 2005 at 04:44:33PM +0200, Segher Boessenkool wrote:
> >Well, say you are compiling for 405.  You either need to have a gcc
> >that was configured with --with-cpu=405, or you need to have hacked
> >arch/ppc/Makefile to add -mcpu=405.  In both cases the problem doesn't
> >arise.  It only arises if you have a biarch gcc4 that was configured
> >without any --with-cpu=xxx option and is run without any -mcpu=xxx
> >option.
> 
> It happens for any installation where the default chosen by the GCC
> used is not the -mcpu=XXX flag you need used for your kernel.  Which
> is a much more general statement than the biarch one.  Most people just
> get lucky, because they compile code with a compiler that is defaulted
> for their target, and userland and kernel use (about) the same options
> on most targets.  Not so in biarch land (bleeech).

Note that up until very recently (and just a bit before conflicting
opcodes were added), no -mcpu=XXX was required.  For example, I compiled
a 44x kernel with a -mcpu=750 toolchain no problems shortly after Paul
posted this.  The only exception to this rule I can possibly think of is
85xx.  But even that would be the "very recently" thing I mentioned as
I know you can use an 82xx-set toolchain to build for 85xx.

Having said that..

> >If you think we should have -mcpu=xxx on the command line for 4xx,
> >44x, 8xx, etc., then that's fine, but that is a separate problem from
> >what my patch was addressing (one which my patch might make it easier
> >to fix, though).
> 
> Please always use -mcpu=XXX (and perhaps -mtune=XXX), that's the only
> "correct" way to fix this.  Or _never_ do any -mcpu=, and let users
> override it in the CC setting in the Makefile.  But I like the first
> option better.

We should setup cpu-opt-$(CONFIG_every choice) to fix new gcc breakage
(and I guess we shouldn't have removed the do-nothing ones we had a few
years ago).

-- 
Tom Rini
http://gate.crashing.org/~trini/
