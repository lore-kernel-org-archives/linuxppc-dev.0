Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LHBc3ff2zF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 20:23:19 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
Date: Wed, 04 Jul 2018 12:21:52 +0200
Message-ID: <6281446.GoJLz6Hq6C@aspire.rjw.lan>
In-Reply-To: <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
> On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > places an assumption of supplier<-consumer order on the process of probe.
> > > But it turns out to break down the parent <- child order in some scene.
> > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > have been probed. Then comes the bridge's module, which enables extra
> > > feature(such as hotplug) on this bridge.
> >
> > So what *exactly* does happen in that case?
> >
> I saw the  shpc_probe() is called on the bridge, although the probing
> failed on that bare-metal. But if it success, then it will enable the
> hotplug feature on the bridge.

I don't understand what you are saying here, sorry.

device_reorder_to_tail() walks the entire device hierarchy below the target
and moves all of the children in there *after* their parents.

How can it break "the parent <- child order" then?

Thanks,
Rafael
