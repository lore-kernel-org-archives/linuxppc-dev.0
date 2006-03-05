Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AB4B267A3A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 07:03:01 +1100 (EST)
Date: Sun, 5 Mar 2006 12:02:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: Linux v2.6.16-rc5
In-Reply-To: <20060305185923.GA21519@suse.de>
Message-ID: <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 5 Mar 2006, Olaf Hering wrote:

>  On Sun, Mar 05, Olaf Hering wrote:
> > 
> > plain 2.6.16-rc5-git7 locks up after a few packages, no ping.
> > Our SuSE kernel does not lockup, but ext2 shows access beyond end of
> > device after > 200 packages, or the rpmdb gets corrupt, or both. With reiserfs
> > it gets past 100 packages, then reiserfs complains about fs corruption.
> > plain -rc2 shows the same reiserfs corruption.
> > plain -rc1 dies after a few packages, it jumps to 0x0 in softirq.
> 
> -git5 works, -git7 showed reiserfs corruption. -git6 died, jumped from
> __do_softirq to 0x0, will try once again.

Since there are several git users in the ppc camp, one thing that always 
helps is that when you test a -git snapshot, you also say what the "git 
ID" was.

I'm assuming that when you say "-git5 works", you mean  2.6.15-git5.

In this case:
	2.6.15-git5: 5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f
	2.6.15-git6: 977127174a7dff52d17faeeb4c4949a54221881f
	2.6.15-git7: 05f6ece6f37f987e9de643f6f76e8fb5d5b9e014

> git5->6 has the mutex changes, but also lots of powerpc changes. Lets
> see if I can narrow it down further.

If you can try out git, the best way to proceed is

	git bisect start
	git bisect good 5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f
	git bisect bad 977127174a7dff52d17faeeb4c4949a54221881f

which should help narrow it down pretty efficiently (I'm marking -git6 as 
bad, on the logic that the bug being chased is "corruption _or_ jumping to 
address 0". It's much harder if you want to chase down just one bug, when 
the other bug might stand in your way).

And yes, that range contains not just powerpc updates, but also PCI layer, 
mutex changes, crypto and V4L/DVB. Doing just three or four bisection 
trials would help narrow it down a lot (now it's 448 commits - doing three 
bisctions should narrow it down into less than 60 commits and likely which 
subsystem, while doing another bisection or two would get us into a few 
tens of commits).

"git bisect" really is very powerful and easy to use.

		Linus
