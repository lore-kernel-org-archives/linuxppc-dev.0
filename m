Return-Path: <daniel.vetter@ffwll.ch>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1T6k0fWkzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 14:50:51 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id d16so3958832ioj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:50:51 -0700 (PDT)
MIME-Version: 1.0
Sender: daniel.vetter@ffwll.ch
In-Reply-To: <87d16oeeti.fsf@linkitivity.dja.id.au>
References: <20170901072744.2409-1-dja@axtens.net>
 <87d16oeeti.fsf@linkitivity.dja.id.au>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 26 Sep 2017 06:50:47 +0200
Message-ID: <CAKMK7uFq=WEYoeBBvBgSeFq9PCsqzbGiq6KiC10b1KabcayDQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
To: Daniel Axtens <dja@axtens.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, ard.biesheuvel@linaro.org,
 Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Rongrong Zou <zourongrong@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 7:49 AM, Daniel Axtens <dja@axtens.net> wrote:
> Hi all,
>
> The merge window is well over by now - is there anything else I can do
> to get this series to a mergeable state? I'm not particularly across the
> rules for drm-misc, so please let me know if there are things I need to
> be doing.

drm-misc is always open for feature merging, but the patch series
lacks full r-b by someone with clue on this stuff (i.e. probably not
me). Pls find someone who can do the in-depth review. Just an Ack
feels a bit thin.
-Daniel

>
> Regards,
> Daniel
>
> Daniel Axtens <dja@axtens.net> writes:
>
>> This patch set:
>>
>>  - splits the default display handling out from VGA arbiter, into its
>>    own file and behind its own Kconfig option (and gives the functions
>>    better names).
>>
>>  - adds extra detection of default devices. To be nominated, the vga
>>    arbiter and platform hooks must not have nominated a default. A
>>    card will then only be nominated if it has a driver attached and
>>    has IO or memory decoding enabled.
>>
>>  - adds relevant documentation.
>>
>> The practical impact of this is improved X autoconfiguration on some
>> arm64 systems.
>>
>> Changes in v3:
>>
>>  - Add documentation - thanks Daniel Vetter for pointing it out.
>>
>>  - Clarify explanations. Thanks to everyone for continuing to bear
>>    with my incomplete understanding of PCI and provide some clarity.
>>
>>  - Split refactoring and adding functionality.
>>
>> Changes in v2: https://www.spinics.net/lists/linux-pci/msg64007.html
>>
>> Drop all the powerpc patches. [explanation snipped]
>>
>> v1: https://www.spinics.net/lists/linux-pci/msg63581.html
>>
>> Regards,
>> Daniel
>>
>> Daniel Axtens (3):
>>   drm: split default display handler out of VGA arbiter
>>   drm: add fallback default device detection
>>   drm: documentation for default display device
>>
>>  Documentation/gpu/default_display.rst |  93 +++++++++++++++++++
>>  Documentation/gpu/index.rst           |   1 +
>>  arch/ia64/pci/fixup.c                 |   6 +-
>>  arch/powerpc/kernel/pci-common.c      |   6 +-
>>  arch/x86/pci/fixup.c                  |   6 +-
>>  arch/x86/video/fbdev.c                |   4 +-
>>  drivers/gpu/vga/Kconfig               |  12 +++
>>  drivers/gpu/vga/Makefile              |   1 +
>>  drivers/gpu/vga/default_display.c     | 163 ++++++++++++++++++++++++++++++++++
>>  drivers/gpu/vga/vga_switcheroo.c      |   8 +-
>>  drivers/gpu/vga/vgaarb.c              |  61 +++----------
>>  drivers/pci/pci-sysfs.c               |   4 +-
>>  include/linux/default_display.h       |  44 +++++++++
>>  include/linux/vgaarb.h                |  15 ----
>>  14 files changed, 344 insertions(+), 80 deletions(-)
>>  create mode 100644 Documentation/gpu/default_display.rst
>>  create mode 100644 drivers/gpu/vga/default_display.c
>>  create mode 100644 include/linux/default_display.h
>>
>> --
>> 2.11.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
