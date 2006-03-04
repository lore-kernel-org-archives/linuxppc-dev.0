Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A96C7679FD
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 23:58:35 +1100 (EST)
Date: Sat, 4 Mar 2006 13:58:30 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] correct cacheflush loop in zImage
Message-ID: <20060304125830.GB30106@suse.de>
References: <20060304121540.GA30106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060304121540.GA30106@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Mar 04, Olaf Hering wrote:

> 
> Correct the loop for cacheflush. No idea where I copied the code from,
> but the original does not work correct. Maybe the flush is not needed.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  arch/powerpc/boot/crt0.S |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.16-rc5-olh/arch/powerpc/boot/crt0.S
> ===================================================================
> --- linux-2.6.16-rc5-olh.orig/arch/powerpc/boot/crt0.S
> +++ linux-2.6.16-rc5-olh/arch/powerpc/boot/crt0.S
> @@ -45,7 +45,8 @@ _zimage_start:
>  	bdnz	2b
>  
>  	/* Do a cache flush for our text, in case OF didn't */
> -3:	lis	r9,_start@h
> +3:	lis	r9,_start@ha
> +	addi	r9,r9,_start@l
>  	add	r9,r0,r9

I think this part is not required. Segments must be 64k aligned, so the
lower bits will be always zero (modulo the _start offset into .text)
