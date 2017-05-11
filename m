Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNvM81HftzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 23:38:27 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id y128so3662039qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 06:38:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3052456.ktpuaNmngy@sherry>
References: <2666241.ms6yMRjznt@sherry> <41499955.CTp69um5pn@sherry>
 <1493931328.25397.35.camel@buserror.net> <3052456.ktpuaNmngy@sherry>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 11 May 2017 23:38:24 +1000
Message-ID: <CAOSf1CE6hvRD1Q_TXzdGoCRsGxq2yYLiunTGaFKbvx1rhAwbcw@mail.gmail.com>
Subject: Re: [PATCH] Freescale mpc8315 interrupt chip
To: schindele@nentec.de
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 11, 2017 at 10:34 PM, Juergen Schindele <schindele@nentec.de> wrote:
> Next try to submit two patches for Freescale mpc8315.
>
> first one
> -----------------------------------------------------------------------------------
> powerpc/ipic: Configure "EDGE" capabilities for IRQ0 too (like IRQ1-7)
> Signed-off-by: Jurgen Schindele <schindele@nentec.de>
>
> The external IRQ0 has the same capabilities as the other IRQ1-7 and is
> handeled by the same register IPIC_SEPNR. When this register for "ack"
> is not setup in "ipic_info" you can not configure this IRQ for
> IRQ_TYPE_EDGE_FALLING. This is probably due to the non-continued number
> of IRQ0 in the Freescale hwirq number mapping.
>
> --- linux-4.11/arch/powerpc/sysdev/ipic.c.orig  2017-05-11 13:40:43.874801534
> +0200
> +++ linux-4.11/arch/powerpc/sysdev/ipic.c       2017-05-11 14:05:06.336610289
> +0200
> @@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] = {
>                 .prio_mask = 7,
>         },
>         [48] = {
> +               .ack    = IPIC_SEPNR,
>                 .mask   = IPIC_SEMSR,
>                 .prio   = IPIC_SMPRR_A,
>                 .force  = IPIC_SEFCR,
>
> second one
> -----------------------------------------------------------------------------------------

> powerpc/ipic: Precise ERR printk when "ipic_set_irq_type" fails
> Signed-off-by: Jurgen Schindele <schindele@nentec.de>

The Signed-off-by: goes after the commit message. So rather than being here:
| >
| > When you setup an interrupt of a certain type on this interrupt-controler
| > which is not supported on this hardware you will get an error log but you
| > dont know which interrupt was the cause.
| > With this patch you are able to localize the source of failure.
|
\---> you want it down here

>
> --- linux-4.11/arch/powerpc/sysdev/ipic.c.orig  2017-05-11 14:08:07.098824986
> +0200
> +++ linux-4.11/arch/powerpc/sysdev/ipic.c       2017-05-11 14:10:51.010934755
> +0200
> @@ -611,14 +611,14 @@ static int ipic_set_irq_type(struct irq_
>         /* ipic supports only low assertion and high-to-low change senses
>          */
>         if (!(flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))) {
> -               printk(KERN_ERR "ipic: sense type 0x%x not supported\n",
> -                       flow_type);
> +               printk(KERN_ERR "ipic: sense type 0x%x not supported on "
> +                       "interrupt %d\n", flow_type, src);
>                 return -EINVAL;
>         }
>         /* ipic supports only edge mode on external interrupts */
>         if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !ipic_info[src].ack) {
>                 printk(KERN_ERR "ipic: edge sense not supported on internal "
> -                               "interrupts\n");
> +                               "interrupt %d\n", src);

While you're here might as well change these from the old style
"printk(KERN_ERR" to the new style "pr_err()"

>                 return -EINVAL;
>
>         }
>

> I hope i respected all patch requirements ;-)

It's an interesting take on the rules, but it needs a bit of work.
We're pedantic about patch formatting, etc because we have tools for
handling patches that require strict formatting in order to function
(e.g https://patchwork.ozlabs.org/project/linuxppc-dev/list/). The
easiest way to ensure you get the formatting right is to use git to
generate the patch files for you, so:

First of all grab a kernel git tree (warning: it's big):
$ git clone https://github.com/torvalds/linux.git

Once it's done, make your changes inside of the git tree. You can run
"git diff" to get a diff between what has been commited in the tree
and what's in the filesystem. To start turning your changes into
patches use:
$ git add -p

NB: you can see what's been staged so fair with:
 $ git diff --staged

When you're happy with the staged changes commit them with:
$ git commit

This will give you a text editor where you can enter the commit
message. You can skip the signed-off-by for now. You'll probably get
yelled at by git for not having a name or an email. You should do what
it says to set those up so your name appears correctly in the patch.

Once you've done all that you should see two commits in:
$ git log

To finish generate the actual patch files with:
$ git format-patch -s HEAD~2

You can (in theory) use any email client to send patches. In practice
most clients are bad at handling whitespace and will do things like
turn tabs into spaces which breaks the diffs. The easiest way get it
right is to use git's email sending plugin. send-email isn't part of
the standard git package so you'll probably need to install and
configure it to use your local SMTP server. It's well worth the hassle
though.
$ git send-email --to=linuxppc-dev@lists.ozlabs.org <patch files go here>

Hope all that helps. There are much better git tutorials out there
than some idiot of the linuxppc-dev mailing list, but that should be
enough to get you started.
Oliver
