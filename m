Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B4B0DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 09:32:39 +1100 (EST)
Subject: Re: How to dynamically disable/enable CPU features?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080222190531.103050@gmx.net>
References: <ebff4ecb45908616728fb5c8ede8b0bf@bga.com>
	<20080222190531.103050@gmx.net>
Content-Type: text/plain
Date: Sat, 23 Feb 2008 09:32:01 +1100
Message-Id: <1203719521.6976.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The flag is in POSSIBLE. I now use this code in the platform probe
> function to nop out the code affected by the flag:
> 
> cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
> /* Patch out unwanted feature. */
> do_feature_fixups(cur_cpu_spec->cpu_features,
> 		  PTRRELOC(&__start___ftr_fixup),
> 		  PTRRELOC(&__stop___ftr_fixup));
> 
> It seems to work so far, but I would like to know if this is the right
> way to do it, or if calling do_feature_fixups() more than once can have
> any side effects.

It's a bit hairy... Things -could- have been nop'ed out by the first
call as a result of CPU_FTR_NEED_COHERENT being set and the second
call will not be able to put them back in... now that may not be the
case (depends what kind of patching is done with that flag) and so
'happen' to work for this specific bit but it isn't a nice solution...

A better long term approach is to look at moving the fixup to after
the machine probe() after carefully checking whether that can cause
any problem...

Ben.
