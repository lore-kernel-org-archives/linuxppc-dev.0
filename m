Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8688BB7CEA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 18:09:18 +1100 (EST)
Date: Thu, 11 Feb 2010 18:09:14 +1100
From: Nick Piggin <npiggin@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
Message-ID: <20100211070914.GB6735@laptop>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210111025.GF3399@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 10:10:25PM +1100, Anton Blanchard wrote:
> 
> Nick Piggin discovered that lwsync barriers around locks were faster than isync
> on 970. That was a long time ago and I completely dropped the ball in testing
> his patches across other ppc64 processors.
> 
> Turns out the idea helps on other chips. Using a microbenchmark that
> uses a lot of threads to contend on a global pthread mutex (and therefore a
> global futex), POWER6 improves 8% and POWER7 improves 2%. I checked POWER5
> and while I couldn't measure an improvement, there was no regression.

Ah, good to see this one come back. I also tested tbench over localhost
btw which actually did show some speedup on the G5. 

BTW. this was the last thing left:
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg29738.html

Don't know if you took a look at that again, but maybe it's worth
looking at. Hmm, we do actually seem to be growing number of smp_mb*
calls in core kernel too.
