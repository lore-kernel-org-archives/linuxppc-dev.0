Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7953679FF
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 09:22:07 +1100 (EST)
Date: Sun, 5 Mar 2006 23:22:02 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305222202.GA22450@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de>
	<Pine.LNX.4.64.0603051147590.13139@g5.osdl.org>
	<20060305204231.GA22002@suse.de>
	<17419.23860.883220.80199@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Mar 06, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > I'm now at 03929c76f3e5af919fb762e9882a9c286d361e7d, which fails as
> > well. dmesg shows this:
> 
> The range from git5 to there includes David Woodhouse's syscall
> entry/exit revamp (401d1f029bebb7153ca704997772113dc36d9527) and the
> follow-ons which fix it for 32-bit:
> 
> 9687c587596b54a77f08620595f5686ea35eed97
> 623703f620453c798b6fa3eb79ad8ea27bfd302a
> 
> There are also commits from Ben H that change the way we parse
> addresses from the OF device tree.  If you can bisect a bit further
> that would be good, although you may strike problems between the 401d
> and 6237 commits I mentioned above.

I will check this tomorrow.

quick update:

d4e4b3520c4df46cf1d15a56379a6fa57e267b7d, locks up, tried two times


404849bbd2bfd62e05b36f4753f6e1af6050a824 + 3 buildfixes:

31df1678d7732b94178a6e457ed6666e4431212f
8dacaedf04467e32c50148751a96150e73323cdc
d2dd482bc17c3bc240045f80a7c4b4d5cea5e29c


This one has the syscall changes, but not the two fixes you mentioned.
It gets far, but at the point where it locks up with the d4eb, it
crashes in run_timer_softirq, branched to 0x1f4. Maybe its the result of
the missing fixes. Will continue tomorrow.
