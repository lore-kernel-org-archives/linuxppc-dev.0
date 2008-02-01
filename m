Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id 531FEDE348
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 03:33:49 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so1269073hsb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 08:33:47 -0800 (PST)
Message-ID: <fa686aa40802010823n1b837ffk7110a72e2bd44bf6@mail.gmail.com>
Date: Fri, 1 Feb 2008 09:23:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
In-Reply-To: <72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080201150126.GB26545@localhost.localdomain>
	<72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
Cc: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/1/08, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened-
> > device-tree model.
> >       ucc@2000 {
> >               device_type = "network";
> >               compatible = "ucc_geth";
> > -             model = "UCC";
> >               device-id = <1>;
>
> can we change device-id to cell-index?

<aside>
Here's a thought; do we really need a cell-index at all?  (and I'm
talking in general; not just this specific case).  I'm starting to
think we should migrate away from using it.

cell-index has been useful for things like clock controllers to know
what offset into a shared clock control register or something like
that and a driver would pass the cell-index value to the shared reg
driver when requesting service.  However, I think the information
encoded in cell-index is already encoded in the device tree in a
different manor.

Typically, shared registers and the like are all chip specific and the
behaviour of the shared register drivers usually needs to be tweaked
for different SoCs.  Each ip core on an SoC is already uniquely
indexed via the reg property.  True, 'reg' is sparse (0x2000, 0x2200,
0x2300, ...) whereas cell-index is tight (0,1,2,3,...), but I don't
think that introduces any additional difficulty.

So, instead of a driver passing it's cell-index value to the shared
reg driver, it would pass it's reg base instead.  The shared register
driver could then choose an internal representation that makes sense
for it instead of whatever layout was chosen by the device tree.

Dropping cell-index would mean one less property to keep in sync when
tailoring device trees. (== less complexity for board porters).
Besides, the purpose of cell-index is often misunderstood already by
people trying to use it to describe port numbers (ttyS0, ttyS1, etc).

Thoughts?
</aside>

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
