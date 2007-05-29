Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E80B4DDFD7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 09:41:40 +1000 (EST)
Date: Tue, 29 May 2007 18:46:55 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Message-ID: <20070529234655.GA32367@lixom.net>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<9C7D27C7-674E-44B7-A975-69B2E85AB8F2@kernel.crashing.org>
	<1180474353.19517.190.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180474353.19517.190.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
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

On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
> > This is all problematic since some 64-bit implementations may not  
> > guarantee the upper bits are valid when in 32-bit mode.  Look at the  
> > 'Computation Modes' section in the architecture specs 2.03 or
> > greater  
> > for embedded processors. 
> 
> Yuck. Well, we might need to export a spearate CPU feature bit to
> indicate that it's the case then.

No need for a new bit, you should be able to key off of PPC_FEATURE_64
&& !PPC_FEATURE_BOOKE.


-Olof
