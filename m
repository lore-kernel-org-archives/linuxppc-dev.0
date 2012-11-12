Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5DE32C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 08:02:49 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id f13so6458716vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2012 13:02:47 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1352753886-3402-1-git-send-email-geert@linux-m68k.org>
References: <1352753886-3402-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 12 Nov 2012 22:02:46 +0100
Message-ID: <CAMuHMdXE0yJNivpirGgx08zqLH2086ydeOU6zswXj-+zn8OsWQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.7-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, ceph-devel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 12, 2012 at 9:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7-rc5 to v3.7-rc4[3], the summaries are:
>   - build errors: +14/-4

14 regressions:
  + drivers/virt/fsl_hypervisor.c: error: 'MSR_GS' undeclared (first
use in this function):  => 799:93
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A
  + net/ceph/ceph_common.c: error: dereferencing pointer to incomplete
type:  => 272:13
  + net/ceph/ceph_common.c: error: implicit declaration of function
'request_key' [-Werror=implicit-function-declaration]:  => 249:2
  + net/ceph/crypto.c: error: dereferencing pointer to incomplete
type:  => 463:19, 434:46, 452:5, 448:52, 429:23, 467:36, 447:18
  + net/ceph/crypto.c: error: implicit declaration of function
'key_payload_reserve' [-Werror=implicit-function-declaration]:  =>
437:2
  + net/ceph/crypto.c: error: implicit declaration of function
'register_key_type' [-Werror=implicit-function-declaration]:  => 481:2
  + net/ceph/crypto.c: error: implicit declaration of function
'unregister_key_type' [-Werror=implicit-function-declaration]:  =>
485:2
  + net/ceph/crypto.c: error: unknown field 'destroy' specified in
initializer:  => 477:2
  + net/ceph/crypto.c: error: unknown field 'instantiate' specified in
initializer:  => 475:2
  + net/ceph/crypto.c: error: unknown field 'match' specified in
initializer:  => 476:2
  + net/ceph/crypto.c: error: unknown field 'name' specified in
initializer:  => 474:2
  + net/ceph/crypto.c: error: variable 'key_type_ceph' has initializer
but incomplete type:  => 473:8

powerpc-randconfig

  + error: relocation truncated to fit: R_PPC64_REL24 against symbol
`._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o:
(.text+0x1ff9eb8) => (.text+0x1ffa274), (.text+0x1ff7840)

powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5614/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5600/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
