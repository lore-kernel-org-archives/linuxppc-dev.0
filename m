Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 60E8367B53
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 01:36:04 +1000 (EST)
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j46EiUkn185858
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 14:44:30 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1707.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j46EiUct284534
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 16:44:30 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j46EiUtu002437
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 16:44:30 +0200
In-Reply-To: <17017.44421.790813.918463@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
	<17017.44421.790813.918463@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <205f4a46b0d9eddd5c46ff1678c9e4ca@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 6 May 2005 16:44:33 +0200
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, say you are compiling for 405.  You either need to have a gcc
> that was configured with --with-cpu=405, or you need to have hacked
> arch/ppc/Makefile to add -mcpu=405.  In both cases the problem doesn't
> arise.  It only arises if you have a biarch gcc4 that was configured
> without any --with-cpu=xxx option and is run without any -mcpu=xxx
> option.

It happens for any installation where the default chosen by the GCC
used is not the -mcpu=XXX flag you need used for your kernel.  Which
is a much more general statement than the biarch one.  Most people just
get lucky, because they compile code with a compiler that is defaulted
for their target, and userland and kernel use (about) the same options
on most targets.  Not so in biarch land (bleeech).

> If you think we should have -mcpu=xxx on the command line for 4xx,
> 44x, 8xx, etc., then that's fine, but that is a separate problem from
> what my patch was addressing (one which my patch might make it easier
> to fix, though).

Please always use -mcpu=XXX (and perhaps -mtune=XXX), that's the only
"correct" way to fix this.  Or _never_ do any -mcpu=, and let users
override it in the CC setting in the Makefile.  But I like the first
option better.


Segher
