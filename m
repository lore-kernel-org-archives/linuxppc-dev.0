Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x234.google.com (mail-ua0-x234.google.com
 [IPv6:2607:f8b0:400c:c08::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Lfm15Cz2zDrq2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 20:04:49 +1000 (AEST)
Received: by mail-ua0-x234.google.com with SMTP id c3so764951uae.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 03:04:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180411091203.28141-1-npiggin@gmail.com>
References: <20180411091203.28141-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 11 Apr 2018 20:04:45 +1000
Message-ID: <CAKTCnzmsrU1WCW54ZuX=1oSGt2Pv3wSZ=NYR-692ZmzkowC0nw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/config: powernv_defconfig updates
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2018 at 7:12 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> For consideration:
>
> * Add IPv6 support built in + additional modules - Because it's 2018 maan.
> * Add DEFERRED_STRUCT_PAGE_INIT - Let's see what breaks.

We did not find any benefits with this on a P8 in terms of boot time
with large memory. May be worth reinvestigating

> * Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
> * Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.
> * Turn on FANOTIFY - This is the current filesystem notification feature.
> * Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?

Yep, should not be in defconfig, IMHO

> * Turn on async SCSI scanning - Let's see what breaks.
>
> * Make a bunch of USB hid drivers modules.
> * Make SCSI SG, SR, and FC modules - FC is huge.
> * Make video drivers (except AST GPU) modules - Also huge.
> * Add MLX5 driver as a module - Popular demand.
> * Make PCI serial driver a module - Uncommon?
>
> * Get rid of /dev/port - Not used.
> * Remove legacy BSD ttys - Long dead.
> * Remove IDE - Deprecated and replaced with ATA.
> * Remove WIRELESS - Until we get POWER9 laptops.
> * Remove RAW - Long deprecated in favour of direct IO.
> * Remove floppy, parport, and PS2 input devices - not supported.
> * Remove virtio drivers, ballooning - We're host only.

I still think its good to have them, may be as modules? Should I
switch to powerpc64le_defconfig for a single config with everything --
same kernel as guest and bare metal?

> * Remove PPP - Sorry Paulus.
> * Make more things modules, NFS FS, RAM disk, netconsole, MS-DOS fs.
>
> This does not disable FTRACE options, that's just an optimisation the
> defconfig target made. make powernv_defconfig adds those to .config.
>
> This results in a significantly smaller vmlinux:
>
>    text    data     bss     dec     hex filename
> 13121779        5284224 1383776 19789779        12df7d3 vmlinux
> 12126273        4771930 1341464 18239667        11650b3 vmlinux
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Balbir Singh.
