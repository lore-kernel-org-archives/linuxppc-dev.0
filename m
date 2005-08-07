Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BD2D67F0F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 14:36:39 +1000 (EST)
Date: Sun, 7 Aug 2005 01:31:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050807043110.GA6316@dmt.cnet>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 06, 2005 at 10:40:37PM -0400, Dan Malek wrote:
> 
> On Aug 6, 2005, at 7:27 PM, Marcelo Tosatti wrote:
> 
> >It already is exported, declared as
> >
> >commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to 
> >comm processor */
> >
> >
> >and many drivers use the pointer directly.
> 
> We shouldn't be doing this.  All drivers should ioremap() any
> peripheral spaces they use and not make any assumptions
> someone else has done that already.  We've been making
> such changes in the 82xx/83xx/85xx CPM2 drivers.  If it
> isn't convenient to find the #defines for the ioremap(), we
> should change that.  When I originally wrote all of this
> code, it was long ago when we didn't have some of the
> abstractions and it seemed any shortcuts for performance
> were desired :-)

OK makes sense (yep it was even discussed already).

Aris, sounds like you should proceed with cpm_get_cpmp() and change all
other drivers using it also.

> 
> 
> >arch/ppc/8260_io/ drivers also use the same convention.
> 
> If there are any drivers in here, they either aren't used or
> on their way out.  The only things that should remain are
> common support functions.

OK!
