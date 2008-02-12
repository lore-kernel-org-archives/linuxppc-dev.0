Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id AC01EDDFFD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:58:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1388678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:58:57 -0800 (PST)
Message-ID: <fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
Date: Tue, 12 Feb 2008 11:58:57 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
In-Reply-To: <47B1BEE7.4050808@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 8:44 AM, Timur Tabi <timur@freescale.com> wrote:
> Arnd Bergmann wrote:
>
> > On Tuesday 12 February 2008, David Gibson wrote:
> >> Or to expand.  It's relatively easy now to just include multiple nodes
> >> in the tree and either delete or nop some of them out conditionally
> >> using libfdt.
>
> Yes, but what better place to store the conditions than in the device tree
> itself?  How would libfdt know where the conditions are?  Do you want to have
> two binary blobs?

The transient state of the dts before it is handed to the kernel
proper is almost irrelevant.  It is totally reasonable to add in
whatever properties/nodes that are needed to *eventually* describe the
hardware correctly.  Heck, we already do this will all dts files that
go through u-boot is a simple sense.  We put placeholder properties
for mac addresses and bus frequencies, but u-boot fills them in.

However, if a designer does write a device tree containing more nodes
than is needed, then it is also the responsibility of that designer to
make sure the boot loader can use that tree to generate a real
description of hardware.  This requires coordination and
documentation, but id does not requires special formatting or
versioning of the device tree blob.

The dtb is a data structure, not a programming language.  I think it
is a slippery slope to try and encode conditionals into the structure;
but it is entirely reasonable to encode *data* into the dt that helps
make those conditional decisions.

> >> But the conditional logic should be in the manipulating
> >> agent (u-boot or bootwrapper or whatever), there's no way we're going
> >> to require a conditional expression parser to interpret the device
> >> tree blob itself.
>
> I think it's a great feature that solves a lot of problems, and it does so in an
> elegant and efficient manner.  I look forward to trying to change your mind when
> I get around to implementing it.

I agree with David here; logic belongs in the agent code, not the data
structure.

> > How about making the logic to nop out nodes a little more generic
> > without changes to the binary format?
> > E.g. you could have a "linux,conditional-node" property in the device
> > tree whose value is compared to a HW configuration specific string.
>
> The problem with this is that if you use a version of libfdt that does not
> understand "linux,conditional-node", then your device tree will be wrong,
> because it could contain nodes that don't belong.  We would need a new,
> incompatible version number for the device tree to make sure that this doesn't
> happen, even though nothing has changed in the binary layout of the tree.

We've already got that issue.  If you pass the device tree for the
wrong board it will still validate correctly, but the board is not
going to boot.  The device tree must match what the bootloader
expects.  Changing the version number will do nothing to help this.
The version number ensures that the tree is parsable.  It does not
ensure that it is correct.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
