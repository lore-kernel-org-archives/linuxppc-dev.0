Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415hW00CR3zDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 08:38:51 +1000 (AEST)
Received: by mail-qk0-f196.google.com with SMTP id r66-v6so2553703qkr.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 15:38:51 -0700 (PDT)
Subject: Re: [RFC,00/12] Deal with TM on kernel entry and exit
To: Cyril Bur <cyrilbur@gmail.com>, mikey@neuling.org, benh@kernel.crashing.org
References: <20180220002241.29648-1-cyrilbur@gmail.com>
From: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <50bf94bd-1367-1a99-1331-35f6562cedd5@debian.org>
Date: Wed, 13 Jun 2018 19:38:42 -0300
MIME-Version: 1.0
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On 02/19/2018 09:22 PM, Cyril Bur wrote:
> This is very much a proof of concept and if it isn't clear from the
> commit names, still a work in progress.

> I believe I have something that works - all the powerpc selftests
> pass. I would like to get some eyes on it to a) see if I've missed
> anything big and b) some opinions on if it is looking like a net
> improvement.

I started to look at this patchset. The patchset apply cleanly on top of the
current kernel and I started to run some tests.

It seems there is a different behavior when there is a trap (as a illegal
instruction or a 'trap' instruction) inside the transaction.

In this case, the signal handler does not seem to be called, and and the task
segfaults. On current upstream, the signal handler is called and the program
can continue.

4.17 pristine
-------------
	$ ./illegal
	Failure

4.17 plus your patches
----------------------
	$ ./illegal
	[1]    2504 segmentation fault  ./illegal


Here is a minimal example that is able to recreate this behaviour:

	#include <stdio.h>
	#include <signal.h>
	
	int htm(){
		asm goto ("tbegin.  		\n\t"
			  "beq %l[failure]	\n\t"
			  "li 3, 3		\n\t"
			  "trap 		\n\t"
			  "tend. 		\n\t"
			  : : : : failure);
	
		return 0;
	failure:
		printf("Failure\n");
		return 1;
	}
	
	void signal_handler(int signo, siginfo_t *si, void *data) {
		// Do nothing
	}
	
	int main(){
		struct sigaction sa;
	        sa.sa_flags = SA_SIGINFO;
	        sa.sa_sigaction = signal_handler;
	
	        sigaction(SIGTRAP, &sa, NULL);
	        sigaction(SIGILL,  &sa, NULL);
	
		return htm();
	}
