Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0060.hostedemail.com
 [216.40.44.60]) by ozlabs.org (Postfix) with ESMTP id 1D7032C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 08:02:50 +1100 (EST)
Message-ID: <1394226164.16156.96.camel@joe-AO722>
Subject: rfc: checkpatch logical line continuations (was IBM Akebono: Add
 support for a new PHY interface to the IBM emac driver)
From: Joe Perches <joe@perches.com>
To: David Miller <davem@davemloft.net>
Date: Fri, 07 Mar 2014 13:02:44 -0800
In-Reply-To: <20140307.154142.488351276799532264.davem@davemloft.net>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Randy Dunlap <randy.dunlap@oracle.com>, devicetree@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>, alistair@popple.id.au,
 linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
 netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(added some cc's)

On Fri, 2014-03-07 at 15:41 -0500, David Miller wrote:
> From: Alistair Popple <alistair@popple.id.au>
> Date: Thu,  6 Mar 2014 14:52:25 +1100
> 
> > +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> > +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);
> 
> When an expression spans multiple lines, the lines should end with
> operators rather than begin with them.

That's not in CodingStyle currently.

Right now, checkpatch emits a --strict only warning on "&&" or "||"
at the beginning of line but that could be changed to any "$Operators"

our $Arithmetic = qr{\+|-|\*|\/|%};
our $Operators	= qr{
			<=|>=|==|!=|
			=>|->|<<|>>|<|>|!|~|
			&&|\|\||,|\^|\+\+|--|&|\||$Arithmetic
		  }x;

The ones that likely have a too high false positive rates
are the negation "!" and bitwise "~".

Also, using perl, it's hard to distinguish between a
logical "&" and the address-of "&" as well as the
multiplication "*" and indirection "*" so maybe those
should be excluded too.

And I think it should only be added as a --strict test.
