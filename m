Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3155667B72
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:07:14 +1000 (EST)
Date: Wed, 20 Sep 2006 09:07:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Subject: Re: [POWERPC] convert string i/o operations to C
Message-Id: <20060920090706.436ffdc9.sfr@canb.auug.org.au>
In-Reply-To: <28673.1158669778@warthog.cambridge.redhat.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<28673.1158669778@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Sep 2006 13:42:58 +0100 David Howells <dhowells@redhat.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> > +{
> > +	asm volatile("sync");
> > +	if (ns <= 0)
> > +		return;
> 
> What is "ns" meant to do?  It seems to degrade the _insb() op to just a sync,
> but is that correct?

"ns" is the count (maybe I should rename the parameter, but that is what
was in the prototype in io.h).  The "sync" is in the same place as it was
in the assembler code that this replaces.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
