Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 11:26:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030002619.GC29263@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<4725FA58.4030505@genesi-usa.com>
	<20071029172724.11354.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029172724.11354.qmail@farnsworth.org>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 10:27:24AM -0700, Dale Farnsworth wrote:
> Scott wrote:
> > Personally, I'm fine with just using name and compatible, but others such as
> > Stuart have expressed a desire for something to formally indicate compliance
> > with a standard binding.  I don't think we should expand the use of
> > device_type in any case.
> 
> I agree that the existing compatible property is sufficient to do
> what Stuart wants.  All that is required is to define some standard
> bindings and give them well-known names for the compatible property.
> If needed, we could define a prefix that indicates that a compatible
> entry refers to a standards-compliant binding.  For example,
> "standard,network", or "standard,display".  I don't see the benefit
> of creating a new property similar to device_type.

That would overload the meaning of compatible.  A driver which matches
any compatible entry should be able to drive the device, even if it
can't use all the devices features.  You can't do that if all you know
is that something is a display.

So, standardised or defacto-standard hardware-level interfaces belong
in compatible, e.g. ohci, uhci, ns16550.  The mere fact that something
is a display or network interface (and has *general* properties
related to such devices) doesn't let you drive it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
