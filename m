Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CCAC682E5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Sep 2005 11:28:11 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17196.5625.322927.221055@cargo.ozlabs.ibm.com>
References: <1126956437.4171.20.camel@baythorne.infradead.org>
	<17196.5625.322927.221055@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 11:23:22 +1000
Message-Id: <1127006602.23095.1.camel@gaston>
Mime-Version: 1.0
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Davide Libenzi <davidel@xmailserver.org>, viro@ftp.linux.org.uk
Subject: Re: Repeated corruption of file->f_ep_lock
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-09-17 at 23:11 +1000, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > The previous and next members of 'struct file', which are f_ep_list and
> > f_mapping respectively, are always fine. It's just f_ep_lock which is
> > scribbled upon, and the scribble is fairly repeatable: 'owner_cpu' is
> > almost always set to 0x901 but occasionally 0x501, and the 'lock' field
> > has values like 20282484, 24042884, 28022484, 24042084, 22000424 (hex).
> > Do those numbers seem meaningful to anyone? Any clues as to where they
> > might be coming from?
> 
> They look like part of an exception stack frame.  The 901 or 501 would
> be the trap number; 500 for an external interrupt or 900 for a
> decrementer interrupt, plus 1 which we use as a marker to say that
> only the volatile registers have been saved in the frame.  The other
> values (20282484 etc.) could possibly be condition register values.
> That would fit with owner_cpu being 2 words past the lock field; the
> trap field in struct pt_regs is 2 words past the ccr field.

kernel stack overflow ? Also, you could try using the DABR (Data Access
Breakpoint) if any on your CPU to try to catch at the instant of the
corruption...

Ben.
