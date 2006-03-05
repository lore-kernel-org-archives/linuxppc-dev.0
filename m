Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
Date: Mon, 6 Mar 2006 08:50:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: Linux v2.6.16-rc5
In-Reply-To: <20060305204231.GA22002@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de>
	<Pine.LNX.4.64.0603051147590.13139@g5.osdl.org>
	<20060305204231.GA22002@suse.de>
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

Olaf Hering writes:

> I'm now at 03929c76f3e5af919fb762e9882a9c286d361e7d, which fails as
> well. dmesg shows this:

The range from git5 to there includes David Woodhouse's syscall
entry/exit revamp (401d1f029bebb7153ca704997772113dc36d9527) and the
follow-ons which fix it for 32-bit:

9687c587596b54a77f08620595f5686ea35eed97
623703f620453c798b6fa3eb79ad8ea27bfd302a

There are also commits from Ben H that change the way we parse
addresses from the OF device tree.  If you can bisect a bit further
that would be good, although you may strike problems between the 401d
and 6237 commits I mentioned above.

It would be interesting to take 401d and then apply 9687 and 6237
directly on top of it and try that, and if it fails, then try
1cd8e506209223ed10da805d99be55e268f4023c (the parent of 401d).

Paul.
