Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id A163E2C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 15:24:28 +1000 (EST)
Date: Wed, 5 Jun 2013 22:25:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
Message-ID: <20130606052508.GA1901@roeck-us.net>
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
 <51A5CAC1.6030800@freescale.com>
 <20130531051423.GA15505@roeck-us.net>
 <1369979047.3928.112.camel@pasglop>
 <20130601135809.GA6395@roeck-us.net>
 <1370480404.3766.260.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370480404.3766.260.camel@pasglop>
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Chen Yuanquan-B41889 <B41889@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 06, 2013 at 11:00:04AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2013-06-01 at 06:58 -0700, Guenter Roeck wrote:
> > the comment was actuially directed towards Yuanquan.
> > 
> > No problem, take your time. I did my best to test it, but I agree that this is a
> > critical area of the code, and it would be desirable to get additional scrutiny
> > and test feedback.
> > 
> > The code has been running in our system (P2020 and P5040) for several months.
> > I was preparing a patch for upstream submission when I noticed commit 37f02195b.
> > After testing ithis commit, I noticed the problems with it and wrote this patch,
> > which aligns the code with our initial patch. I tested it as good as I could on
> > our systems as well as with a P5040 evaluation board and an Intel GE PCIe
> > card.
> 
> Ok, so I like this very much. So much that I was considering still sneaking it
> into 3.10, until I hit a snag...
> 
> [ Basically, the previous patch that moved the setup to pcibios_enable_device()
> always made me nervous. It did regress at least one platform (mac stuff) due
> to missed IRQ fixup, which I worked around later on, and I'm still not terribly
> happy about it. Your approach is much cleaner. ]
> 
> I suppose that when I wrote the original setup stuff there wasn't an add
> hook or I didn't see it...
> 
> In fact I would go further and completely remove pcibios_setup_bus_devices()
> which is now empty since it's only called by the powerpc code, it's not
> a generic hook.
> 
> However, here's the snag. Unless I missed something, we now setup the devices
> DMA before we call pcibios_fixup_bus(). And *that* is going to break some
> pseries.
> 
> We have an assumption in there that the bus fixup is done first, because in
> some cases, the DMA windows are established at the bus level, and the "dev"
> setup just picks up the bits.
> 
> Now looking at that code, it's not unfixable but it won't make 3.10. Maybe
> we need a new pre-scan hook for busses... we can use the pcibios_add_device()
> hook of the bridge itself for P2P but that won't do for the root bus and I
> don't like having two different path here...
> 
Hi Ben,

you are right, pcibios_fixup_bus() is called after pcibios_add_device(),
at least in the initial scan.

Can you point me to some of the breaking code ? I guess it must be in some of
the pci_dma_dev_setup callbacks, but those I looked at only check devicetree
data or simply set function pointers, both of which should not be affected by
the call order.

How about pcibios_fixup_device, to be called after pcibios_fixup_bus ?

Thanks,
Guenter
