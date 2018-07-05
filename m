Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LhzV3lzTzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 12:45:10 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id s7-v6so9928057itb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 19:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
In-Reply-To: <6281446.GoJLz6Hq6C@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 5 Jul 2018 10:44:57 +0800
Message-ID: <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 4, 2018 at 6:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
> > On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > > places an assumption of supplier<-consumer order on the process of probe.
> > > > But it turns out to break down the parent <- child order in some scene.
> > > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > > have been probed. Then comes the bridge's module, which enables extra
> > > > feature(such as hotplug) on this bridge.
> > >
> > > So what *exactly* does happen in that case?
> > >
> > I saw the  shpc_probe() is called on the bridge, although the probing
> > failed on that bare-metal. But if it success, then it will enable the
> > hotplug feature on the bridge.
>
> I don't understand what you are saying here, sorry.
>
On the system, I observe the following:
[    2.114986] devices_kset: Moving 0004:00:00.0 to end of list
<---pcie port drive's probe, but it failed
[    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
[    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
[    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
[    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
[    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
[    3.181860] devices_kset: Moving 0004:03:00.0 to end of list
<---the ata disk controller which sits behind the bridge
[   10.267081] devices_kset: Moving 0004:00:00.0 to end of list
 <---shpc_probe() on this bridge, failed too.

As you can the the parent device "0004:00:00.0" is moved twice, and
finally, it is after the "0004:03:00.0", this will break the
"parent<-child" order in devices_kset. This is caused by the code
really_probe()->devices_kset_move_last(). Apparently, it makes
assumption that child device's probing comes after its parent's. But
it does not stand up in the case.

> device_reorder_to_tail() walks the entire device hierarchy below the target
> and moves all of the children in there *after* their parents.
>
As described, the bug is not related with device_reorder_to_tail(), it
is related with really_probe()->devices_kset_move_last(). So [2/4]
uses different method to achieve the "parent<-child" and
"supplier<-consumer" order. The [3/4] clean up some code in
device_reorder_to_tail(), since I need to revert the commit.

> How can it break "the parent <- child order" then?
>
As described, it does not, just not be in use any longer.

Thanks and regards,
Pingfan
