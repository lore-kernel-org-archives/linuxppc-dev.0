Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCLh23njDzDvQr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 05:34:26 +1100 (AEDT)
Received: by mail-wm0-f67.google.com with SMTP id u144so17951417wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 10:34:26 -0800 (PST)
Date: Mon, 7 Nov 2016 20:33:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
Message-ID: <20161107183326.GA8329@kozik-lap>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdV4HG0aOr4Qp_OZXU=3jLeOJ2QaMKp09a3v4489ABbRcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMuHMdV4HG0aOr4Qp_OZXU=3jLeOJ2QaMKp09a3v4489ABbRcA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2016 at 10:35:31AM +0100, Geert Uytterhoeven wrote:
> On Mon, Oct 31, 2016 at 12:30 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Some Renesas SoCs may exist in different revisions, providing slightly
> > different functionalities (e.g. R-Car H3 ES1.x and ES2.0), and behavior
> > (errate and quirks).  This needs to be catered for by drivers and/or
> > platform code.  The recently proposed soc_device_match() API seems like
> > a good fit to handle this.
> >
> > This patch series implements the core infrastructure to provide SoC and
> > revision information through the SoC bus for Renesas ARM SoCs. It
> > consists of 7 patches:
> >   - Patches 1-4 provide soc_device_match(), with some related fixes,
> >   - Patches 5-7 implement identification of Renesas SoCs and
> >     registration with the SoC bus,
> >
> > Changes compared to v1:
> >   - Add Acked-by,
> >   - New patches:
> >       - "[4/7] base: soc: Provide a dummy implementation of
> >                soc_device_match()",
> >       - "[5/7] ARM: shmobile: Document DT bindings for CCCR and PRR",
> >       - "[6/7] arm64: dts: r8a7795: Add device node for PRR"
> >         (more similar patches available, I'm not yet spamming you all
> >          with them),
> >   - Drop SoC families and family names; use fixed "Renesas" instead,
> >   - Drop EMEV2, which doesn't have a chip ID register, and doesn't share
> >     devices with other SoCs,
> >   - Drop RZ/A1H and R-CAR M1A, which don't have chip ID registers (for
> >     M1A: not accessible from the ARM core?),
> >   - On arm, move "select SOC_BUS" from ARCH_RENESAS to Kconfig symbols
> >     for SoCs that provide a chip ID register,
> >   - Build renesas-soc only if SOC_BUS is enabled,
> >   - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
> >     available, else fall back to hardcoded addresses for compatibility
> >     with existing DTBs,
> >   - Remove verification of product IDs; just print the ID instead,
> >   - Don't register the SoC bus if the chip ID register is missing,
> >   - Change R-Mobile APE6 fallback to use PRR instead of CCCR (it has
> >     both).
> >
> > Merge strategy:
> >   - In theory, patches 1-4 should go through Greg's driver core tree.
> >     But it's a hard dependency for all users.
> >     If people agree, I can provide an immutable branch in my
> >     renesas-drivers repository, to be merged by all interested parties.
> >     So far I'm aware of Freescale/NXP, and Renesas.
> 
> And Samsung.

Yes, I would need it as well.

> Shall I create the immutable branch now?

...or the applying person could provide one.

Best regards,
Krzysztof
