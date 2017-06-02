Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfP0p0NzTzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:39:22 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id d68so10957728ita.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 05:39:21 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170222190235.92E5F661CEB@gitolite.kernel.org>
References: <20170222190235.92E5F661CEB@gitolite.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Jun 2017 14:39:19 +0200
Message-ID: <CAMuHMdWGZYkM_aQ=vXr5J9-KFGzzWgq3hf+ZRY-n-+8-ghG5nQ@mail.gmail.com>
Subject: Re: powerpc/opal-irqchip: Use interrupt names if present
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Wed, Feb 22, 2017 at 8:02 PM, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Web:        https://git.kernel.org/torvalds/c/2717a33d60745f2f72e521cdaedf79b00f66f8ca
> Commit:     2717a33d60745f2f72e521cdaedf79b00f66f8ca
> Parent:     470a36a8c014e5cac7bb2df382948597f7ec1b2c
> Refname:    refs/heads/master
> Author:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
> AuthorDate: Mon Feb 6 16:07:36 2017 +1100
> Committer:  Michael Ellerman <mpe@ellerman.id.au>
> CommitDate: Thu Feb 9 10:31:37 2017 +1100
>
>     powerpc/opal-irqchip: Use interrupt names if present
>
>     Recent versions of OPAL can provide names for the various OPAL interrupts,
>     so let's use them. This also modernises the code that fetches the
>     interrupt array to use the helpers provided by the generic code instead
>     of hand-parsing the property.
>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     [mpe: Free irqs on error, check allocation of names, consolidate error
>           handling, whitespace.]
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/powernv/opal-irqchip.c | 55 ++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
> index 998316bf2dad..ecdcba9d1220 100644
> --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
> +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
> @@ -183,8 +183,9 @@ void opal_event_shutdown(void)

> +       /* It's not an error for the names to be missing */
> +       of_property_read_string_array(opal_node, "opal-interrupts-names",
> +                                     names, opal_irq_count);

Just double-checking, as it's different from the standard "interrupt-names":
is "opal-interrupts-names" the correct name?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
