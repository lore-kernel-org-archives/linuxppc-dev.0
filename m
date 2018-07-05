Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LsjQ6d0rzF1RW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 19:18:31 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id m2-v6so15508796oim.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 02:18:30 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
 <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jul 2018 11:18:28 +0200
Message-ID: <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: Pingfan Liu <kernelfans@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 5, 2018 at 4:44 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 6:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
>> > On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > >
>> > > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
>> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
>> > > > places an assumption of supplier<-consumer order on the process of probe.
>> > > > But it turns out to break down the parent <- child order in some scene.
>> > > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
>> > > > have been probed. Then comes the bridge's module, which enables extra
>> > > > feature(such as hotplug) on this bridge.
>> > >
>> > > So what *exactly* does happen in that case?
>> > >
>> > I saw the  shpc_probe() is called on the bridge, although the probing
>> > failed on that bare-metal. But if it success, then it will enable the
>> > hotplug feature on the bridge.
>>
>> I don't understand what you are saying here, sorry.
>>
> On the system, I observe the following:
> [    2.114986] devices_kset: Moving 0004:00:00.0 to end of list
> <---pcie port drive's probe, but it failed
> [    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
> [    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
> [    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
> [    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
> [    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
> [    3.181860] devices_kset: Moving 0004:03:00.0 to end of list
> <---the ata disk controller which sits behind the bridge
> [   10.267081] devices_kset: Moving 0004:00:00.0 to end of list
>  <---shpc_probe() on this bridge, failed too.
>
> As you can the the parent device "0004:00:00.0" is moved twice, and
> finally, it is after the "0004:03:00.0", this will break the
> "parent<-child" order in devices_kset. This is caused by the code
> really_probe()->devices_kset_move_last(). Apparently, it makes
> assumption that child device's probing comes after its parent's. But
> it does not stand up in the case.
>
>> device_reorder_to_tail() walks the entire device hierarchy below the target
>> and moves all of the children in there *after* their parents.
>>
> As described, the bug is not related with device_reorder_to_tail(), it
> is related with really_probe()->devices_kset_move_last().

OK, so calling devices_kset_move_last() from really_probe() clearly is
a mistake.

I'm not really sure what the intention of it was as the changelog of
commit 52cdbdd49853d doesn't really explain that (why would it be
insufficient without that change?) and I'm quite sure that in the
majority of cases it is unnecessary.

I *think* that it attempted to cover a use case similar to the device
links one, but it should have moved children along with the parent
every time like device_link_add() does.

> So [2/4] uses different method to achieve the "parent<-child" and
> "supplier<-consumer" order. The [3/4] clean up some code in
> device_reorder_to_tail(), since I need to revert the commit.

OK, let me look at that one.

Thanks,
Rafael
