Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PK4C0nCPzDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 18:58:18 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so34494177oie.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 01:58:18 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAFgQCTvGJVBdGLz0R74jO3f1nY3aWprGoADUXzw4E6jxOxWHBg@mail.gmail.com>
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
 <CAFgQCTvYwjKtx+AQf-kQjTsJMPRz48vgJ__jqNpwZuayG21oQw@mail.gmail.com>
 <CAJZ5v0gSo-jFO0h+aLkeyGGxRL+tdsRtGi0WFhhGQbZvezJmkA@mail.gmail.com>
 <CAFgQCTvGJVBdGLz0R74jO3f1nY3aWprGoADUXzw4E6jxOxWHBg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Jul 2018 10:58:13 +0200
Message-ID: <CAJZ5v0hMjoEy6Fe1Rcc1Uq_wQnDCAYYkEv4R024h0iq5krSiMQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Rafael Wysocki <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
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

On Mon, Jul 9, 2018 at 10:40 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Mon, Jul 9, 2018 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Jul 9, 2018 at 8:48 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
>> > On Sun, Jul 8, 2018 at 4:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

>>
>> I simply think that there should be one way to iterate over devices
>> for both system-wide PM and shutdown.
>>
>> The reason why it is not like that today is because of the development
>> history, but if it doesn't work and we want to fix it, let's just
>> consolidate all of that.
>>
>> Now, system-wide suspend resume sometimes iterates the list in the
>> reverse order which would be hard without having a list, wouldn't it?
>>
> Yes, it would be hard without having a list. I just thought to use
> device tree info to build up a shadowed list, and rebuild the list
> until there is new device_link_add() operation. For
> device_add/_remove(), it can modify the shadowed list directly.

Right, and that's the idea of dpm_list, generally speaking: It
represents one of the (possibly many) orders in which devices can be
suspended (or shut down) based on the information coming from the
device hierarchy and device links.

So it appears straightforward (even though it may be complicated
because of the build-time dependencies) to start using dpm_list for
shutdown too - and to ensure that it is properly maintained
everywhere.

Thanks,
Rafael
