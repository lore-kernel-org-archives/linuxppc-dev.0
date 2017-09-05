Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmqDc6cBczDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 00:42:08 +1000 (AEST)
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
 [209.85.216.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD9AC21E93
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:42:06 +0000 (UTC)
Received: by mail-qt0-f177.google.com with SMTP id q8so8180971qtb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 07:42:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Sep 2017 09:41:45 -0500
Message-ID: <CAL_JsqKKePqec7OER=MMSTDXTGiYiuM5jE0QWg_nUvmvQoEw4g@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux-MIPS <linux-mips@linux-mips.org>,
 Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
 Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 2, 2017 at 3:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> Since, according to a recent devicetree ML posting by Rob Herring,
> the node "/chosen@0" is most likely for real Open Firmware and does
> not apply to DTSpec, remove all remaining tests and references for
> that node, of which there are very few left:
>
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
>
> This should be innocuous as, in all of the three arch/ files above,
> there is a test for "chosen" immediately before the test for
> "chosen@0", so nothing should change.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   if this patch is premature, then just ignore it, thanks.
>
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 68f0999..c81bfd7 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -53,8 +53,7 @@ static int __init early_init_dt_scan_chosen_serial(unsigned long node,
>
>         pr_debug("%s: depth: %d, uname: %s\n", __func__, depth, uname);
>
> -       if (depth == 1 && (strcmp(uname, "chosen") == 0 ||
> -                               strcmp(uname, "chosen@0") == 0)) {
> +       if (depth == 1 && (strcmp(uname, "chosen") == 0)) {

I'd really hoped to remove early_init_dt_scan_chosen_serial()
altogether. It may now be just a matter of adding the compatible
strings to the uartlite earlycon.

Rob
