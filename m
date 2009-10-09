Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F8DBB7B78
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 11:58:25 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <3DFBC735-4084-4A0C-BF8D-C9B33142FE69@embeddedalley.com>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
	<1255033705.2146.17.camel@pasglop>
	<34A4641D-8121-4EBC-9880-26CB70DD3339@embeddedalley.com>
	<1255040628.2146.54.camel@pasglop>
	<3DFBC735-4084-4A0C-BF8D-C9B33142FE69@embeddedalley.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 11:57:52 +1100
Message-Id: <1255049872.2355.24.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 17:36 -0700, Dan Malek wrote:
> On Oct 8, 2009, at 3:23 PM, Benjamin Herrenschmidt wrote:
> 
> > <<
> > • Reference and change bit updates—The MPC850 does not generate an  
> > exception for
> >   an R (reference) bit update. In fact, there is no entry for an R  
> > bit in the TLB.
> >   The change bit (C) is bit 23 in the level-two descriptor,  
> > described in Table 8-4.
> >   Software updates C (changed) bits, but hardware treats the C bit  
> > (negated) as a
> >   write-protect attribute. Therefore, attempting to write to a page  
> > marked unmodified
> >   invalidates that entry and causes an implementation-specific DTLB  
> > error exception.
> >   ^^^^^^^^^^^^^^^^^^^^^^
> >   If change bits are not needed, set the C bit to one by default in  
> > the PTEs.
> 
> How interesting....
> 
> I've looked at many 8xx docs and they all have the same text
> (probably cut/paste :-))  I'd place some debug code in the C functions
> to print out a few of the TLB Entry for various errors to see if this  
> really
> happens, and for other errors, too.  I guess I never stumbled into
> this because I always thought I had to do everything from software,
> so just made sure I did.

I'm not sure it's worth bothering :-) I'm happy to continue assuming we
need to tlbie and always make sure we do so.

Cheers,
Ben.
