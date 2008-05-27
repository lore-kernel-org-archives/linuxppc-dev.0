Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 247CCDDFA2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:56:18 +1000 (EST)
Date: Tue, 27 May 2008 14:55:56 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <1211924335.3286.89.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
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



On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> 
> A problem with __raw_ though is that they -also- don't do byteswap,

Well, that's why there is __readl() and __raw_readl(), no?

Neither does ordering, and __raw_readl() doesn't do byte-swap.

Of course, I'm not going to guarantee every architecture even has all 
those versions, nor am I going to guarantee they all work as advertised :)

For x86, they have historially all been 100% identical. With the inline 
asm patch I posted, the "__" version (whether "raw" or not) lack the 
"memory" barrier, so they allow a *little* bit more re-ordering.

(They won't be re-ordered wrt spinlocks etc, unless gcc starts reordering 
volatile asm's against each other, which would be a bug).

In practice, I doubt it matters. Whatever small compiler re-ordering it 
might affect won't have any real performance impack one way or the other, 
I think.

		Linus
