Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x236.google.com (mail-qt0-x236.google.com
 [IPv6:2607:f8b0:400d:c0d::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMXhj1xD3zDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 01:34:28 +1100 (AEDT)
Received: by mail-qt0-x236.google.com with SMTP id z19so241460qtg.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 07:34:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C65BF19B-49B3-480E-9435-17949645B992@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
 <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
 <20171023135338.58d0ab31@MiWiFi-R3-srv>
 <C65BF19B-49B3-480E-9435-17949645B992@raithlin.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 26 Oct 2017 01:34:26 +1100
Message-ID: <CAOSf1CGx2E3dOPPSrKOxHahGcu8BjRq02xeyEitPmiwoFcdo+w@mail.gmail.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
To: Stephen Bates <sbates@raithlin.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Logan Gunthorpe <logang@deltatee.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2017 at 7:17 AM, Stephen  Bates <sbates@raithlin.com> wrote=
:
>
>> [    3.537780] lpar: Attempting to resize HPT to shift 21
>> [    3.539251] Unable to resize hash page table to target order 21: -1
>> [    3.541079] Unable to create mapping for hot added memory 0xc00021000=
0000000..0xc000210004000000: -2
>
>> For #1 above please check if your qemu supports H_RESIZE_HPT_* hcalls?
>
> Balbir do you have any suggestions as to how to test for this support? No=
te I am running this on my x86_64 host so there is no virtualization hardwa=
re in my QEMU. My qemu is very recent (QEMU emulator version 2.10.50 (v2.10=
.0-1026-gd8f932c-dirty)).

Honestly I'd just ignore the resize error. The hash table stores PTE
entries so it should be sized based on the amount of memory in the
system. If it's drastically under sized there'll be a performance hit,
but  everything should still work.

>> For create mapping failures, the rc is -ENOENT. Can you help debug this =
further? We could do hcall tracing or enable debugging.
>
> Sure I can help debug. My original email also had all you needed to recre=
ate this issue so that=E2=80=99s an option too?

I'm not too sure what's happening there. My hunch is that the
hypervisor (qemu in this case) is rejecting the attempt to map the PCI
device MMIO space as cachable memory. On bare metal systems this can
result in cache paradoxes which will kill the system so the hypervisor
has an incentive to prevent that situation.

>
> Stephen
>
>
