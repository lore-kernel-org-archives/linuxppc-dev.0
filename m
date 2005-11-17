Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id C6D8568778
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 10:24:33 +1100 (EST)
Message-ID: <437D0A21.4090803@smiths-aerospace.com>
Date: Thu, 17 Nov 2005 17:54:25 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
CC: linuxppc-dev@ozlabs.org
References: <20051117210902.GB31775@suse.de>
In-Reply-To: <20051117210902.GB31775@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> Replacing the string labels with numbers saves 117 bytes in the final zImage.
> These local labels are not discared.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  arch/powerpc/boot/crt0.S |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/crt0.S
> ===================================================================
> --- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/crt0.S
> +++ linux-2.6.15-rc1-olh/arch/powerpc/boot/crt0.S
> @@ -14,43 +14,42 @@
>  	.text
>  	.globl	_zimage_start
>  _zimage_start:
> -	bl	reloc_offset
> +	bl	1f
>  
> -reloc_offset:
> +1:
>  	mflr	r0
> -	lis	r9,reloc_offset@ha
> -	addi	r9,r9,reloc_offset@l
> +	lis	r9,1b@ha
> +	addi	r9,r9,1b@l
>  	subf.	r0,r9,r0
> -	beq	clear_caches
> +	beq	3f

[snip]

OK, I've waited for someone dumber than me to ask, but I guess I'm the 
bottom guy on the totem pole here.

How does changing a local ascii label to a temporary label _but using 
the same machine instructions_ affect the output image size????  Why 
would "lis r9,reloc_offset@ha" generate a smaller (!) instruction than 
"lis r9,1b@ha"????

My first thought was that the symbol section of the ELF output is 
bigger, but the labels are not globals.  Even if the local labels end up 
in the symbol section (which the comment on the original patch message 
sort of implies), that isn't going to make a (stripped) binary any 
bigger.  If that is the case, isn't a better cure to strip the ELF file?

While I'm being dumb, I gotta ask, how big is zImage and why does 117 
bytes make a difference?

My 2c: if you are going to use inscrutable labels (1,2,3,4), please put 
comments in.  At least the previous labels gave hints as to what was 
happening.

Puzzled,
gvb
