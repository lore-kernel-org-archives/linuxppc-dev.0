Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [157.55.116.159])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3983B712A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 05:51:19 +1100 (EST)
Date: Tue, 1 Feb 2011 12:35:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: Steve Best <sfbest@us.ibm.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
Message-ID: <20110201123556.1eacbb44@udp111988uds.am.freescale.net>
In-Reply-To: <1296580906.5343.6.camel@dhcp-100-2-27.bos.redhat.com>
References: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<20110131134057.153d6844@udp111988uds.am.freescale.net>
	<1296580906.5343.6.camel@dhcp-100-2-27.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 1 Feb 2011 12:21:45 -0500
Steve Best <sfbest@us.ibm.com> wrote:

> 
> On Mon, 2011-01-31 at 13:40 -0600, Scott Wood wrote:
> > I don't see how this is a sane thing to turn on by default (you're not
> > restricting it, BTW -- you're completely disabling it with that
> > implementation of devmem_is_allowed).  It will break anything that
> > uses /dev/mem to access I/O, 
> 
> could you expand on what I/O depends on /dev/mem, so I can take
> that into account?

It could be anything.  You're shutting off, by default, a
longstanding userspace interface, that already has adequate security
protection.

Even x86 doesn't default it to yes (though it does say "if in doubt
say Y"), and when enabled x86 only restricts access to memory, not I/O.

> > possibly including desktoppy stuff like X
> > servers, 
> 
> you are right just found out that X needs to access it. will 
> take that into account
> > as well as lots of stuff that goes on in embedded setups.
> 
> could you explain more about what needs access to /dev/mem in 
> the embedded setups?

All sorts of custom stuff -- userspace drivers, special memory regions
reserved at boot, etc.

If you really want this, I suggest prohibiting access only when it's an
actual RAM page tracked by the kernel (maybe only when PageReserved
is unset as well?), or when iomem_is_exclusive returns true.

-Scott
