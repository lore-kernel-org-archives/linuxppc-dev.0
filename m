Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E79A8DDFF9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 09:20:15 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <OFB4FD81AE.95147932-ON862572EA.007EAB56-862572EA.007FDB77@us.ibm.com>
References: <OFB4FD81AE.95147932-ON862572EA.007EAB56-862572EA.007FDB77@us.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 09:19:59 +1000
Message-Id: <1180480799.19517.214.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 18:16 -0500, Steve Munroe wrote:
> 
> The pad field may be occupied with data if the code was compiled on a
> older
> distro and ucontext_t is misaligned (an odd Doubleword). So the pad
> field
> is free for reuse onless you version the code to handle unalligned VMX
> registers.

Actually... there are two pad areas ... also, I would only use that on
contexts that I generated myself (signal contexts) so I suppose that
should be allright.
 
> > Do you see any possible compatibility problem there ? Do you know of
> any
> > piece of software that makes hard assumptions on the shape and size
> of a
> > complete signal frame (not just the ucontext part of it) ?
> >
> 
> The signal frame can change, as long as the relative offset and size
> of the
> ucontext_t is unchanged. 

Ok.

Ben.
