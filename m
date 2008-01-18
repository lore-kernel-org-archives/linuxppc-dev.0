Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id EB59ADDECD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 02:41:13 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <18320.32058.370817.762911@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2f04d94d12c17206c76178541f8127c1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: 2.6.24-rc8-mm1 Kernel oops will running kernbench
Date: Fri, 18 Jan 2008 09:41:19 -0600
To: ppcdev <linuxppc-dev@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras writes:

> Kamalesh Babulal writes:
>
> > I tried reproducing the problem and was successful with following 
> trace
> > in which the pc is at 0x4570 as the above one
>
> What did you do to trigger it?
>
> > c000000000004544 <unrecov_slb>:
> > c000000000004544:       71 8a 40 00     andi.   r10,r12,16384
> > c000000000004548:       7c 2a 0b 78     mr      r10,r1
> > c00000000000454c:       38 21 fd 10     addi    r1,r1,-752
> > c000000000004550:       41 82 00 08     beq-    c000000000004558 
> <unrecov_slb+0x14>
> > c000000000004554:       e8 2d 01 a8     ld      r1,424(r13)
> > c000000000004558:       2c a1 00 00     cmpdi   cr1,r1,0
> > c00000000000455c:       40 84 00 08     bge-    cr1,c000000000004564 
> <unrecov_slb+0x20>
> > c000000000004560:       48 00 00 10     b       c000000000004570 
> <unrecov_slb+0x2c>
> > c000000000004564:       38 20 41 00     li      r1,16640
> > c000000000004568:       b0 2d 01 c8     sth     r1,456(r13)
> > c00000000000456c:       4b ff fb 18     b       c000000000004084 
> <bad_stack>
> > c000000000004570:       f9 21 01 a0     std     r9,416(r1)
>
> So it's in the code that gets called on an unrecoverable SLB fault.
> That's bad, we should never get those.  Does this happen with mainline
> too, or only with -rc8-mm1?  I don't understand why we should start
> seeing this problem unless something has changed in
> arch/powerpc/kernel or arch/powerpc/mm (well I suppose a bug somewhere
> else could cause memory corruption which might be able to lead to
> this).

The reason we get the fault here instead of a nice oops is that 
unrecov_slb is supposed to be called after the switch to virtual mode, 
but no code was added when the real mode slb handling was added.  
However, its not simply adding code, as iSeries calls the same slb 
reload code in virtual mode (as it always runs virtual), so the code 
will have to check if translation is already on.

(I had found this in a previous audit, but as Paul said, its not 
supposed to happen, and I haven't pursued a patch).

>
> Does it still happen if you take git-powerpc.patch out of the series?
>
> Paul.
