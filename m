Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DACEB7CFC
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 21:22:25 +1100 (EST)
Date: Wed, 17 Feb 2010 21:22:15 +1100
From: Nick Piggin <npiggin@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/6] powerpc: Use lwarx hint in spinlocks
Message-ID: <20100217102215.GR5723@laptop>
References: <20100210105728.GA3399@kryten> <20100211065617.GA6735@laptop>
	<20100217093714.GB24270@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100217093714.GB24270@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 08:37:14PM +1100, Anton Blanchard wrote:
>  
> Hi Nick,
> 
> > Cool. How does it go when there are significant amount of instructions
> > between the lock and the unlock? A real(ish) workload, like dbench on
> > ramdisk (which should hit the dcache lock).
> 
> Good question, I'll see if we can see a difference on dbench.

Well I misread your benchmark. Your test is using pthread mutexes in
order to basically exercise kernel's syscall and context switching and
futex code. Wheras I thought it was just a trivial lock/unlock
sequence being tested.

So I'm much more impressed with your numbers :) dbench would still
be interesting though.
