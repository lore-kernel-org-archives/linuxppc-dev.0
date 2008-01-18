Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18320.32058.370817.762911@cargo.ozlabs.ibm.com>
Date: Fri, 18 Jan 2008 21:19:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc8-mm1 Kernel oops will running kernbench
In-Reply-To: <479072BC.3080908@linux.vnet.ibm.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<479064F0.7040305@linux.vnet.ibm.com>
	<20080118004416.6a757169.akpm@linux-foundation.org>
	<18320.27372.202771.764301@cargo.ozlabs.ibm.com>
	<479072BC.3080908@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal writes:

> I tried reproducing the problem and was successful with following trace
> in which the pc is at 0x4570 as the above one

What did you do to trigger it?

> c000000000004544 <unrecov_slb>:
> c000000000004544:       71 8a 40 00     andi.   r10,r12,16384
> c000000000004548:       7c 2a 0b 78     mr      r10,r1  
> c00000000000454c:       38 21 fd 10     addi    r1,r1,-752
> c000000000004550:       41 82 00 08     beq-    c000000000004558 <unrecov_slb+0x14>
> c000000000004554:       e8 2d 01 a8     ld      r1,424(r13)
> c000000000004558:       2c a1 00 00     cmpdi   cr1,r1,0
> c00000000000455c:       40 84 00 08     bge-    cr1,c000000000004564 <unrecov_slb+0x20>
> c000000000004560:       48 00 00 10     b       c000000000004570 <unrecov_slb+0x2c>
> c000000000004564:       38 20 41 00     li      r1,16640
> c000000000004568:       b0 2d 01 c8     sth     r1,456(r13)
> c00000000000456c:       4b ff fb 18     b       c000000000004084 <bad_stack>
> c000000000004570:       f9 21 01 a0     std     r9,416(r1) 

So it's in the code that gets called on an unrecoverable SLB fault.
That's bad, we should never get those.  Does this happen with mainline
too, or only with -rc8-mm1?  I don't understand why we should start
seeing this problem unless something has changed in
arch/powerpc/kernel or arch/powerpc/mm (well I suppose a bug somewhere
else could cause memory corruption which might be able to lead to
this).

Does it still happen if you take git-powerpc.patch out of the series?

Paul.
