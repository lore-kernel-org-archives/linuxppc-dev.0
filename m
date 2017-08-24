Return-Path: <airlied@gmail.com>
Received: from mail-ua0-x233.google.com (mail-ua0-x233.google.com
 [IPv6:2607:f8b0:400c:c08::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xd5Vf0ZvtzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 10:57:30 +1000 (AEST)
Received: by mail-ua0-x233.google.com with SMTP id w17so6113071uaw.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 17:57:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823135734.GB8498@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170821105300.GB23287@e107981-lin.cambridge.arm.com>
 <20170822221928.GL6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu-FCkV9Dv=yn_CNC9orj8Roiabb75jX34w3mMziWVZaeA@mail.gmail.com>
 <20170823135734.GB8498@bhelgaas-glaptop.roam.corp.google.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Aug 2017 10:57:26 +1000
Message-ID: <CAPM=9tzhzGEY_-FhGNECQ8QkxPtXxhojwPeVQT43Rcgf6X0Lww@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>,
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

> Yeah, maybe it's time to disconnect the "default display device" idea
> from the VGA arbiter.  I have no idea what (if any) dependencies X has
> on the legacy VGA resources.  I assume X works fine on power, where it
> sounds like those resources are rarely or never available.

The question on non-x86 archs, is what is the correct device to default to.

On x86 we use the legacy VGA resources as a pointer, as this is the device
the BIOS appeared on at boot so hopefully should be one you can see stuff on.

On non-x86 I've no idea how to decide if there are multiple devices, maybe the
firmware needs to tag something for the kernel if there are. Otherwise
you'd just
be picking something in probe order.

I think the idea of these patches is to separate default display
device from the arbiter.

X uses the arbiter on x86 if required (it's horrible, and it's rare we
have to nowadays),
but for finding the default device it justs uses the sysfs boot_vga flag.

Dave.
