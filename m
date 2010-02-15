Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2480CB7CF8
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 15:15:12 +1100 (EST)
Subject: Re: [PATCH] powerpc: Don't clear larx reservation on system call exit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100215040657.GA24270@kryten>
References: <20100215014028.GB13355@kryten>
	<1266200687.16346.110.camel@pasglop>  <20100215040657.GA24270@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Feb 2010 15:15:07 +1100
Message-ID: <1266207307.16346.119.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-15 at 15:06 +1100, Anton Blanchard wrote:
> 
> Yeah that was my primary concern. Right now these things fail 100%, so
> no one is relying on it. The worry is if people start writing their own
> crazy low level system call + locking stubs that might work most of the
> time (if we remove the stwcx in syscall exit).

Worse than that. It will look like it works, but it won't really since
the dangling reservation matches a completely unrelated lwarx done by
the kernel and not the original userspace one, so the stwcx. might
succeed despite the fact that the original value -was- changed.

So it's really a matter of documentation I suppose but we have to be
careful as I've learned with time that there is nothing too silly for
userspace to do :-)

> Good point, I hadn't thought of signals and I agree we'd need to clear the
> reservation in the sigreturn path.

Right. As I said, I'm pretty sure it will happen as a side effect of
other things but I'd rather pay the small price of having an explicit
blurb to do it in sigreturn regardless.

Cheers,
Ben.
