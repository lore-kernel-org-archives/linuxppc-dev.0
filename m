Return-Path: <dja@axtens.net>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQcp418WrzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 09:49:30 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id t86so7412238pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Aug 2017 16:49:30 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com, catalin.marinas@arm.com,
 will.deacon@arm.com, gabriele.paoloni@huawei.com, bhelgaas@google.com,
 airlied@linux.ie, daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
In-Reply-To: <20170805065754.GA8509@wunner.de>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-3-dja@axtens.net> <20170805065754.GA8509@wunner.de>
Date: Mon, 07 Aug 2017 09:49:24 +1000
Message-ID: <87zibcqmt7.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lukas,

Let me reply "back-to-front":

> Please cc dri-devel when proposing changes to vgaarb.c (see
> MAINTAINERS).

Sorry, will do in future.

> I'm missing some context as to the negative consequences you're
> experiencing on other arches (the cover letter merely refers to
> "quirks in ppc and concerns in arm land" and is missing links to
> archived versions of v1 and v2), but clearly legacy resources are
> x86-specific so any code dealing with them seems superfluous on
> other arches and should be marked as such.

Quirk/v1: https://www.spinics.net/lists/linux-pci/msg62865.html
Approach 2: https://www.spinics.net/lists/linux-pci/msg63092.html
            https://www.spinics.net/lists/linux-pci/msg63083.html

The quirk in powerpc land that I'm referring to is
arch/powerpc/kernel/pci-common.c::fixup_vga() which is a class enable
hook that marks the first VGA device it comes across as default if the
arbiter has not marked one.

The arm concerns are ventaliated in the threads I linked - they boil
down to "why do we need the arbiter at all on platforms without legacy
resources? Can't we do this more simply?"

> Would it be feasible to just sprinkle some "if (IS_ENABLED(CONFIG_X86))"
> over the portions of vgaarb.c that deal with legacy resources?

Yes and no. That would disable the unnecessary chunks of the VGA
arbiter, but we then still have to figure out how to mark devices as
default if not with the arbiter.

Regards,
Daniel

>
> Thanks,
>
> Lukas
