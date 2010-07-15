Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 1E091B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 01:19:56 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via  proc
From: Matthew McClintock <msm@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Jul 2010 10:19:19 -0500
Message-ID: <1279207159.30737.11.camel@localhost>
MIME-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 00:21 -0600, Grant Likely wrote:
> On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock
> <msm@freescale.com> wrote:
> > To build a proper flat device tree for kexec we need to know which
> > memreserve region was used for the device tree for the currently
> > running kernel, so we can remove it and replace it with the new
> > memreserve for the kexec'ed kernel
> >
> > Signed-off-by: Matthew McClintock <msm@freescale.com>
> 
> Hi Matthew.
> 
> I don't understand.  Why does userspace need to know about the old
> memreserve sections?  Doesn't kexec tear down all of the old
> allocations anyway?  How are they relevant for constructing the dtb
> for the kexec kernel?  I'll need a lot more details before I consider
> merging this.
> 
> Also, please cc: me and Ben Herrenschmidt on powerpc related device
> tree changes.
> 
> Cheers,
> g. 

Grant,

Thanks for taking a look. My first thought was to just blow away all the
memreserve regions and start over. But, there are reserve regions for
other things that I might not want to blow away. For example, on mpc85xx
SMP systems we have an additional reserve region for our boot page. 

There is already precedence for exporting the initrd physical addresses
in the same fashion, which is mostly why I took this route. So instead I
just choose to find and replace the device tree and initrd reserve
regions.

I'm open to other ideas, just let me know. 

Regards,
Matthew
