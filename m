Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PGBm0QVXzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 16:48:47 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id r24-v6so16092128ioh.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 23:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
 <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de>
 <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
 <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
 <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
 <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 9 Jul 2018 14:48:33 +0800
Message-ID: <CAFgQCTvYwjKtx+AQf-kQjTsJMPRz48vgJ__jqNpwZuayG21oQw@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: Rafael Wysocki <rafael@kernel.org>
Cc: lukas@wunner.de, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 8, 2018 at 4:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jul 7, 2018 at 6:24 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> > On Fri, Jul 6, 2018 at 9:55 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>
> >> On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> >
> >> > On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > > [cc += Kishon Vijay Abraham]
> >> > >
> >> > > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> >> > >> OK, so calling devices_kset_move_last() from really_probe() clearly is
> >> > >> a mistake.
> >> > >>
> >> > >> I'm not really sure what the intention of it was as the changelog of
> >> > >> commit 52cdbdd49853d doesn't really explain that (why would it be
> >> > >> insufficient without that change?)
> >> > >
> >> > > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> >> > > whose reset pin needs to be driven high on shutdown, lest the MMC
> >> > > won't be found on the next boot.
> >> > >
> >> > > The boards' devicetrees use a kludge wherein the reset pin is modelled
> >> > > as a regulator.  The regulator is enabled when the MMC probes and
> >> > > disabled on driver unbind and shutdown.  As a result, the pin is driven
> >> > > low on shutdown and the MMC is not found on the next boot.
> >> > >
> >> > > To fix this, another kludge was invented wherein the GPIO expander
> >> > > driving the reset pin unconditionally drives all its pins high on
> >> > > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> >> > > (commit adc284755055, "gpio: pcf857x: restore the initial line state
> >> > > of all pcf lines").
> >> > >
> >> > > For this kludge to work, the GPIO expander's ->shutdown hook needs to
> >> > > be executed after the MMC expander's ->shutdown hook.
> >> > >
> >> > > Commit 52cdbdd49853d achieved that by reordering devices_kset according
> >> > > to the probe order.  Apparently the MMC probes after the GPIO expander,
> >> > > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> >> > > available yet, see mmc_regulator_get_supply().
> >> > >
> >> > > Note, I'm just piecing the information together from git history,
> >> > > I'm not responsible for these kludges.  (I'm innocent!)
> >> >
> >> > Sure enough. :-)
> >> >
> >> > In any case, calling devices_kset_move_last() in really_probe() is
> >> > plain broken and if its only purpose was to address a single, arguably
> >> > kludgy, use case, let's just get rid of it in the first place IMO.
> >> >
> >> Yes, if it is only used for a single use case.
> >>
> > Think it again, I saw other potential issue with the current code.
> > device_link_add->device_reorder_to_tail() can break the
> > "supplier<-consumer" order. During moving children after parent's
> > supplier, it ignores the order of child's consumer.
>
> What do you mean?
>
The drivers use device_link_add() to build "supplier<-consumer" order
without knowing each other. Hence there is the following potential
odds: (consumerX, child_a, ...) (consumer_a,..) (supplierX), where
consumer_a consumes child_a. When
device_link_add()->device_reorder_to_tail() moves all descendant of
consumerX to the tail, it breaks the "supplier<-consumer" order by
"consumer_a <- child_a". And we need recrusion to resolve the item in
(consumer_a,..), each time when moving a consumer behind its supplier,
we may break "parent<-child".

> > Beside this, essentially both devices_kset_move_after/_before() and
> > device_pm_move_after/_before() expose  the shutdown order to the
> > indirect caller,  and we can not expect that the caller can not handle
> > it correctly. It should be a job of drivers core.
>
> Arguably so, but that's how those functions were designed and the
> callers should be aware of the limitation.
>
> If they aren't, there is a bug in the caller.
>
If we consider device_move()-> device_pm_move_after/_before() more
carefully like the above description, then we can hide the detail from
caller. And keep the info of the pm order inside the core.

> > It is hard to extract high dimension info and pack them into one dimension
> > linked-list.
>
> Well, yes and no.
>
For "hard", I means that we need two interleaved recursion to make the
order correct. Otherwise, I think it is a bug or limitation.

> We know it for a fact that there is a linear ordering that will work.
> It is inefficient to figure it out every time during system suspend
> and resume, for one and that's why we have dpm_list.
>
Yeah, I agree that iterating over device tree may hurt performance. I
guess the iterating will not cost the majority of the suspend time,
comparing to the device_suspend(), which causes hardware's sync. But
data is more persuasive. Besides the performance, do you have other
concern till now?

> Now, if we have it for suspend and resume, it can also be used for shutdown.
>
Yes, I do think so.

Thanks and regards,
Pingfan
