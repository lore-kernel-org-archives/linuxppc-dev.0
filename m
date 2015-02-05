Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB7D41A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 13:29:29 +1100 (AEDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 70E812085D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 21:29:27 -0500 (EST)
Date: Wed, 4 Feb 2015 18:29:24 -0800
From: Greg KH <greg@kroah.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
Message-ID: <20150205022924.GA20453@kroah.com>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
 <20150204184028.GA8061@kroah.com> <54D29A3E.9090201@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54D29A3E.9090201@Freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2015 at 04:16:30PM -0600, Emil Medve wrote:
> Hello Greg,
> 
> 
> Thanks for looking at this
> 
> On 02/04/2015 12:40 PM, Greg KH wrote:
> > On Wed, Feb 04, 2015 at 08:48:32AM -0600, Emil Medve wrote:
> >>
> >> Hello,
> >>
> >>
> >> This is the first attempt to publish the Freescale DPAA B/QMan drivers. They are
> >> not to be applied yet.  At this stage, this is more or less the drivers from the
> >> Freescale PowerPC SDK roughly squashed and split in a sequence of component
> >> patches. They still needs some work and cleanup before we expect to have them
> >> applied, but we appreciate early feedback
> > 
> > First off, why put these in staging?  What's keeping them from being
> > merged "properly"?
> 
> I was thinking they'll go into drivers/soc. Past some cleanup and some
> integration issues, nothing holds them back

Then spend the day or so to do that work and avoid staging entirely!

> > Secondly, if they are going to go into staging, then I need a TODO file
> > in the directory of the driver listing what needs to be done to move the
> > code out of staging, and who is responsible for the code.  Ideally a
> > MAINTAINERS entry as well.
> 
> Will get both lists, say, for the next post
> 
> > And finally, staging drivers should be self-contained, your .h files:
> > 
> >>  include/linux/fsl_bman.h                        |  517 +++++
> >>  include/linux/fsl_qman.h                        | 1955 +++++++++++++++++
> > 
> > Need to be in drivers/staging/<DRIVER_DIR>/ not in include/linux/
> > espeically as nothing outside of your driver needs these .h files.
> 
> These files contain the public interface(s) used by other devices
> connected to the B/QMan: FMan, PME, RMan, DCE, etc. Every driver/piece
> of code in need of a HW queue (QMan) or HW buffer allocator (BMan) will
> use these files

Ok, but you can't have in-kernel code depend on staging tree code,
sorry, so if you want it in staging, it has to be self-contained.  Yet
another reason for you to clean it up properly and merge it to the
correct place first.

good luck,

greg k-h
