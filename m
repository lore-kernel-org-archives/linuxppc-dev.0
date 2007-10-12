Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71BBADDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:58:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9CBvxEO028623
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:57:59 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9CBvxfU458288
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 05:57:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9CBvxgU018504
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 05:57:59 -0600
Subject: Re: [PATCH] [POWERPC] Use PAGE_OFFSET to tell if an address is
	user/kernel in SW TLB handlers
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071012033032.GH21056@localhost.localdomain>
References: <Pine.LNX.4.64.0710111341140.27045@blarg.am.freescale.net>
	<20071012033032.GH21056@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 06:56:24 -0500
Message-Id: <1192190184.3061.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-10-12 at 13:30 +1000, David Gibson wrote:
> On Thu, Oct 11, 2007 at 01:42:30PM -0500, Kumar Gala wrote:
> > Move to using PAGE_OFFSET instead of TASK_SIZE or KERNELBASE value on
> > 6xx/40x/44x/fsl-booke to determine if the faulting address is a kernel or
> > user space address.  This mimics how the macro is_kernel_addr()
> > works.
> 
> Actually it's ambiguous whether TASK_SIZE or PAGE_OFFSET is correct in
> most of these cases (KERNELBASE is certainly wrong, though).
> 
> TASK_SIZE is the top of the userspace mapped area, PAGE_OFFSET is the
> bottom of the linear mapping.  So, strictly speaking there are 3 paths
> for the miss handlers: < TASK_SIZE => user mapping, >= PAGE_OFFSET =>
> kernel mapping, between the two => immediate fault.
> 
> We get away with a two way comparison on 32-bit because, a) they have
> the same value and b) none of the pagetables, user or kernel, should
> have any entries in the in between region so we'll end up in
> do_page_fault in the end, anyway.

Kumar's other patch removes the gap.  He changed the default
CONFIG_TASK_SIZE to 0xc0000000.

josh
