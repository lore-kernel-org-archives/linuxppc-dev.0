Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D7AFDEA52
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 04:38:37 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JIcYvN020440
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 14:38:34 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JIcYmG122202
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 14:38:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JIcXah027061
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 14:38:34 -0400
Date: Mon, 19 May 2008 13:34:28 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/3] [POWERPC] Move to runtime allocated exception
	stacks
Message-ID: <20080519133428.42b58ce1@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 14:04:54 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> For the additonal exception levels (critical, debug, machine check) on
> 40x/book-e we were using "static" allocations of the stack in the
> associated head.S.
> 
> Move to a runtime allocation to make the code a bit easier to read as
> we mimic how we handle IRQ stacks.  Its also a bit easier to setup the
> stack with a "dummy" thread_info in C code.

For the peanut gallery, I've started testing this series on 44x and
40x.  44x seems to be in fair shape.  It boots with all three applied
and breakpoints and single step work in gdb.  The only "issue" I found
was a warning during compile that Kumar already knows about.

40x is in rougher shape.  It boots with the first patch applied and
userspace seems to function well enough.  However whenever you try to
run something in gdb it will hang the board completely.  No panic,
board doesn't ping anymore, just hung.

I've by no means stress tested anything here, so for those of you that
are adventurous feel free to pitch in and test them out on your
boards ;).

josh
