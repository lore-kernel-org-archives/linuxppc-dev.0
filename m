Return-Path: <adobriyan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.192])
	by ozlabs.org (Postfix) with ESMTP id DFB6F68704
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 08:21:33 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id x3so991844nzd
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 13:21:32 -0800 (PST)
Date: Sun, 13 Nov 2005 00:28:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
Message-ID: <20051112212829.GC20860@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200511122145.38409.mbuesch@freenet.de>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Subject: PowerBook G4 boot failure (was: Re: Linuv 2.6.15-rc1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 12, 2005 at 09:45:38PM +0100, Michael Buesch wrote:
> Latest GIT tree does not boot on my G4 PowerBook.
> It freezes after displaying:
>
> Welcome to Linux, kernel 2.6.15-rc1-g44e6f84e
>
> linked at		: 0xc0000000
> frame buffer at	: 0xb8008000  (phys), 0xd000800  (log)
> klimit		: 0xc03f5ae4
> MSR		: 0x00003030
> HID0		: 0x8410c0bc

> This is a 15 inch post feb2005 PowerBook G4.
>
> 2.6.14 properly boots with the same config.

Unless someone else would come up with better idea, you can always do:

	git bisect start
	git bisect bad 44e6f84e3597905816a0440e7218d2ed072120da
	git bisect start 741b2252a5e14d6c60a913c77a6099abe73a854a
		Bisecting: 2021 revisions left to test after this
		[739cafd316235fc55463849e80710f2ca308b9ae] [XFS] fix PBF_NONE handling
	make
		...
		[reboot]
	git bisect good		# if it boots
		or
	git bisect bad		# if it doesn't
	make
		...
		[reboot]

"2021" suggests that it would take 10 or so recompiles to identify bad
commit.
