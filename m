Message-Id: <200012290016.SAA25126@lists.linuxppc.org>
Date: Thu, 28 Dec 2000 19:16:41 -0500
From: jingai <jingai@floatingpenguins.com>
To: "debian-powerpc" <debian-powerpc@lists.debian.org>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Re: Status of PCI-PCI bridge on UMAX S900
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> just a short followup to the message i sent to debian-powerpc, i applied
> the following diff and was able to move my usb board to the other side of
the
>
> umax/s900 bridge w/o any ill effect:
>
> --- prom.c.000  Thu Dec 28 08:43:12 2000
> +++ prom.c      Thu Dec 28 09:06:16 2000
> @@ -1563,8 +1563,8 @@
>         }
>
>         ip = (int *) get_property(np, "AAPL,interrupts", &l);
> -       if (ip == 0)
> -               ip = (int *) get_property(np, "interrupts", &l);
> +       if (ip == 0 && np->parent != NULL)
> +               ip = (int *) get_property(np->parent, "AAPL,interrupts",
> &l);
>         if (ip != 0) {
>                 np->intrs = (struct interrupt_info *) mem_start;
>                 np->n_intrs = l / sizeof(int);

Doh!  I didn't even think to check if the second get_property() call
was returning > 0.. this fixes it!  Thanks bunches for spotting that!

> on a related, note, shouldnt the 'right' code be:
>
>     ip = (int *) get_property(np, "interrupts", &l);
>     if (ip > 0)
>     {
>         /* find and assign interrupt -- see above */
>     }
>
> pci boards should only get an interrupt if they have the interrupt
> property (which seems to be the number of interrupts, not the interrupt
number)

Seems correct to me, but I'm no kernel guru, so I'll let someone else
answer
authoritatively.

-j


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
