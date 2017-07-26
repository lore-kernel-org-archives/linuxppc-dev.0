Return-Path: <lersek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHWx76sHczDqpV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:46:03 +1000 (AEST)
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Daniel Axtens <dja@axtens.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>,
 "daniel.vetter@intel.com" <daniel.vetter@intel.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
 <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c2d6889e-c8fd-012d-a24b-a72c26850fde@redhat.com>
Date: Wed, 26 Jul 2017 12:45:53 +0200
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/17 17:56, Gabriele Paoloni wrote:
> Hi Laszlo
> 
> [...]
> 
>>
>> Having practically zero background in gfx development (either kernel or
>> Xorg), I think the problem is that vga_default_device() /
>> vga_set_default_device(), which -- apparently -- "boot_vga" is based
>> upon, come from "drivers/gpu/vga/vgaarb.c". Namely, the concept of
>> "primary / boot display device" is tied to the VGA arbiter, plus only a
>> PCI device can currently be marked as primary/boot display device.
>>
>> Can these concepts be split from each other? (I can fully imagine that
>> this would result in a userspace visible interface change (or
>> addition),
>> so that e.g. "/sys/devices/**/boot_gpu" would have to be consulted by
>> display servers.)
>>
>> (Sorry if I'm totally wrong.)
>>
>> ... Hm, reading the thread starter at
>> <https://www.mail-archive.com/linuxppc-
>> dev@lists.ozlabs.org/msg120851.html>,
>> and the references within... It looks like this work is motivated by
>> hardware that is supposed to be PCI, but actually breaks the specs. Is
>> that correct? If so, then I don't think I can suggest anything useful.
> 
> My understanding is that the current PCIe HW is specs compliant but the
> vgaarb, in order to make a VGA device the default one, requires all the
> bridges on top of such device to have the "VGA Enable" bit set (optional
> bit in the PCI Express™ to PCI/PCI-X Bridge Spec). I.e. all the bridges
> on top have to support legacy VGA devices; and this is not mandatory
> from the specs...right?

Sounds very plausible to me. And, I guess if the "boot GPU" concept were
split from the VGA arbiter, then the VGA arbiter's above requirement
(a) would not have to be disturbed, and
(b) would no longer interfere with the kind of hardware that's being
    discussed.

Thanks
Laszlo

> BTW my VGA experience is limited too...this is just my understanding...
> 
> Gab
> 
>> Specs exist so that hardware vendors and software authors follow them.
>> If hardware does not conform, then software should either refuse to
>> work
>> with it, or handle it with quirks, on a case-by-case basis. I guess
>> this
>> means that I don't agree with the
>>
>>   broad[] suggest[ion] that a more generic solution would be better
>>
>> which seems to disqualify me from the discussion, as it must have been
>> suggested by people with incomparably more experience than what I have
>> :)
>>
>> Thanks
>> Laszlo
