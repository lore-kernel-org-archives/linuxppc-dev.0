Date: Wed, 9 Dec 1998 11:34:25 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: VALETTE Eric <valette@crf.canon.fr>
cc: alois_fertl@muenchen.europe.mcd.mot.com, linuxppc-dev@lists.linuxppc.org,
        cort@cs.nmt.edu
Subject: Re: Linux-2.1.129 boot on MCP750
In-Reply-To: <m0ziEf0-0000WUC@tri-yann.crf.canon.fr>
Message-ID: <Pine.HPP.3.96.981209113258.17076Y-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 24 Nov 1998, VALETTE Eric wrote:

> 
> >>>>> "Alois" == Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com> writes:
> 
> Thanks to your patch sugested for misc.c I'm now able to decompress
> the 2.1.129 kernel.
> 
> -----Patch included here (not from me but from Corey Minyard <minyard@acm.org>)--------------
> diff -urN linux-pmac-2.1.127.old/arch/ppc/boot/misc.c linux-pmac-2.1.127/arch/ppc/boot/misc.c
> --- linux-pmac-2.1.127.old/arch/ppc/boot/misc.c	Sun Sep 20 06:43:04 1998
> +++ linux-pmac-2.1.127/arch/ppc/boot/misc.c	Fri Nov 13 11:34:50 1998
> @@ -451,7 +451,11 @@
>  	 * insufficient memory.  In this case we don't have initrd either,
>  	 * so use that as an indicator.  -- Dan
>  	 */
> +#ifdef CONFIG_MBX
>  	if (( (unsigned long)zimage_start <= 0x01000000 ) && initrd_start)
> +#else
> +	if ( (unsigned long)zimage_start <= 0x01000000 )
> +#endif
>  	{
>  		memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-zimage_size),
>  			(void *)zimage_start, zimage_size );	
> @@ -478,7 +482,7 @@
>  		 * max ram is.
>  		 * -- Cort
>  		 */
> -#if 0		
> +#ifndef CONFIG_MBX
>  		memcpy ((void *)PAGE_ALIGN(-PAGE_SIZE+(unsigned long)end_avail-INITRD_SIZE),
>  			(void *)initrd_start,
>  			INITRD_SIZE );
> 
> -----------------------------------------------------------------------------------------------
> 
> Unfortunately, I still have problems as shown by the
> following trace :
> 
> 	  1) Apparently I have problem with Raven chipset initialization regarding
> 	  interrupt management/mapping (all chip detection see a irq 0)
> 	  2) I also have problem with the NCR53c825 initialization
> 	  as it does not find the right irq nor detect the scsi disk
> 	  I have attached,
> 
> I have a side question : readding the source code, the RAVEN chipset that
> is present on MVME2700 and MPC750 is managed only in the case of CHRP 
> architecture. So shall I add code to dynamically detect mtorola hardware
> and switch machine to MACH_chrp ?

I wannted to do something like this to enable very large windows on the
VME bus through the Universe. I think we should communnicate privately and
fast in this area unntil we converge towards a working solution...

	Gabriel.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
