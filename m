Date: Mon, 5 Jan 2004 15:02:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC32: Add support for the OpenPIC register set to be in BE
 mode.
In-Reply-To: <200401032002.i03K23iM024298@hera.kernel.org>
Message-ID: <Pine.GSO.4.58.0401051501220.3740@waterleaf.sonytel.be>
References: <200401032002.i03K23iM024298@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Jan 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.1356.1.1, 2004/01/02 08:51:22-07:00, trini@kernel.crashing.org
>
> 	PPC32: Add support for the OpenPIC register set to be in BE mode.
>
>
> # This patch includes the following deltas:
> #	           ChangeSet	1.1356  -> 1.1356.1.1
> #	arch/ppc/kernel/open_pic.c	1.25    -> 1.26
> #
>
>  open_pic.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletion(-)
>
>
> diff -Nru a/arch/ppc/kernel/open_pic.c b/arch/ppc/kernel/open_pic.c
> --- a/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> +++ b/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> @@ -166,13 +166,21 @@
>  {
>  	u_int val;
>
> +#ifdef CONFIG_PPC_OPENPIC_BE
> +	val = in_be32(addr);
> +#else
>  	val = in_le32(addr);
> +#endif
>  	return val;
>  }

Wouldn't it be better to #define openpic_in() and openpic_out() macros, so you
need the #ifdef at one spot only?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
