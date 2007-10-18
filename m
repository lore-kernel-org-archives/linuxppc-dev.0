Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id A52DBDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:12:50 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so208018rvf
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:12:49 -0700 (PDT)
Message-ID: <fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
Date: Thu, 18 Oct 2007 12:12:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH v3] Device tree bindings for Xilinx devices
In-Reply-To: <20071018174956.05D7A1AA008D@mail197-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
	<20071018174956.05D7A1AA008D@mail197-blu.bigfish.com>
Cc: Leonid <Leonid@a-k-a.net>, Arnd Bergmann <arnd@arndb.de>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> > -----Original Message-----
> > From: Grant Likely [mailto:grant.likely@secretlab.ca]
> > Sent: Thursday, October 18, 2007 10:23 AM
> > To: linuxppc-dev@ozlabs.org; Stephen Neuendorffer; Wolfgang
> > Reissnegger; Leonid; microblaze-uclinux@itee.uq.edu.au; Josh
> > Boyer; Arnd Bergmann
> > Subject: [PATCH v3] Device tree bindings for Xilinx devices
> >
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> This is good enough for the moment, and it reflects the best we can do
> right now...  But:
>
> > +     (parameter#):   C_* parameters from system.mhs.  The C_
> > prefix is
> > +                     dropped from the parameter name, the
> > name is converted
> > +                     to lowercase and all underscore '_'
> > characters are
> > +                     converted to dashes '-'.
>
> Unfortunately, xparameters don't follow this exactly, particularly for
> the 'multiple logical devices' case...  Maybe it's worth adding
> something like: "For simple devices, the parameter name can be formed
> by:"

What specific parts of this are you concerned about? Examples?

>
> In any event, this should essentially document what the mechanism for
> generating the device trees actually does...  Have you updated
> gen_mhs_devtree.py to reflect all this?

No; I'm looking at this as a line in the sand that we can use as a
starting point and discuss the issues.

>
> > +   Typically, the compatible list will include the exact IP
> > core version
> > +   followed by an older IP core version which implements the same
> > +   interface or any other device with the same interface.
>
> This seems to be awkward, since it means that the tree *and* the driver
> will likely have long lists of compatible types.  In the driver, this is
> hard to maintain, and in the device tree we don't have an easy way of
> knowing exactly what is compatible and what isn't anyway...  It seems
> better to me to have the
> compatible list include the exact type (e.g. xilinx,opb-uartlite-1.00.b)
> and
> a generic compatibility class (e.g. xilinx,uartlite), and for the
> drivers
> to essentially define the gross compatibility classes.  Then the driver
> only has an of_match with:
>
>  .compatible = "xilinx,uartlite"

The problem with this is how do you define what "xilinx,uartlite" is?
For example; there have been 3 major versions of the plb_temac, and
IIRC v2 and v3 are *not* compatible.  Which one is xilinx,temac?

However, this does not need to result in a long list.  Basically, the
list should include the exact version of the device plus the first
version that implemented that interface.  (hence it is "compatible"
with the earlier version of the device).  If there are no prior
devices implementing the same device, then the compatible list has
exactly one instance.  This document should probably include a list of
the well-known compatible values for each of the xilinx devices.

I used to try and come up with generic values for compatible, but it
just ends up causing problems in the long run.  The concept of what is
generic changes over time, but a specific version is a known quantity.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
