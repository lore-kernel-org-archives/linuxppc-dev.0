Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93C991A028D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 08:25:40 +1100 (AEDT)
Message-ID: <1452720339.8203.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org,  Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Jan 2016 08:25:39 +1100
In-Reply-To: <56963E40.8070702@linux.vnet.ibm.com>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452681487.7404.6.camel@ellerman.id.au>
 <56963E40.8070702@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-13 at 10:08 -0200, Guilherme G. Piccoli wrote:
> On 01/13/2016 08:38 AM, Michael Ellerman wrote:
> > But eeh_enabled() is still false? That seems like it's liable to cause breakage
> > elsewhere.
>
> Yes, eeh_enabled() is false as expected. Notice that eeh_enabled() is
> telling if EEH is enabled or not, and since it's not (because there's no
> PCI adapters on machine yet!), makes sense it returns false.
>
> At the end of runs of eeh_add_device_early(), the devices are probed and
> EEH is enabled, so the function will reflect this. Notice that the
> problem addressed by this patch is the use of eeh_enabled() in hotplug
> operations only, which in my opinion is not correct. I checked every
> other use of eeh_enable() in the code, and they all seems appropriate,
> so I expect no errors at all.

OK.

> > Shouldn't the PCI hotplug code instead be taught to initialise EEH correctly
> > when the first device is added?
>
> Well, for sure there are other ways to achieve this patch's goal, like
> refactor PCI hotplug code in lots of places. But notice although the
> proposed solution is simple, it solves the issue because
> eeh_add_device_early() is ultimately the function used by PCI hotplug
> mechanism (no matter if pseries/cell/etc or the type of hotplug) to
> initialize EEH by probing the devices at the moment they are added to
> the system. In my opinion, this is exactly the location we want to
> change code to address this issue.
>
> What do you think? Thanks very much for the review.

I'm still not sure. I'm certainly happy for the fix to be simple, it will need
to be backported after all.

But for example what happens if the user boots with eeh=off on the command
line, and then hotplugs a device. It looks like because you're not using
eeh_enabled() you will incorrectly initialise EEH anyway?

cheers
