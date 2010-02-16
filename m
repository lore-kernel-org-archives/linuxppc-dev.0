Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 006DFB7C98
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 15:17:47 +1100 (EST)
Date: Mon, 15 Feb 2010 22:22:38 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
Message-ID: <20100216042238.GB12167@lixom.net>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210111025.GF3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
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
> 
> This patch uses the lwsync patching code to replace the isyncs with lwsyncs
> on CPUs that support the instruction. We were marking POWER3 and RS64 as lwsync
> capable but in reality they treat it as a full sync (ie slow). Remove the
> CPU_FTR_LWSYNC bit from these CPUs so they continue to use the faster isync
> method.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Turns out this one hurts PA6T performance quite a bit, lwsync seems to be
significantly more expensive there. I see a 25% drop in the microbenchmark
doing pthread_lock/unlock loops on two cpus.

Taking out the CPU_FTR_LWSYNC will solve it, it's a bit unfortunate since
the sync->lwsync changes definitely still can, and should, be done.


-Olof
