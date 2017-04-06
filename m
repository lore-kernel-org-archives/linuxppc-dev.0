Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHw0gnNzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:04 +1000 (AEST)
In-Reply-To: <20170403064102.23245-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Avoid taking a data miss on every userspace instruction
 miss
Message-Id: <3vzNHv6zMZz9s9c@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 06:41:02 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Early on in do_page_fault() we call store_updates_sp(), regardless of
> the type of exception. For an instruction miss this doesn't make
> sense, because we only use this information to detect if a data miss
> is the result of a stack expansion instruction or not.
> 
> Worse still, it results in a data miss within every userspace
> instruction miss handler, because we try and load the very instruction
> we are about to install a pte for!
> 
> A simple exec microbenchmark runs 6% faster on POWER8 with this fix:
> 
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	unsigned long left = atol(argv[1]);
> 	char leftstr[16];
> 
> 	if (left-- == 0)
> 		return 0;
> 
> 	sprintf(leftstr, "%ld", left);
> 	execlp(argv[0], argv[0], leftstr, NULL);
> 	perror("exec failed\n");
> 
> 	return 0;
> }
> 
> Pass the number of iterations on the command line (eg 10000) and time
> how long it takes to execute.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7a9dcd882a67b68568868b988289f

cheers
