Date: Mon, 15 Apr 2002 18:59:54 -0600
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Allow OpenPIC irq 0 to be used
Message-ID: <20020415185954.J17647@boardwalk>
References: <20020415134322.E15153@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020415134322.E15153@boardwalk>; from val@nmt.edu on Mon, Apr 15, 2002 at 01:43:22PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hm, in retrospect, I didn't state the actual bug very clearly.  On
Synergy boards, devices can't get interrupts on irq 0 because it is
never initialized.  This patch fixes that, hopefully without
introducing bugs in other boards.

-VAL

On Mon, Apr 15, 2002 at 01:43:22PM -0600, Val Henson wrote:
>
> Synergy boards do not have an i8259 hooked up to irq 0, instead we
> actually use it as a normal irq line.  Yes, I know, bad idea, but
> we're stuck with it.  The following patch is ugly, but illustrates the
> general idea in a way which might possibly be compatible with other
> OpenPIC boards.
>
> -VAL
>
> ===== arch/ppc/kernel/open_pic.c 1.47 vs edited =====
> --- 1.47/arch/ppc/kernel/open_pic.c	Tue Feb  5 03:10:24 2002
> +++ edited/arch/ppc/kernel/open_pic.c	Mon Apr 15 13:42:12 2002
> @@ -366,7 +366,7 @@
>  	}
>
>  	/* Init all external sources */
> -	for (i = 1; i < NumSources; i++) {
> +	for (i = offset ? 1 : 0; i < NumSources; i++) {
>  		int pri, sense;
>
>  		if (ISR[i] == 0)
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
