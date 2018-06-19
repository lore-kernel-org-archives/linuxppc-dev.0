Return-Path: <guilherme@gpiccoli.net>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419CzN5rZ0zF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:27:12 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id g7-v6so748258ioh.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:27:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com>
 <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
From: "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Date: Tue, 19 Jun 2018 13:26:29 -0300
Message-ID: <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To: Daniel Walker <danielwa@cisco.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Cc: Andrew Morton <akpm@linux-foundation.org>, xe-kernel@external.cisco.com,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> [...]
> What your doing is changing the phb_id to some transformation of "reg" for
> all platforms except which have "ibm,opal-phbid". This is what we observe.
> This is a radical altering of the prior phb_id selection before your patch.
>
> The question is, was that your intent ? We are expecting these numbers
> aren't getting altered in this way, this is why we have the patch. Your
> patch description appears to suggest you want this type of selection for
> "... pSeries and PowerNV cases)." , so I am assuming you did this by
> mistake. Also I don't see a reason to make this change for all platforms.

It was the intent - whenever we have device-tree information, the idea is to
use it to have more consistent numbering across reboots and PCI hotplugs.
The reason to change that originally is hotplugging a PCI device added
the device with a different PHB/Domain value, and network predictable naming
messed-up interfaces' names, leading to a machine without networking.


> [...]
>
> We have already done this, that is how we determined your patch was changing
> the domain values. There isn't much to tell w.r.t this issue on our side, we
> are expecting the domain numbers are set a specific way and they aren't
> getting set that way. The drivers which are looking for PCI devices are not
> in kernel space, and the PCI domain values are getting taken from userspace.
>

Oh okay, I imagined it was some crazy userspace-based PCI domain scheme
that led you to report the issue - confirmed heheh
So, you expect the old behavior right? Incremental PHB numbering.
I think we could have a kernel config option to allow that, this way
you could rebuild your kernel with that option and keep the old behavior.

This idea needs to be validated by the maintainers, or perhaps they could
propose another way to keep the old behavior to interested parties.

[Looping linux-pci too - original thread at:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/174760.html]
