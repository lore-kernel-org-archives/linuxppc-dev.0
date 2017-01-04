Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttmp13RX7zDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 21:12:25 +1100 (AEDT)
Date: Wed, 4 Jan 2017 11:12:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Kujau <lists@nerdbynature.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, mpe@ellerman.id.au,
 kda@linux-powerpc.org, benh@kernel.crashing.org
Subject: Re: DEBUG_LOCKS_WARN_ON(1) / lockdep.c:3134
 lockdep_init_map+0x1e8/0x1f0
Message-ID: <20170104101208.GF25813@worktop.programming.kicks-ass.net>
References: <alpine.DEB.2.20.99.1701031806120.31470@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.99.1701031806120.31470@trent.utfs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 03, 2017 at 06:11:20PM -0800, Christian Kujau wrote:
> Hi,
> 
> booting v4.10-rc2 on this PowerPC G4 machine prints the following early 
> on, but then continues to boot and the machine is running fine so far:
> 
> 
> BUG: key ef0ba7d0 not in .data!
> DEBUG_LOCKS_WARN_ON(1)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at 
> /usr/local/src/linux-git/kernel/locking/lockdep.c:3134 lockdep_init_map+0x1e8/0x1f0
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.10.0-rc2 #4
> task: ef04aa60 task.stack: ef042000
> NIP: c005eb78 LR: c005eb78 CTR: 00000000
> REGS: ef043d70 TRAP: 0700   Not tainted  (4.10.0-rc2)
> MSR: 02029032 <VEC,EE,ME,IR,DR,RI>
>   CR: 48000022  XER: 20000000
> GPR00: c005eb78 ef043e20 ef04aa60 00000016 00000001 c0068b24 00000000 00000001 
> GPR08: 00000000 00000000 00004ead 000000d6 28000024 00000000 c00047f0 00000000 
> GPR16: 00000000 00000000 c08b9280 effedfa0 c078d6ac c1070000 c078eddc c078ee14 
> GPR24: c078ed24 c078ee24 00000002 ef085a00 00000000 c08b0000 ef0ba7d0 ef0ba7b4 
> NIP [c005eb78] lockdep_init_map+0x1e8/0x1f0
> LR [c005eb78] lockdep_init_map+0x1e8/0x1f0
> Call Trace:
> [ef043e20] [c005eb78] lockdep_init_map+0x1e8/0x1f0 (unreliable)
> [ef043e40] [c083adb4] kw_i2c_add+0xc0/0x134


Commit 9e607f72748d ("i2c_powermac: shut up lockdep warning") it utter
crap and should never have been merged.

/me glares at mpe, why do you merge things that state: 'its unclear
why, just make it go-away' wrt to locking?
