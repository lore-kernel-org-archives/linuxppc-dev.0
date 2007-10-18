Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21AE8DDF2E
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:53:39 +1000 (EST)
Date: Thu, 18 Oct 2007 15:52:13 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <1192745137.7367.40.camel@pasglop>
Message-ID: <alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 19 Oct 2007, Benjamin Herrenschmidt wrote:
> 
> The barrier would guarantee that ioc->active (and in fact the write to
> the chip too above) are globally visible

No, it doesn't really guarantee that.

The thing is, there is no such thing as "globally visible".

There is a "ordering of visibility wrt CPU's", but it's not global, it's 
quite potentially per-CPU. So a barrier on one CPU doesn't guarantee 
anything at all without a barrier on the *other* CPU.

That said, the interrupt handling itself contains various barriers on the 
CPU's that receive interrupts, thanks to the spinlocking. But I do agree 
with Herbert that adding a "smb_mb()" is certainly in no way "obviously 
correct", because it doesn't talk about what the other side does wrt 
barriers and that word in memory.

		Linus
