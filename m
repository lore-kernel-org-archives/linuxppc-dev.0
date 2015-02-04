Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83FB51A0374
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 05:48:05 +1100 (AEDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 6B5DA2093D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 13:40:29 -0500 (EST)
Date: Wed, 4 Feb 2015 10:40:28 -0800
From: Greg KH <greg@kroah.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
Message-ID: <20150204184028.GA8061@kroah.com>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
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

On Wed, Feb 04, 2015 at 08:48:32AM -0600, Emil Medve wrote:
> 
> Hello,
> 
> 
> This is the first attempt to publish the Freescale DPAA B/QMan drivers. They are
> not to be applied yet.  At this stage, this is more or less the drivers from the
> Freescale PowerPC SDK roughly squashed and split in a sequence of component
> patches. They still needs some work and cleanup before we expect to have them
> applied, but we appreciate early feedback

First off, why put these in staging?  What's keeping them from being
merged "properly"?

Secondly, if they are going to go into staging, then I need a TODO file
in the directory of the driver listing what needs to be done to move the
code out of staging, and who is responsible for the code.  Ideally a
MAINTAINERS entry as well.

And finally, staging drivers should be self-contained, your .h files:

>  include/linux/fsl_bman.h                        |  517 +++++
>  include/linux/fsl_qman.h                        | 1955 +++++++++++++++++

Need to be in drivers/staging/<DRIVER_DIR>/ not in include/linux/
espeically as nothing outside of your driver needs these .h files.

thanks,

greg k-h
