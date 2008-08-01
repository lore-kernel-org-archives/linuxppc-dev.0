Return-Path: <imp@bsdimp.com>
Date: Fri, 01 Aug 2008 10:01:07 -0600 (MDT)
Message-Id: <20080801.100107.-1666252871.imp@bsdimp.com>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: Board level compatibility matching
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20080801111141.3543e23b@zod.rchland.ibm.com>
References: <1217564739.11188.482.camel@pasglop>
	<fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
	<20080801111141.3543e23b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd float a radical definition of 'compatible' here.

If the generic code can handle it with just changes to the device
tree, then it is compatible.  And by generic code, I wouldn't suggest
a twisty maze of ifdefs or special case hacks.  I'm talking truly
generic code that is table driven entirely from the dtc.  If you need
special C code to initialize the board, then it isn't compatible.

This is exactly analogous to the pc-net driver supporting dozens of
different cards that differ only in their ID.  Are all these cards
100% the same: no.  There's plenty of differences between them.
However, the pc-net driver copes with the small differences so that
one driver can handle most of the ne2000 class of network cards.

Are there special drivers for ne2000-like cards that aren't quite
compatible enough or have extra features, sure.

That doesn't totally invalidate the utility.  There are always
engineering trade offs to be made.

Warner
