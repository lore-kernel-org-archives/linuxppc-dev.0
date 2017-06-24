Return-Path: <palmer@dabbelt.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvc6v2KcpzDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 10:45:26 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so9550036pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 17:45:26 -0700 (PDT)
Date: Fri, 23 Jun 2017 17:45:23 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: geert@linux-m68k.org
CC: linux-arch@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Olof Johansson <olof@lixom.net>
CC: albert@sifive.com
CC: patches@groups.riscv.org
CC: gregkh@linuxfoundation.org
CC: jslaby@suse.com
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/17] tty: New RISC-V SBI Console Driver
In-Reply-To: <CAK8P3a35SEeOaVXBNCzUiwQTXys4MZN28d4yVRqNQ=Jz=Z-EWw@mail.gmail.com>
Message-ID: <mhng-ff4db4ff-d1b4-4f40-8488-7c5b0bf52b67@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 07 Jun 2017 00:58:04 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 9:15 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> CC (hypervisor) console folks
>>
>> On Wed, Jun 7, 2017 at 1:00 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>> This patch adds a new driver for the console availiable via the RISC-V
>>> SBI.  This console is specified to be used for early boot messages, and
>>> is designed to be a very simple (albiet somewhat slow) console that is
>>> always availiable.  All RISC-V systems have an SBI console.
>>>
>>> The SBI console is made availiable for early printk messages and is also
>>> availiable as a regular console.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>>> ---
>>>  drivers/tty/hvc/Kconfig   |  11 +++++
>>>  drivers/tty/hvc/Makefile  |   1 +
>>>  drivers/tty/hvc/hvc_sbi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 114 insertions(+)
>>>  create mode 100644 drivers/tty/hvc/hvc_sbi.c
>>>
>>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>>> index 574da15fe618..f3774adab240 100644
>>> --- a/drivers/tty/hvc/Kconfig
>>> +++ b/drivers/tty/hvc/Kconfig
>>> @@ -114,4 +114,15 @@ config HVCS
>>>           which will also be compiled when this driver is built as a
>>>           module.
>>>
>>> +config HVC_SBI
>>> +       bool "SBI console support"
>>> +       depends on RISCV
>>> +       select HVC_DRIVER
>>> +       default y
>>> +       help
>>> +         This enables support for console output via RISC-V SBI calls, which
>>> +         is normally used only during boot to output printk.
>>> +
>>> +         If you don't know what do to here, say Y.
>>> +
>>>  endif # TTY
>
> Please move this a little higher along with the other HVC_DRIVER
> implementations.

OK: https://github.com/riscv/riscv-linux/commit/1c769cad7931b7b08644d2d4a7b6985777a8e0be

>>> + * RISC-V SBI interface to hvc_console.c
>>> + *  based on drivers-tty/hvc/hvc_udbg.c
>>> + *
>>> + * Copyright (C) 2008 David Gibson, IBM Corporation
>>> + * Copyright (C) 2012 Regents of the University of California
>
> 2017?

https://github.com/riscv/riscv-linux/commit/dafa678d26886076a8a9cccc2486f1bbbfa44aa8
