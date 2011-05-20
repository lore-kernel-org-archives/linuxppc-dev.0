Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF8D7B71A2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 00:47:06 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4KEdf0T019510
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 08:39:41 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p4KEjmke250036
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 08:45:48 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4KEjkJ4016030
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 08:45:46 -0600
Date: Fri, 20 May 2011 10:46:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20110520144653.GH25179@zod.rchland.ibm.com>
References: <1305777978.7481.37.camel@pasglop>
	<20110520132328.GA5785@riccoc20.at.omicron.at>
	<20110520135845.GG25179@zod.rchland.ibm.com>
	<20110520143259.GB5785@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110520143259.GB5785@riccoc20.at.omicron.at>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 04:32:59PM +0200, Richard Cochran wrote:
>On Fri, May 20, 2011 at 09:58:45AM -0400, Josh Boyer wrote:
>> On Fri, May 20, 2011 at 03:23:29PM +0200, Richard Cochran wrote:
>> >When I try to build 'next' (now at 208b3a4c), it does not compile due
>> >to a change from the following commit.
>> >
>> >> Benjamin Herrenschmidt (1):
>> >>       powerpc/smp: Make start_secondary_resume available to all CPU variants
>> >
>> >I would appreciate your help in getting this fixed...
>> 
>> Could you try the patch below?
>
>Yes, and it both compiles and boots.

Thanks for testing!

Ben, can you pull this patch in as-is (fixing up the Subject), or do you
need me to resubmit it?

josh
>> 
>> Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
>> however it uses a 64-bit instruction which is not valid on 32-bit
>> platforms.  Use 'stw' instead.
>> 
>> Reported-by: Richard Cochran <richardcochran@gmail.com>
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> 
>> ---
>> 
>> diff --git a/arch/powerpc/kernel/misc_32.S
>> b/arch/powerpc/kernel/misc_32.S
>> index 402560e..998a100 100644
>> --- a/arch/powerpc/kernel/misc_32.S
>> +++ b/arch/powerpc/kernel/misc_32.S
>> @@ -700,7 +700,7 @@ _GLOBAL(start_secondary_resume)
>> 	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
>> 	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
>> 	li      r3,0
>> -	std     r3,0(r1)                /* Zero the stack frame pointer */
>> +	stw     r3,0(r1)                /* Zero the stack frame pointer */
>> 	bl      start_secondary
>> 	b       .
>>  #endif /* CONFIG_SMP */
>> 
