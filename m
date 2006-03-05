Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A4AA679E1
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 05:59:28 +1100 (EST)
Date: Sun, 5 Mar 2006 19:59:23 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305185923.GA21519@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060305140932.GA17132@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060305140932.GA17132@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Mar 05, Olaf Hering wrote:

>  On Sun, Feb 26, Linus Torvalds wrote:
> 
> > Have I missed anything? Holler. And please keep reminding about any 
> > regressions since 2.6.15.
> 
> I see random memory corruption on an early G3 ibook.
> Testcase is an openSuSE 10.1 installation. 2.6.15 works ok modulo 2 bugs
> to get it booted at all, and the usual udev breakage.
> 
> plain 2.6.16-rc5-git7 locks up after a few packages, no ping.
> Our SuSE kernel does not lockup, but ext2 shows access beyond end of
> device after > 200 packages, or the rpmdb gets corrupt, or both. With reiserfs
> it gets past 100 packages, then reiserfs complains about fs corruption.
> plain -rc2 shows the same reiserfs corruption.
> plain -rc1 dies after a few packages, it jumps to 0x0 in softirq.

-git5 works, -git7 showed reiserfs corruption. -git6 died, jumped from
__do_softirq to 0x0, will try once again.

git5->6 has the mutex changes, but also lots of powerpc changes. Lets
see if I can narrow it down further.

The ibook has 160mb, installation is done via modular nfs
(ro,v3,rsize=32768,wsize=32768,hard,nolock,proto=tcp,addr=1.1.1.3)
I havent seen this on a B&W G3 with 256mb, nor on other ppc32 systems.
