Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjLWy35pmzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 17:58:06 +1000 (AEST)
Received: by mail-ot0-x242.google.com with SMTP id a2so460651oth.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 00:58:06 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAMuHMdVwzQ11QycQTTc2-=-e+fRJCvANpsQ6xO_qwnvUFcKnyQ@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-13-palmer@dabbelt.com>
 <CAMuHMdVwzQ11QycQTTc2-=-e+fRJCvANpsQ6xO_qwnvUFcKnyQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Jun 2017 09:58:04 +0200
Message-ID: <CAK8P3a35SEeOaVXBNCzUiwQTXys4MZN28d4yVRqNQ=Jz=Z-EWw@mail.gmail.com>
Subject: Re: [PATCH 12/17] tty: New RISC-V SBI Console Driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, albert@sifive.com,
 patches@groups.riscv.org, Greg KH <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>,
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

On Wed, Jun 7, 2017 at 9:15 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC (hypervisor) console folks
>
> On Wed, Jun 7, 2017 at 1:00 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> This patch adds a new driver for the console availiable via the RISC-V
>> SBI.  This console is specified to be used for early boot messages, and
>> is designed to be a very simple (albiet somewhat slow) console that is
>> always availiable.  All RISC-V systems have an SBI console.
>>
>> The SBI console is made availiable for early printk messages and is also
>> availiable as a regular console.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  drivers/tty/hvc/Kconfig   |  11 +++++
>>  drivers/tty/hvc/Makefile  |   1 +
>>  drivers/tty/hvc/hvc_sbi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 114 insertions(+)
>>  create mode 100644 drivers/tty/hvc/hvc_sbi.c
>>
>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index 574da15fe618..f3774adab240 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -114,4 +114,15 @@ config HVCS
>>           which will also be compiled when this driver is built as a
>>           module.
>>
>> +config HVC_SBI
>> +       bool "SBI console support"
>> +       depends on RISCV
>> +       select HVC_DRIVER
>> +       default y
>> +       help
>> +         This enables support for console output via RISC-V SBI calls, which
>> +         is normally used only during boot to output printk.
>> +
>> +         If you don't know what do to here, say Y.
>> +
>>  endif # TTY

Please move this a little higher along with the other HVC_DRIVER
implementations.

>> + * RISC-V SBI interface to hvc_console.c
>> + *  based on drivers-tty/hvc/hvc_udbg.c
>> + *
>> + * Copyright (C) 2008 David Gibson, IBM Corporation
>> + * Copyright (C) 2012 Regents of the University of California

2017?

        Arnd
