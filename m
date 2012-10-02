Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E8C82C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 04:38:53 +1000 (EST)
Received: by vcbf13 with SMTP id f13so6881389vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2012 11:38:50 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1349202763-1601-1-git-send-email-geert@linux-m68k.org>
References: <1349202763-1601-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 2 Oct 2012 20:38:50 +0200
Message-ID: <CAMuHMdXcMVkcqTJdH2zdo9=a2efeeQmPGUr9GZqRMuRrAuMBvw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Chris Zankel <chris@zankel.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 2, 2012 at 8:32 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.6 to v3.6-rc7[3], the summaries are:
>   - build errors: +4/-1

  + arch/powerpc/platforms/512x/mpc512x_shared.c: error:
'FSL_DIU_PORT_DVI' undeclared (first use in this function):  => 189:9
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: parameter 1
('port') has incomplete type:  => 187:54, 83:56, 88:57, 69:56
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: return type
is an incomplete type:  => 187:1

powerpc-randconfig

  + drivers/net/ethernet/realtek/r8169.c: error: expected identifier
before numeric constant:  => 451:2

xtensa-allmodconfig (hmm, this is not a new one, it felt through the
cracks in -rc7 because
of log line interleaving).

Ugh, arch/xtensa/include/asm/regs.h defines way to generic symbols,
like "MISC" (which
causes the above breakage), and even a few 2-letter symbols, which
surprisingly don't
cause conflicts...

> [1] http://kisskb.ellerman.id.au/kisskb/head/5469/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5445/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
