Message-ID: <3AAB1146.C39B35A1@mvista.com>
Date: Sat, 10 Mar 2001 21:46:46 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: David Blythe <blythe@routefree.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU_init buglet in 2.4.0-mvista_010216
References: <3AAB06CC.F5E5A5BA@routefree.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Blythe wrote:
>
> memory sizes > 16M but not a multiple of 16M not quite right.  for the
> 24M config i was playing with it manifests itself as a tlb miss/kernel
> stack overflow.
>
> patch attached.
>         david
>
>   ------------------------------------------------------------------------------------------------------------------------------------
> Index: arch/ppc/mm/init.c
> ===================================================================
> diff -u -r1.1.1.4 init.c
> --- arch/ppc/mm/init.c  2001/02/21 00:52:57     1.1.1.4
> +++ arch/ppc/mm/init.c  2001/03/11 04:52:27
> @@ -1015,7 +1015,7 @@
>         /* -----  pin 4MB chunks of memory  ----- */
>
>         if (size_pinned < size_DRAM) {
> -               pinned_tlbs = ((size_DRAM - size_pinned) / SIZE_4MB);
> +               pinned_tlbs += ((size_DRAM - size_pinned) / SIZE_4MB);
>
>                 if (pinned_tlbs > PPC4xx_MAX_PINNED_TLB) {
>                         printk(KERN_ERR "MMU_init(): memory configuration requires %d tlb entries.\n",

Thank you David, I merged your fix.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
