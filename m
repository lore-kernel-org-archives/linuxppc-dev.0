Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F3791A0548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:07:18 +1100 (AEDT)
Message-ID: <1421298437.11409.4.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
From: Michael Ellerman <michael@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Thu, 15 Jan 2015 16:07:17 +1100
In-Reply-To: <1421295393-sup-926@delenn.ozlabs.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421295393-sup-926@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-15 at 15:41 +1100, Ian Munsie wrote:
> Excerpts from Ryan Grimm's message of 2015-01-15 13:56:39 +1100:
> > Add reset_loads_image and reset_image_select to sysfs.
> > 
> > reset_image_select identifies which image will be loaded to the card on the
> > next PERST.  Valid entries are: "user" and "factory".
> > 
> > reset_loads_image defines functionality on a PERST.  Value of 0 means PERST
> > will not cause image load.  A power cycle is required to load the image.  Value
> > of 1 means PERST will cause image load.
> > 
> > sysfs updates the cxl struct in the driver then calls cxl_update_image_control
> > to write the vals in the VSEC.
> 
> Let's combine both of these into a single sysfs file, with "none",
> "user" and "factory" options and have the show & read functions handle
> mapping those three options to the two bits in the register.
> 
> Of the two names I'd probably go with reset_image_select.

Three words, all can be verbs, two can be nouns, it's not too clear.

Maybe "load_image_on_perst" ?

cheers
