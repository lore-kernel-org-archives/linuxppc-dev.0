Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8CCC014008B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 22:56:25 +1100 (EST)
Message-ID: <1396266973.11529.77.camel@pasglop>
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Mon, 31 Mar 2014 22:56:13 +1100
In-Reply-To: <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-31 at 09:27 +1100, Stewart Smith wrote:
> Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
> >  struct rtas_error_log {
> > +#ifdef __BIG_ENDIAN__
> > +	/* Byte 0 */
> >  	unsigned long version:8;		/* Architectural version */
> > +	/* Byte 1 */
> 
> I think it would be great if we got rid of the usage of bitfields. As
> soon as the mood of the compiler changes, this code is going to break.

 ... as would a whole pile of kernel code including filesystems :)

Now, don't get me wrong, I hate bitfields as much as you do for the same
reasons. However (unfortunately ?) we've somewhat painted ourselves into
a corner here in kernel-land and I suspect gcc would have a very hard
time changing the format considering how many people did just the same
we did.

Now if we were a userspace program, I would still insist on fixing it on
the ground on not depending on gcc but this is the kernel ... we have
more gcc'isms than spots on the face of a 14 yrs old..

Cheers,
Ben.
