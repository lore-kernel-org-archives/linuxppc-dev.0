Return-Path: <anton@samba.org>
Date: Thu, 14 Jul 2011 10:34:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
Message-ID: <20110714103418.7ef25b68@kryten>
In-Reply-To: <1310036375.3282.509.camel@twins>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Peter,

> Surely this isn't the first multi-node P7 to boot a kernel with this
> patch? If my git foo is any good it hit -next on 23rd of May.
> 
> I guess I'm asking is, do smaller P7 machines boot? And if so, is
> there any difference except size?
> 
> How many nodes does the thing have anyway, 28? Hmm, that could mean
> its the first machine with >16 nodes to boot this, which would make it
> trigger the magic ALL_NODES crap.

We haven't tested a box with more than 16 nodes in quite a while, so it
may be this.

I took a quick look and we are stuck in update_group_power:

        do {
                power += group->cpu_power;
                group = group->next;
        } while (group != child->groups);

I looked at the linked list:

child->groups = c000007b2f74ff00

and dumping group as we go:

c000007b2f74ff00 c000007b2f760000 c000007b2fb60000 c000007b2ff60000

at this point we end up in a cycle and never make it back to
child->groups:

c000008b2e68ff00 c000008b2e6a0000 c000008b2eaa0000 c000008b2eea0000
c000009aee77ff00 c000009aee790000 c000009aeeb90000 c000009aeef90000
c00000bafde91800 c00000dafdf81800 c00000fafce81800 c000011afdf71800
c00001226e70ff00 c00001226e720000 c00001226eb20000 c00001226ef20000
c000008b2e68ff00

Still investigating

Anton
