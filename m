Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6jb31gjmzDvWw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 16:29:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>,
 Paul Burton <paul.burton@imgtec.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Thorsten Leemhuis  <regressions@leemhuis.info>
Subject: Re: [PATCH] console: use first console if stdout-path device doesn't
 appear
In-Reply-To: <878tt6np85.fsf@linux-m68k.org>
References: <87oa2ij2mq.fsf@linux-m68k.org>
 <20161018091852.14776-1-paul.burton@imgtec.com>
 <87mvi1cwly.fsf@linux-m68k.org> <878tt6np85.fsf@linux-m68k.org>
Date: Mon, 31 Oct 2016 16:28:59 +1100
Message-ID: <87zill13z8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Any news?

We discovered it also breaks VGA on qemu, which presumably is not the
type of news you were hoping for.


To reproduce you just need to build a ppc64le kernel:

$ apt-get install gcc-powerpc64le-linux-gnu
$ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- pseries_le_defconfig
$ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu-

And then run qemu:

$ qemu-system-ppc64 -M pseries -m 1G  -kernel vmlinux


Which will display the Tux logo but then nothing else and then reboot
after 10 seconds or so.

If you revert 05fd007e4629 on top of rc3 it boots fine.


Paul I tried your "console: use first console if stdout-path device
doesn't appear" patch, but it didn't help. I'll try and work out why,
but it's a bit hard with no output :)


If we can't come up with a fix soon I'm inclined to ask for a revert.

cheers
