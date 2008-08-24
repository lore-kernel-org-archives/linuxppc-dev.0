Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1888DDDDF
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 08:38:08 +1000 (EST)
Subject: Re: Random crashes with 2.6.27-rc3 on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200808241544.12412.mb@bu3sch.de>
References: <200808231610.46473.mb@bu3sch.de>
	<1219531969.21386.205.camel@pasglop> <200808241544.12412.mb@bu3sch.de>
Content-Type: text/plain
Date: Mon, 25 Aug 2008 08:37:52 +1000
Message-Id: <1219617472.21386.226.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Thanks for your random guess.
> The following workaround seems to fix the crashes on powerpc.
> However, this patch is clearly not what we want for other architectures,
> as they might need -fno-omit-frame-pointer to function properly.

Well, and -pg requires it, even on powerpc, so that won't work for
ftrace. Any chance you can try the workaround that segher proposed
though ?

http://penguinppc.de/~segher/0001-powerpc-Workaround-for-the-ftrace-problem.patch

His workaround only kicks in with CONFIG_FTRACE, that would have to be
fixed of course. Also, I suspect the bits that have -pg in a flag
"remove" section should have also "fno-omit-frame-pointer" in that
remove section too.

> I reproduced the random crashes of kernel and userspace applications
> (without the following patch) on a vanilla 2.6.26 and 2.6.27-rc{1-4}
> kernel. I did _not_ try a 2.6.25 kernel with -fno-omit-frame-pointer, so
> I don't know if it would also crash then.
> 
> I'm currently running more tests on a patched 2.6.27-rc4 kernel, but it
> didn't crash, yet. I already did 5 complete kernel tree compilations. It
> should have crashed by now, but it didn't :)

Thanks !

Ben.
