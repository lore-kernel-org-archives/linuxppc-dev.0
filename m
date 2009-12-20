Return-Path: <hunter.cobbs@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id D144FB6F01
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 07:13:50 +1100 (EST)
Received: by yxe8 with SMTP id 8so4889353yxe.17
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Dec 2009 12:13:48 -0800 (PST)
Subject: Re: DWC_OTG Issues
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20091219185657.5FF29E85072@gemini.denx.de>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
	<1261190115.14590.5.camel@mobiLinux>
	<20091219185657.5FF29E85072@gemini.denx.de>
Content-Type: text/plain
Date: Sun, 20 Dec 2009 14:13:45 -0600
Message-Id: <1261340025.3473.15.camel@mobiLinux>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Well, thank you for the assurance on the Synopsis drivers not being in
conflict.  That makes me feel a little better.

We're using Linux 2.6.30(.3)-denx.  We've worked on this issue a bit
before, although at the time you were doing some work for AMCC on just
accessing devices across a hub in general.  We've been using the driver
for a few months now and it is very stable on first-use of the driver,
but once we close a full-speed port and try to reopen, that's when we
get error concerning not being able to allocate resources and getting
-28 errors.  I don't have anything precise in front of me at the moment,
my test equipment is at the office.  But this seems to be the issues
that lead to the Enhanced Transaction Translation Scheduling changes in
the main-line kernel.

I'm mainly being, I believe, overly cautious about not including GPL
code in the Synopsis driver simply because I'd rather be overly careful
than be exposed to some liability later down the road if Synopsis
decides they want to make their driver completely proprietary.  While
the code is available, I'm not sure if we can include code from GPL
sources in the Synopsis drivers without requiring the Synopsis driver to
become completely GPL.  I am also not a lawyer, but I'd rather be
cautious.

I did do a comparison on the previous branch we are (2.6.30.3-denx) and
the current stable.  The only differences in the code were minor enough
that I simply merged them into our existing codebase.  It didn't really
help our issue, but on block transfers and standard connect/disconnect
the driver seemed more responsive.  I believe this was mainly from 
Setphan's actions to put some sleeps inside of tight loops that would
chew up major CPU time on a non-preemptable kernel(which we had earlier).

On Sat, 2009-12-19 at 19:56 +0100, Wolfgang Denk wrote:
> Dear Hunter Cobbs,
> 
> In message <1261190115.14590.5.camel@mobiLinux> you wrote:
> > Hello list.  I've run into a rather odd problem.  I seem to have a
> > problem with full-speed isochronous transfers across a USB2.0 Hub.  I
> > believe this was observed before with the general EHCI drivers in Linux.
> 
> Which exazct kernel / driver cversions are you talking about?
> 
> > In the latest branch of the kernel, the EHCI driver has some "Enhanced
> > Transaction Translation" scheduling.  This would be great for me to use
> > as it seems to directly address the issues I've seen.  However, I'm not
> > really sure on how to proceed because the DWC_OTG driver is not GPL code
> 
> Oops? if that wa the case you could not use (and distribute) this code
> in a Linux context at all.
> 
> > while the EHCI code I'd like to use is.  Therefore, I don't believe that
> > I can port the Enhanced Transaction Translation routine into the DWC_OTG
> > driver without violating both the GPL and Synopsis's own driver.
> 
> What makes you think so?
> 
> The Synopsis dwc_otg driver license does not seem to be  in  conflict
> to  the  GPL,  if  you  ask  me (but then, I am not a layer). When we
> worked on this, we were assured that the use of this driver source in
> the context of GPLed software like the Linux kernel (or  U-Boot)  was
> not considered an issue by Synopsis.
> 
> > Does anyone have a suggestion on how to proceed?
> 
> We have been doing some work on the DWC drivers in the past, fixing a
> number of issues. [We never  attempted  to  psuh  any  of  this  into
> mainline  as  the  Synopsis  drivers  are  -  in  our  opinion  - not
> avcceptable for mainline but require more  or  less  a  rewrite  from
> scratch. But you can find all this stuff in our linux-2.6-denx repo.]
> 
> I recommend you give a try to our latest stable branch.
> 
> Best regards,
> 
> Wolfgang Denk
> 
