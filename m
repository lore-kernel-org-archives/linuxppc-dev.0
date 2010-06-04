Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D2B9B7D65
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 16:51:53 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id o546pmTN030830
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jun 2010 12:21:48 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o546plka2236530
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jun 2010 12:21:47 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o546pkJr025123
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jun 2010 16:51:47 +1000
Date: Fri, 4 Jun 2010 12:21:45 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100604065145.GA2408@in.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100602113316.GA17061@brick.ozlabs.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 02, 2010 at 09:33:16PM +1000, Paul Mackerras wrote:
> On Fri, May 28, 2010 at 12:09:24PM +0530, K.Prasad wrote:
> 
> > 	Please find a new set of patches that have the following changes.
> 
> Thanks.  There are a couple of minor things still remaining (dangling
> put_cpu in arch_unregister_hw_breakpoint, plus I don't think reusing
> current->thread.ptrace_bps the way you did in patch 5/5 is a good
> idea), but I think at this stage I'll put them in a tree together
> with my latest emulate_step version and then push them to Ben H and/or
> Ingo Molnar once I've done some testing.
> 
> Paul.

Hi Paul,
	Thanks for agreeing to put the patchset into a tree and push it
to the appropriate maintainers.

Meanwhile I tested the per-cpu breakpoints with the new emulate_step
patch (refer linuxppc-dev message-id:
20100602112903.GB30149@brick.ozlabs.ibm.com) and they continue to fail
due to emulate_step() failure, in my case, on a "lwz r0,0(r28)"
instruction.

About the latest patchset, given that we chose to ignore extraneous
interrupts for non-ptrace breakpoints, I thought that re-using
current->thread.ptrace_bps as a flag would be efficient than introducing
a new member in 'struct thread_struct' to do the same. I'm not sure if
you foresee any issues with that.

If so, I'd like to send a new patch (rather than a new version of the
complete patchset) to fix it along with the dangling put_cpu() in
arch_unregister_hw_breakpoint() (I forgot to remove parts of the code
between versions XIX and XX).

Thanks,
K.Prasad
