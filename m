Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FA7367F26
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 10:38:46 +1000 (EST)
Date: Sat, 6 Aug 2005 21:33:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050807003323.GB4828@dmt.cnet>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<20050806234244.GB5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050806234244.GB5210@cathedrallabs.org>
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

On Sat, Aug 06, 2005 at 08:42:44PM -0300, Aristeu Sergio Rozanski Filho wrote:
> > It already is exported, declared as
> > 
> > commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to comm processor */
> > 
> > 
> > and many drivers use the pointer directly.
> > 
> > arch/ppc/8260_io/ drivers also use the same convention.
> > 
> > Not sure I see much advantage in changing it?
> but not with EXPORT_SYMBOL(). I noticed this while compiling i2c stuff
> as module. 

Then other modules suffer from the same problem - what if you EXPORT_SYMBOL(cpmp)? 

> also, I think it's better add a function to do this instead
> doing EXPORT_SYMBOL() in a variable.
> what you think?

Well it is better in theory because it hides details, but in practice
I'm not sure its worth it - the CPM pointer (along with the whole immap)
never changes during runtime.
