Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 6E060DDE1A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 09:24:47 +1000 (EST)
Date: Sun, 3 Jun 2007 16:25:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: ps3 64-bit kernel: patched prpmc2800.c (fwd)
Message-ID: <20070603232529.GA24977@mag.az.mvista.com>
References: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
	<18018.7868.811862.733793@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18018.7868.811862.733793@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Maik Nijhuis <maik@cs.vu.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 11:51:56AM +1000, Paul Mackerras wrote:
> Maik Nijhuis writes:
> 
> > I managed to fix this issue as follows: At the end of
> > arch/powerpc/boot/prpmc2800.c, there is an assembly instruction
> > 
> > rlwinm  10,10,0,~(1<<15)
> > 
> > I replaced this by
> > 
> > rlwinm  10,10,0,~(1<<15) & ((1<<32)-1)
> 
> It is a binutils bug, and Alan Modra has a patch for it.  In the
> meantime the best thing would be to change that to
> 
> 	rlwinm	10,10,0,17,15
> 
> which is equivalent.

Oops, I totally missed this thread.  I'll whip up a patch for this on Monday.

Mark
