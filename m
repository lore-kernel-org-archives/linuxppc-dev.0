Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 10E1B67A8E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 03:03:51 +1000 (EST)
Message-ID: <4252C4F0.5000204@nortel.com>
Date: Tue, 05 Apr 2005 11:03:44 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <4251CEA4.6070604@nortel.com> <1112663005.26086.134.camel@gaston>
In-Reply-To: <1112663005.26086.134.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: somewhat OT -- trying to build code on the fly then run it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> bla can only be used for small addresses (or very high addresses), and
> it doesn't take a register argument but an absolute address. You want
> something different, more like
> 
> 	mtctr %2
> 	bctrl
> 
> Though you also need to add proper "clobber" constraints to indicate to
> the compiler what will be clobbered by the routine you are calling (look
> at the syscall macros of the kernel for an example of rather standard
> clobber lists).


Thanks for the tip.  With those changes, the code runs perfectly.  For 
posterity, the new function looks like this:

int dotest(void *p)
{
         int i=0;
         asm volatile (" \n\
                 mr 3,%1 \n\
		mtctr %2  \n\
		bctrl  \n\
                 mr %0,3 \n"
                 : "=r" (i)
                 : "r" (i), "r" (p)
		: "ctr", "lr");
         return i;
}


The bad news is that it seems to indicate that our kernel code to flush 
the icache doesn't seem to work.  I'll open a new thread for that.

Chris
