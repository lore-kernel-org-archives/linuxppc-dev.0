Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22a.google.com (mail-qk0-x22a.google.com
 [IPv6:2607:f8b0:400d:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNc0v2WjYzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 19:07:10 +1100 (AEDT)
Received: by mail-qk0-x22a.google.com with SMTP id l194so7354446qke.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 01:07:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGx2E3dOPPSrKOxHahGcu8BjRq02xeyEitPmiwoFcdo+w@mail.gmail.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
 <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
 <20171023135338.58d0ab31@MiWiFi-R3-srv>
 <C65BF19B-49B3-480E-9435-17949645B992@raithlin.com>
 <CAOSf1CGx2E3dOPPSrKOxHahGcu8BjRq02xeyEitPmiwoFcdo+w@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 27 Oct 2017 19:07:07 +1100
Message-ID: <CAOSf1CHWZfEyK-oM+4dPpamX-XbxM13mtHjKoYWGEdmQ7wCd_g@mail.gmail.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
To: Stephen Bates <sbates@raithlin.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Logan Gunthorpe <logang@deltatee.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, aik@ozlabs.ru
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2017 at 1:34 AM, Oliver <oohall@gmail.com> wrote:
> On Tue, Oct 24, 2017 at 7:17 AM, Stephen  Bates <sbates@raithlin.com> wro=
te:
>>
>>> [    3.537780] lpar: Attempting to resize HPT to shift 21
>>> [    3.539251] Unable to resize hash page table to target order 21: -1
>>> [    3.541079] Unable to create mapping for hot added memory 0xc0002100=
00000000..0xc000210004000000: -2
>>
>>> For #1 above please check if your qemu supports H_RESIZE_HPT_* hcalls?
>>
>> Balbir do you have any suggestions as to how to test for this support? N=
ote I am running this on my x86_64 host so there is no virtualization hardw=
are in my QEMU. My qemu is very recent (QEMU emulator version 2.10.50 (v2.1=
0.0-1026-gd8f932c-dirty)).
>
> Honestly I'd just ignore the resize error. The hash table stores PTE
> entries so it should be sized based on the amount of memory in the
> system. If it's drastically under sized there'll be a performance hit,
> but  everything should still work.
>
>>> For create mapping failures, the rc is -ENOENT. Can you help debug this=
 further? We could do hcall tracing or enable debugging.
>>
>> Sure I can help debug. My original email also had all you needed to recr=
eate this issue so that=E2=80=99s an option too?
>
> I'm not too sure what's happening there. My hunch is that the
> hypervisor (qemu in this case) is rejecting the attempt to map the PCI
> device MMIO space as cachable memory. On bare metal systems this can
> result in cache paradoxes which will kill the system so the hypervisor
> has an incentive to prevent that situation.

So I had a deeper look and found the hypervisor interface spec (PAPR)
says the hypervisor should reject attempts to map memory with
inappropriate attributes for the type of memory being mapped. The
pseries model in qemu interprets this by only allowing cacheable
mappings on memory ranges that it considers as RAM. While KVM will
allow any mappings provided they have the same cachable attribute as
the hypervisor's mapping. Either way trying to use
devm_memremap_pages() like this on pseries is fundementally broken.
The alternative approach you mentioned that uses ioremap() should work
fine though.

Also, Alexy (+cc) said he was interested in trying this on some real
hardware. Is there a test suite for p2pmem floating around that he can
use?

Thanks,
Oliver
