Return-Path: <jacmet@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 60E7ADDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 06:26:24 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so1551578hsb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:26:05 -0800 (PST)
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
References: <20080219150916.263032000@sunsite.dk>
	<20080219151149.684610000@sunsite.dk>
	<20080219235554.GA13304@kroah.com>
	<87bq6cf1cb.fsf@macbook.be.48ers.dk> <20080220161608.GE2658@kroah.com>
	<874pc3efbx.fsf@macbook.be.48ers.dk> <20080220170300.GB3453@kroah.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 20 Feb 2008 20:25:56 +0100
In-Reply-To: <20080220170300.GB3453@kroah.com> (Greg KH's message of "Wed\,
	20 Feb 2008 09\:03\:00 -0800")
Message-ID: <87fxvnctvf.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

 >> Sorry, I cannot reproduce that here. Could you try again?

 Greg> I will on the next round :)

Ok.

 Greg> Can you move the files under the hcd/ subdir

 Greg> Oops, I ment "host/" not, "hcd/".

Yeah, I guessed ;)

 >> Sorry, I don't think that's a good idea as the hardware can do
 >> peripheral as well, and as you can see in patch 4, a gadget driver is
 >> on it's way.

 Greg> Ok, that's fine, why can't the gadget stuff go into the gadget/
 Greg> directory then also?  As this device is a host controller, it makes
 Greg> sense to me to keep it in the host-controller subdirectory.

Because of the way the driver (and hardware) is structured. There is a
single c67x00.ko which can contain both hcd and gadget support
depending on Kconfig.

 Greg> run it through checkpatch.pl and fix up the __FUNCTION__
 Greg> warnings, and then I'll be willing to test it again :)
 >> 
 >> Ahh, that seems to be a pretty new warning in checkpatch - I atleast
 >> haven't seen it before. The other things it complains about seems to
 >> be rubbish though (except for the single indented label).

 Greg> What other things do you think are rubbish?

It misdetected a #define as a functions and complained, E.G.:

WARNING: no space between function name and open parenthesis '('
#298: FILE: include/linux/usb/c67x00.h:41:
+ #define C67X00_SIE2_PERIPHERAL_B	(C67X00_SIE_PERIPHERAL_B	<< 4)

But ok, the space before the #define shouldn't have been there.

 Greg> And yes, it's a new warning with the advent of 2.6.25-rc1, but
 Greg> that's no reason to ignore it :)

Sure. it's fixed in the v9 series.

-- 
Bye, Peter Korsgaard
