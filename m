Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A602DE125
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 03:32:03 +1000 (EST)
Date: Tue, 27 May 2008 10:31:14 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <alpine.LFD.1.10.0805270943100.2958@woody.linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0805271028520.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805270943100.2958@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 27 May 2008, Linus Torvalds wrote:
> 
> Here's a UNTESTED patch for x86 that may or may not compile and work, and 
> which serializes (on a compiler level) the IO accesses against regular 
> memory accesses.

Ok, so it at least boots on x86-32. Thus probably on x86-64 too (since the 
code is now shared). I didn't look at whether it generates much bigger 
code due to the potential extra serialization, but some of the code 
generation I looked at looked fine.

IOW, it doesn't at least create any _obviously_ worse code, and it should 
be arguably safer than assuming the compiler does volatile accesses the 
way we want it to.

		Linus
