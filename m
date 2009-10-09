Return-Path: <dan@embeddedalley.com>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by ozlabs.org (Postfix) with SMTP id 5BC9CB7B76
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 11:35:45 +1100 (EST)
In-Reply-To: <1255040628.2146.54.camel@pasglop>
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
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <3DFBC735-4084-4A0C-BF8D-C9B33142FE69@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
Date: Thu, 8 Oct 2009 17:36:07 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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


On Oct 8, 2009, at 3:23 PM, Benjamin Herrenschmidt wrote:

> <<
> =95 Reference and change bit updates=97The MPC850 does not generate an =
=20
> exception for
>   an R (reference) bit update. In fact, there is no entry for an R =20
> bit in the TLB.
>   The change bit (C) is bit 23 in the level-two descriptor, =20
> described in Table 8-4.
>   Software updates C (changed) bits, but hardware treats the C bit =20
> (negated) as a
>   write-protect attribute. Therefore, attempting to write to a page =20=

> marked unmodified
>   invalidates that entry and causes an implementation-specific DTLB =20=

> error exception.
>   ^^^^^^^^^^^^^^^^^^^^^^
>   If change bits are not needed, set the C bit to one by default in =20=

> the PTEs.

How interesting....

I've looked at many 8xx docs and they all have the same text
(probably cut/paste :-))  I'd place some debug code in the C functions
to print out a few of the TLB Entry for various errors to see if this =20=

really
happens, and for other errors, too.  I guess I never stumbled into
this because I always thought I had to do everything from software,
so just made sure I did.

	-- Dan
