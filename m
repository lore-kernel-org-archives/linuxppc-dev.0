Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L54V0tm2zF1R4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 12:47:20 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id d191-v6so6686252ite.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 19:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
In-Reply-To: <4685360.VNmeYLh0dQ@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 4 Jul 2018 10:47:07 +0800
Message-ID: <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge.
>
> So what *exactly* does happen in that case?
>
I saw the  shpc_probe() is called on the bridge, although the probing
failed on that bare-metal. But if it success, then it will enable the
hotplug feature on the bridge.

Thanks,
Pingfan
