Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdK3Z4qb9zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 19:38:17 +1000 (AEST)
Received: by mail-it0-x22b.google.com with SMTP id j62so486488ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 02:38:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPM=9tzhzGEY_-FhGNECQ8QkxPtXxhojwPeVQT43Rcgf6X0Lww@mail.gmail.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170821105300.GB23287@e107981-lin.cambridge.arm.com>
 <20170822221928.GL6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu-FCkV9Dv=yn_CNC9orj8Roiabb75jX34w3mMziWVZaeA@mail.gmail.com>
 <20170823135734.GB8498@bhelgaas-glaptop.roam.corp.google.com>
 <CAPM=9tzhzGEY_-FhGNECQ8QkxPtXxhojwPeVQT43Rcgf6X0Lww@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 10:38:14 +0100
Message-ID: <CAKv+Gu8mfPtQ+vWgzP4adtVB+DByS4snF+FQ7k-UDV+=bxHSsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
To: Dave Airlie <airlied@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Will Deacon <will.deacon@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 August 2017 at 01:57, Dave Airlie <airlied@gmail.com> wrote:
>> Yeah, maybe it's time to disconnect the "default display device" idea
>> from the VGA arbiter.  I have no idea what (if any) dependencies X has
>> on the legacy VGA resources.  I assume X works fine on power, where it
>> sounds like those resources are rarely or never available.
>
> The question on non-x86 archs, is what is the correct device to default to.
>
> On x86 we use the legacy VGA resources as a pointer, as this is the device
> the BIOS appeared on at boot so hopefully should be one you can see stuff on.
>
> On non-x86 I've no idea how to decide if there are multiple devices, maybe the
> firmware needs to tag something for the kernel if there are. Otherwise
> you'd just
> be picking something in probe order.
>
> I think the idea of these patches is to separate default display
> device from the arbiter.
>
> X uses the arbiter on x86 if required (it's horrible, and it's rare we
> have to nowadays),
> but for finding the default device it justs uses the sysfs boot_vga flag.
>

Part of the problem is that X refuses to start if there is only one
display device to begin with in case it hasn't taken ownership of the
VGA legacy resources.
