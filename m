Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [12.110.71.38])
	by ozlabs.org (Postfix) with ESMTP id E75BCDDECB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 07:58:22 +1000 (EST)
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2795E6@twx-exch01.twacs.local>
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: RE: Still trying to get a stable 2.6.20.4 running on 8349ITX evalboard
MIME-Version: 1.0
Message-ID: <OF2330A747.4AF0C4FD-ON882572BB.0077B95A-882572BB.0078B180@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 12 Apr 2007 14:58:17 -0700
Content-Type: text/plain; charset="US-ASCII"
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

Hi all,

"Benedict, Michael" <MBenedict@twacs.com> wrote on 04/12/2007 12:27:35 PM:

> >Your problem looks very much like odd DDR or memctl 
> >misconfiguration early in u-boot.
> >Please try upgrading your firmware with the latest u-boot from 
> >git tree at denx.de. Kernel from Paul Mackerras (powerpc.git) 
> >is also a good thing to give a try.
> 
> This is definetly something related to u-boot.  I was using a new Denx
> git u-boot for flat device tree support.  If I boot a kernel with
> hardcoded ethernet-phy registers on the shipping u-boot the system is
> much more stable.  Now I am trying to track down the differences between
> the u-boot the freescale shipped on the device verse the newest git
> sources.  Hopefully some initialization is missing that will be very
> obvious.
>    Cheers,
>       Michael
> 

SUCCESS!!!  (Or at least a HUGE step forward.)  Once I got to thinking 
about memory timing I remembered that the 8349itx u-boot port allows the 
choice of using SPD for detecting the DDR RAM or using hard coded defaults 
in the memory controller.  I figured what the heck, I'll give the hard 
coded values a try even though they were probably wrong for the particular 
part I've got installed.  And the bloody thing ran!  I had it executing a 
forever loop for 35 minutes, which is about 34 and a half minutes longer 
than it's ever run before!

It still augured in on me, but the processor was so locked up/confused 
that I couldn't even get the BDI to reset it, I had to cycle power.  I'm 
inclined to think it was probably an ESD event, since I've got the cover 
off the box.

Thanks to everyone who offered suggestions, especially Ed and Vitaly for 
suggesting looking at the RAM.  I was in no way, shape, or form thinking 
along those lines.  Now I've got something I can actually dig on.  I'll 
post a followup here and on the u-boot mailing list if I find anything 
wrong in "public" code.

Thanks again.

Bruce


------------------------------------------------

This e-mail may contain SEL confidential information.  The opinions
expressed are not necessarily those of SEL.  Any unauthorized disclosure,
distribution or other use is prohibited.  If you received this e-mail in
error, please notify the sender, permanently delete it, and destroy any
printout.

Thank you.

------------------------------------------------
