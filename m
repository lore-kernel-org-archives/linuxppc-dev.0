Date: Thu, 24 Dec 1998 14:57:53 +1100
Message-Id: <199812240357.OAA06229@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: davem@dm.cobaltmicro.com, linuxppc-dev@lists.linuxppc.org,
        VANDROVE@vc.cvut.cz
In-reply-to: 
	<Pine.LNX.4.03.9812231013310.18310-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Wed, 23 Dec 1998 10:14:44 +0100
	(CET))
Subject: Re: TCPv4 checksum errors
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.03.9812231013310.18310-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> In the mean time I got this from a `new' PPC hacker. I haven't tried it yet
> (still have to manually calculate checksums for my bad packets, too, sigh).

> diff -ur linux/include/asm-ppc/checksum.h linux/include/asm-ppc/checksum.h
> --- linux/include/asm-ppc/checksum.h Thu Apr 23 02:35:41 1998
> +++ linux/include/asm-ppc/checksum.h    Tue Dec 22 16:19:49 1998
> @@ -83,13 +83,13 @@
>                            unsigned int sum)
>  {
>      __asm__("
> -   add %0,%0,%1
> -   add %0,%0,%2
> -   add %0,%0,%0
> -   addi %0,%0,0
> +   addc %0,%0,%1
> +   adde %0,%0,%2
> +   adde %0,%0,%3
> +   addze %0,%0
>     "
>     : "=r" (sum)
> -   : "r" (daddr), "r"(saddr), "r"((ntohs(len)<<16)+proto*256), "0"(sum));
> +   : "r" (daddr), "r"(saddr), "r"((proto<<16)+len), "0"(sum));
>      return sum;
>  }

Aargh, I checked arch/ppc/lib/checksum.S thoroughly but I missed this
one!  Of course it needs to be addc/adde/adde/addze.  Kudos to Petr
Vandrovec (good spotting, as Linus would say).

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
