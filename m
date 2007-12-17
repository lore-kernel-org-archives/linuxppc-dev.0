Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 8E993DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 15:30:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so568743anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 20:30:21 -0800 (PST)
Message-ID: <fa686aa40712162030q6f0e6d87j5e6e5379cbd0d54e@mail.gmail.com>
Date: Sun, 16 Dec 2007 21:30:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	grant.likely@secretlab.ca, simekm2@fel.cvut.cz,
	jwilliams@itee.uq.edu.au, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
In-Reply-To: <20071217041455.GA3477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<20071217041455.GA3477@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/16/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, Dec 13, 2007 at 03:43:33PM -0800, Stephen Neuendorffer wrote:
> > This now better describes what the UBoot device tree generator actually does.  In particular:
> >
> > 1) Nodes have a label derived from the device name, and a node name
> > derived from the device type.
> > 2) Usage of compound nodes (representing more than one device in the same IP) which actually works.  This requires having a valid compatible node, and all the other things that a bus normally has.  I've chosen 'xlnx,compound' as the bus name to describe these compound nodes.
>
> I'm not sure I like this xlnx,compound business, although maybe it's
> the best you can do.

I'd prefer something like "xlnx,<ip-name>-group".  "xlnx,compound" is
a very bad idea because it will be reused for very different types of
devices.  What happens when a device appears that has both
per-instance properties and 'top level' registers accessed by both
devices?

>
> > 3) Uartlite requires a port-number property for the console to work.
>
> Why?  In general we try to avoid magical sequence numbers - cell-index
> should *only* be used when it's needed to index or program some shared
> register.

Aliases is probably the correct construct for this.  port-number was a
bad idea and I never should have gone that direction.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
