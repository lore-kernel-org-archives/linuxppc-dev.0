Return-Path: <mh@omnisys.se>
Received: from ch-smtp01.sth.basefarm.net (ch-smtp01.sth.basefarm.net
	[80.76.149.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37A0BDE124
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 23:04:36 +1100 (EST)
Subject: Re: Frustrated question with insmod
From: Magnus Hjorth <mh@omnisys.se>
To: Bruce_Leonard@selinc.com
In-Reply-To: <OFE029FE92.B8F9D4B0-ON882573F2.002B93E9-882573F2.002C385D@selinc.com>
References: <OFE029FE92.B8F9D4B0-ON882573F2.002B93E9-882573F2.002C385D@selinc.com>
Content-Type: text/plain
Date: Sun, 17 Feb 2008 13:04:22 +0100
Message-Id: <1203249862.5245.11.camel@magnus-desktop>
Mime-Version: 1.0
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


On Sun, 2008-02-17 at 00:03 -0800, Bruce_Leonard@selinc.com wrote:
> > 
> > 'cat /proc/modules' perhaps?
> 
> I tried that, but it gives me an odd address (at least I think it's an odd 
> address): 0xE1188000.  I use that address in GDB for adding the symbol 
> table (i.e., add-symbol-file mymodule 0xE1188000), but then the BDI 
> reports "*** MMU: address translation for 0xE118822C failed" when I try to 
> set a breakpoint in the probe function.  Admittedly I'm new to driver 
> writing, but shouldn't the address be somewhere in the 0xC0xxxxxx range?

I believe the modules live in the kernel's dynamically allocated memory
area in the 0xExxxxxxx range.. 

Can you set breakpoints anywhere in the kernel? Try picking a function address from System.map and set a breakpoint there.

I have little experience with what you're doing, but my guess is that you're setting the breakpoint in the wrong context, probably standing in userspace..

> 
> > 
> > //Magnus
> > 
> > 
> > On Fri, 2008-02-15 at 17:06 -0800, Bruce_Leonard@selinc.com wrote:
> > > Sorry if this is the wrong place to post this question.  I'm 
> developing a 
> > > NAND flash driver and I need to do some detailed dubugging using GDB 
> with 
> > > a BDI2K.  According to the Denx web site, to find out the address that 
> the 
> > > module is loading at you load it using the -m parameter to insmod 
> (i.e., 
> > > "insmod -m mymodule").  However, every version of insmod I've tried 
> > > doesn't recognize ANY options much less -m.  Can anyone please point 
> me in 
> > > the right direction, or give me another way of knowing what the load 
> > > address of my module is?
> > > 
> > > Thanks.
> > > 
> > > Bruce
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
