Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id D0D55B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 06:37:29 +1100 (EST)
Received: by gxk21 with SMTP id 21so5812291gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 11:37:27 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 30 Dec 2010 12:37:23 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Lan Chunhe <b25806@freescale.com>
Subject: Re: [PATCH 3/3 v2] of/device: Register children with a compatible
	value in of_platform_bus_probe()
Message-ID: <20101230193723.GE2713@angua.secretlab.ca>
References: <1291978340-15933-1-git-send-email-b25806@freescale.com>
	<20101230065045.GB843@angua.secretlab.ca>
	<op.voimsxy9z91x4h@localhost.localdomain>
	<20101230073157.GC843@angua.secretlab.ca>
	<op.voioo8pqz91x4h@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.voioo8pqz91x4h@localhost.localdomain>
Cc: akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 30, 2010 at 04:04:10PM +0800, Lan Chunhe wrote:
> On Thu, 30 Dec 2010 15:31:57 +0800, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> 
> >On Thu, Dec 30, 2010 at 03:23:11PM +0800, Lan Chunhe wrote:
> >>On Thu, 30 Dec 2010 14:50:45 +0800, Grant Likely
> >><grant.likely@secretlab.ca> wrote:
> >>
> >>>On Fri, Dec 10, 2010 at 06:52:20PM +0800, Lan Chunhe wrote:
> >>>>Currently, of_platform_bus_probe() completely skips nodes which do not
> >>>>explicitly match the 'matches' table passed in.  Or, if the root node
> >>>>matches, then it registers all the children unconditionally.  However,
> >>>>there are situations, such as registering devices from the root node,
> >>>>when it is desirable to register child nodes, but only if they
> >>actually
> >>>>represent devices.  For example, the root node may contain
> >>both a local
> >>>>bus and a PCI device, but it also contains the chosen, aliases
> >>and cpus
> >>>>nodes which don't represent real devices.
> >>>>
> >>>>This patch changes of_platform_bus_probe() to register all
> >>nodes at the
> >>>>top level if they either match the matches table (the current
> >>>>behaviour),
> >>>>or if they have a 'compatible' value (indicating it represents a
> >>>>device).
> >>>>
> >>>>Signed-off-by: Lan Chunhe <b25806@freescale.com>
> >>>
> >>>I believe this is my patch I wrote and pushed out to my tree back in
> >>>October.  Was this cherry-picked out of the test-devicetree branch?
> >>
> >>   Yes, I will add the signed off with you.
> >>
> >>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >>>>Signed-off-by: Lan Chunhe <b25806@freescale.com>
> >>
> >>   At present I think that it is cherry-picked, and I have
> >>tested it which
> >>   is OK.
> >>   Do you have better method?
> >
> >You need to be very careful about stuff like this.  Posting a patch
> >without attribution of the original author and has the original
> >signed-off-by lines stripped off is an absolute no-no.  In literary
> >circles this would be called plagiarism.
> >
> >I don't think you did it intentionally, but proper attribution is a
> >must, particularly because there are copyright issues involved.
> 
>    Sorry, thank you that you remind me.
> 
> >As for this particular patch, I'm not particularly happy with it and I
> >was planning to rewrite it.  It is an inelegant solution and I think
> >the registration of devices from the device tree can be made simpler
> >instead of more complex like in this patch.
> 
>    Now this patch registers devices from the device tree.
>    Then which function of which file do you will modify?

I'm thinking about deprecating the whole recursive device registration
entirely and instead making child device registration always the
responsibility of a device driver.  That would mean each bus node
would bind to a simple device driver that registers the child platform
devices in the .probe() hook.

g.
