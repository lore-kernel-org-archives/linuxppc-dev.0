Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Lhj2139nzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 12:32:37 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id q9-v6so6313030ioj.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 19:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <3375966.ydPZj5TMVj@aspire.rjw.lan>
 <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
 <2842715.a5PfnD4e6X@aspire.rjw.lan>
In-Reply-To: <2842715.a5PfnD4e6X@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 5 Jul 2018 10:32:23 +0800
Message-ID: <CAFgQCTvZ8yGjrbxhYB4=Nxx+-JZC6BAUXCZ-DFz4wAh-Q8UjLw@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of
 devices_kset_move_last()
To: rjw@rjwysocki.net
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 4, 2018 at 6:18 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 4, 2018 6:40:09 AM CEST Pingfan Liu wrote:
> > On Tue, Jul 3, 2018 at 10:28 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> > > > Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> > > > correct device's shutdown order"). So later we can revert it safely.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > ---
> > > >  drivers/base/core.c | 7 -------
> > > >  1 file changed, 7 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 684b994..db3deb8 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> > > >  {
> > > >       struct device_link *link;
> > > >
> > > > -     /*
> > > > -      * Devices that have not been registered yet will be put to the ends
> > > > -      * of the lists during the registration, so skip them here.
> > > > -      */
> > > > -     if (device_is_registered(dev))
> > > > -             devices_kset_move_last(dev);
> > > > -
> > > >       if (device_pm_initialized(dev))
> > > >               device_pm_move_last(dev);
> > >
> > > You can't do this.
> > >
> > > If you do it, that will break power management in some situations.
> > >
> > Could you shed light on it? I had a quick browsing of pm code, but it
> > is a big function, and I got lost in it.
> > If the above code causes failure, then does it imply that the seq in
> > devices_kset should be the same as dpm_list?
>
> Generally, yes it should.
>
> > But in device_shutdown(), it only intersect with pm by
> > pm_runtime_get_noresume(dev) and pm_runtime_barrier(dev). How do these
> > function affect the seq in dpm_list?
>
> They are not related to dpm_list directly.
>
> However, if you shut down a supplier device before its consumer and that
> involves power management, then the consumer shutdown may fail and lock up
> the system
>
Ah, get your point. The patch in this series "[PATCHv3 2/4]
drivers/base: utilize device tree info to shutdown devices" still obey
the shutdown order "parent<-child" and "supplier<-consumer". It just
utilizes device-tree info to achieve this, since it turns out not easy
to maintain such order in devices_kset. As I described in the commit
log of [2/4], it needs two nested recursion, and should consider the
breakage of devices_kset's spinlock.

> I asked you elsewhere to clearly describe the problem you are trying to
> address.  Please do that in the first place.
>
OK, I will reply your question in [0/4]

Thanks,
Pingfan
