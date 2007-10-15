Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 07607DDF1D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 03:14:45 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2194817wag
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 10:14:44 -0700 (PDT)
Message-ID: <fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
Date: Mon, 15 Oct 2007 11:14:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: Refactor booting-without-of.txt
In-Reply-To: <20071015165505.GA16040@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071015165505.GA16040@lixom.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Oct 15, 2007 at 10:08:44AM -0600, Grant Likely wrote:
> > Adding the Linux expected device tree bindings to
> > booting-without-of.txt seems to be getting a little unwieldy.  Plus
> > with more than one arch using the device tree (powerpc, sparc &
> > microblaze) the device tree bindings aren't necessarily powerpc only
> > (the Xilinx devices certainly fall in this category).
> >
> > Anyone have comments about splitting the expected device tree bindings
> > out of booting-without-of.txt into a separate directory?
>
> The flat device tree is, in spite of what some people would like it to be,
> not open firmware, nor is it the same as their bindings. So I think we'd
> be doing ourselves a disservice by continuing to associate them together.
> All it would take is a rename of the directory, unfortunately i don't
> have any suggestions on better names though.

I think I need to stick with the of prefix.  All the support API in
include/linux/of_* is prefixed with "of_" already, so convention is
established.

How about Documentation/of-device-tree?

>
> > Perhaps something like this; each file contains common bindings for
> > the type of device and device specific properties:
> >
> > Documentation/of/
> > Documentation/of/README - Description of the purpose and layout of
> > this directory
> > Documentation/of/net.txt - network device bindings (eth, MDIO, phy, etc)
> > Documentation/of/serial.txt - serial device bindings
> > Documentation/of/misc.txt - anything that doesn't fit anywhere else yet.
> > Documentation/of/soc/* - System on chip stuff that doesn't fit will
> > into established device types; possibly a separate file for each chip.
> > Documentation/of/usb.txt - usb blah blah blah
> > Documentation/of/whatever - you get the picture.
> >
> > Thoughts?
>
> Looks reasonable. The other way to cut it would be to slice along vendor
> boundaries, but I think I like the functional partitioning you suggested
> better.

I think vendor partitioning makes sense for non-common devices that
don't easily fit into a particular mold (soc glue nodes come to mind).
 Other than that, the functional partitioning
lets us start with defining common property usage for a given device
type and follow up with device specific properties.

Thanks for the feedback,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
