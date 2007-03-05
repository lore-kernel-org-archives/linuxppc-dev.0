Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id E7332DDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 07:21:40 +1100 (EST)
Date: Mon, 5 Mar 2007 21:21:36 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 0/7] MPC5200 and Lite5200b low power modes
Message-ID: <20070305202136.GW3274@nd47.coderock.org>
References: <20070301075323.GP4397@moe.telargo.com>
	<45E89887.1070604@246tNt.com>
	<20070303073336.GC3276@nd47.coderock.org>
	<20070305105350.GX4397@moe.telargo.com>
	<45EBF7EA.1040204@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45EBF7EA.1040204@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 05/03/07 11:58 +0100, Sylvain Munaut wrote:
> Domen Puncer wrote:
> >   
> >>     
> >>>  - And if it is, won't a memcpy_io of the whole zone do the trick ?
> >>>       
> >> Oh, nice. I wasn't aware of _memcpy_{to,from}io. I'll try it.
> >>     
> >
> > OK, one can't copy the whole zone :-(
> > Ie. reading from MBAR+0x3B00 seems to freeze Linux.
> >
> > Currently I'm having something like (obsoletes PIC and SDMA patches):
> >   
> And does that work ?

Yes, it does.

> 
> I was also wondering if some registers don't need to be restored last.
> For example,
> the task status in sdma would be restored to 0 then just at the end set
> to their "real value".

I was wondering about that, but it seems to work as-is.
Any real test cases for which it would matter?

> 
> Saving / Restoring all theses system zones makes more sense to me than
> to just save / restore the pic & sdma and hoping than mpc52xx_setup_cpu
> will make the rest ...
> 
> But saving/restoring all the mbar isn't good either because peripheral
> drivers should handle their own setup restore. The suspend / resume
> method of the peripheral should differentiate how deep their suspending
> / resuming and do what's necessary accordingly.

I was aiming for that.


	Domen
