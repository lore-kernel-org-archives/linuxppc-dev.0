Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NhNY6Jc0zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jul 2018 18:25:16 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so30733220ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 01:25:16 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
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
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 8 Jul 2018 10:25:14 +0200
Message-ID: <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: Pingfan Liu <kernelfans@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux PM <linux-pm@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 7, 2018 at 6:24 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Fri, Jul 6, 2018 at 9:55 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>>
>> On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >
>> > On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > > [cc += Kishon Vijay Abraham]
>> > >
>> > > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
>> > >> OK, so calling devices_kset_move_last() from really_probe() clearly is
>> > >> a mistake.
>> > >>
>> > >> I'm not really sure what the intention of it was as the changelog of
>> > >> commit 52cdbdd49853d doesn't really explain that (why would it be
>> > >> insufficient without that change?)
>> > >
>> > > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
>> > > whose reset pin needs to be driven high on shutdown, lest the MMC
>> > > won't be found on the next boot.
>> > >
>> > > The boards' devicetrees use a kludge wherein the reset pin is modelled
>> > > as a regulator.  The regulator is enabled when the MMC probes and
>> > > disabled on driver unbind and shutdown.  As a result, the pin is driven
>> > > low on shutdown and the MMC is not found on the next boot.
>> > >
>> > > To fix this, another kludge was invented wherein the GPIO expander
>> > > driving the reset pin unconditionally drives all its pins high on
>> > > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
>> > > (commit adc284755055, "gpio: pcf857x: restore the initial line state
>> > > of all pcf lines").
>> > >
>> > > For this kludge to work, the GPIO expander's ->shutdown hook needs to
>> > > be executed after the MMC expander's ->shutdown hook.
>> > >
>> > > Commit 52cdbdd49853d achieved that by reordering devices_kset according
>> > > to the probe order.  Apparently the MMC probes after the GPIO expander,
>> > > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
>> > > available yet, see mmc_regulator_get_supply().
>> > >
>> > > Note, I'm just piecing the information together from git history,
>> > > I'm not responsible for these kludges.  (I'm innocent!)
>> >
>> > Sure enough. :-)
>> >
>> > In any case, calling devices_kset_move_last() in really_probe() is
>> > plain broken and if its only purpose was to address a single, arguably
>> > kludgy, use case, let's just get rid of it in the first place IMO.
>> >
>> Yes, if it is only used for a single use case.
>>
> Think it again, I saw other potential issue with the current code.
> device_link_add->device_reorder_to_tail() can break the
> "supplier<-consumer" order. During moving children after parent's
> supplier, it ignores the order of child's consumer.

What do you mean?

> Beside this, essentially both devices_kset_move_after/_before() and
> device_pm_move_after/_before() expose  the shutdown order to the
> indirect caller,  and we can not expect that the caller can not handle
> it correctly. It should be a job of drivers core.

Arguably so, but that's how those functions were designed and the
callers should be aware of the limitation.

If they aren't, there is a bug in the caller.

> It is hard to extract high dimension info and pack them into one dimension
> linked-list.

Well, yes and no.

We know it for a fact that there is a linear ordering that will work.
It is inefficient to figure it out every time during system suspend
and resume, for one and that's why we have dpm_list.

Now, if we have it for suspend and resume, it can also be used for shutdown.

> And in theory, it is warranted that the shutdown seq is
> correct by using device tree info. More important, it is cheap with
> the data structure in hand. So I think it is time to resolve the issue
> once for all.

Not the way you want to do that, though.

Thanks,
Rafael
