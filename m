Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 99E73DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 01:23:23 +1000 (EST)
Subject: Re: Problems in 2.6 memory management on 8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Detlev Zundel <dzu@denx.de>
In-Reply-To: <m2fy5mcqut.fsf@sowhat.denx.de>
References: <m2fy5mcqut.fsf@sowhat.denx.de>
Content-Type: text/plain
Date: Thu, 24 May 2007 17:23:19 +0200
Message-Id: <1180020200.1468.51.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-24 at 15:07 +0200, Detlev Zundel wrote:
> Hi,
> 
> working on a 2.6.16 kernel on a 870 CPU, I ran into this strange
> behaviour exemplified by the simple attached demo program.  An icbi
> from userspace on an address that is mapped only lazily gets into an -
> though interruptible - loop. Locking the icbi target in question with
> mlock circumvents this problem.

8xx is buggy w.r.t cache instructions. They do not update the
DAR register in the TLB miss/TLB error handlers.
The TLB miss handler does not use the DAR reg but the TLB error
handler do. Thats why it works when you mlock the memory.

This bug isn't documented but Freescale has confirmed it.
You can search the archives some years back for more info.

 Jocke

> 
> I tested this code on 2.6.21 on 4xx and 82xx only to prove that those
> combinations, as expected, don't have this problem.  Vitaly Bordug was
> kind enough to test the code on an 8xx hw supported by a recent kernel
> and acknowledged it still being present.
> 
> As I don't have time to investigate this any further, I at least want
> to document this problem with this post.  Maybe someone else can help
> out here.
> 
> Thanks
>   Detlev
> 
> plain text document attachment (Makefile)
> CC=$(CROSS_COMPILE)gcc
> AS=$(CROSS_COMPILE)as
> CFLAGS=-g
> 
> %.o:	%.S
> 	$(CC) -c -o $@ $<	
> 
> all:	icbi
> 
> icbi:	icbi.o icbi_trigger.o
> 
> clean:
> 	rm -f *.o *~ icbi
> _______________________________________________ Linuxppc-dev mailing list Linuxppc-dev@ozlabs.org https://ozlabs.org/mailman/listinfo/linuxppc-dev
