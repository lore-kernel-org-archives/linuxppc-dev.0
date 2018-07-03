Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KfHT5PbSzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 19:40:21 +1000 (AEST)
Received: by mail-oi0-f51.google.com with SMTP id w126-v6so2498639oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 02:40:21 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 3 Jul 2018 11:40:07 +0200
Message-ID: <CA+7wUsxznwK8fztA+2TAWJL9nEHek_tyUcDm9HCvy-4MdvpAWQ@mail.gmail.com>
Subject: CONFIG_LD_DEAD_CODE_DATA_ELIMINATION: Section mismatch in reference
 from the variable via_pmu_driver to the function .init.text:pmu_init()
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

Would you consider this a bug:

$ touch drivers/macintosh/via-pmu.c
$ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n make ARCH=powerpc
CROSS_COMPILE=powerpc-linux-gnu-
...
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0x216018): Section mismatch in reference from
the variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

While:

$ touch drivers/macintosh/via-pmu.c
$ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y make ARCH=powerpc
CROSS_COMPILE=powerpc-linux-gnu-
...
  AR      init/built-in.a
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
...

Thanks for comment
