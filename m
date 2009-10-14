Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f218.google.com (mail-gx0-f218.google.com
	[209.85.217.218]) by ozlabs.org (Postfix) with ESMTP id 4871DB7043
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 05:35:06 +1100 (EST)
Received: by gxk10 with SMTP id 10so80077gxk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 11:35:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <a9e38f55dcc6487125ca1ab1f455b58d565fd397.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<a9e38f55dcc6487125ca1ab1f455b58d565fd397.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:34:44 -0600
Message-ID: <fa686aa40910141134x7c74bbbahe61c8b031ad5db62@mail.gmail.com>
Subject: Re: [PATCH 4/6] powerpc: Make virq_debug_show() cope with sparse
	irq_descs
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2009 at 11:44 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/irq.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 6563221..baa49eb 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -1065,8 +1065,11 @@ static int virq_debug_show(struct seq_file *m, voi=
d *private)
> =A0 =A0 =A0 =A0seq_printf(m, "%-5s =A0%-7s =A0%-15s =A0%s\n", "virq", "hw=
irq",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"chip name", "host name");
>
> - =A0 =A0 =A0 for (i =3D 1; i < NR_IRQS; i++) {
> + =A0 =A0 =A0 for (i =3D 1; i < nr_irqs; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc =3D irq_to_desc(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!desc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&desc->lock, flags);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc->action && desc->action->handler)=
 {
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
