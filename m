Return-Path: <josh@joshtriplett.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by ozlabs.org (Postfix) with ESMTP id DB2CE2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 09:04:18 +1100 (EST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id 928B84866B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 22:30:32 +0100 (CET)
Date: Fri, 7 Mar 2014 13:30:17 -0800
From: josh@joshtriplett.org
To: Joe Perches <joe@perches.com>
Subject: Re: rfc: checkpatch logical line continuations (was IBM Akebono:
 Add support for a new PHY interface to the IBM emac driver)
Message-ID: <20140307213017.GA18769@cloud>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
 <1394226164.16156.96.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394226164.16156.96.camel@joe-AO722>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, devicetree@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>, alistair@popple.id.au,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2014 at 01:02:44PM -0800, Joe Perches wrote:
> On Fri, 2014-03-07 at 15:41 -0500, David Miller wrote:
> > From: Alistair Popple <alistair@popple.id.au>
> > Date: Thu,  6 Mar 2014 14:52:25 +1100
> > 
> > > +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> > > +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);
> > 
> > When an expression spans multiple lines, the lines should end with
> > operators rather than begin with them.
> 
> That's not in CodingStyle currently.

It's also not even remotely consistent across existing kernel code, and
it isn't obvious that there's a general developer consensus on the
"right" way to write it.

> Right now, checkpatch emits a --strict only warning on "&&" or "||"
> at the beginning of line but that could be changed to any "$Operators"
> 
> our $Arithmetic = qr{\+|-|\*|\/|%};
> our $Operators	= qr{
> 			<=|>=|==|!=|
> 			=>|->|<<|>>|<|>|!|~|
> 			&&|\|\||,|\^|\+\+|--|&|\||$Arithmetic
> 		  }x;
> 
> The ones that likely have a too high false positive rates
> are the negation "!" and bitwise "~".

I don't think warning about operators at start of line seems like a good
idea at all.  There are plenty of cases where putting the operator at
the start of the line will produce a better result.  (I'd actually
suggest that in *most* cases.)

> Also, using perl, it's hard to distinguish between a
> logical "&" and the address-of "&" as well as the
> multiplication "*" and indirection "*" so maybe those
> should be excluded too.
> 
> And I think it should only be added as a --strict test.

Agreed, if even that.

- Josh Triplett
