Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4ED6DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:02:43 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ME0a81032245
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 10:00:36 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MF2dgP554090
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 11:02:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MF2cko027264
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 11:02:38 -0400
Subject: Re: [PATCH] powerpc: Fix powerpc vmlinux.lds.S
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1179808385.32247.791.camel@localhost.localdomain>
References: <1179808385.32247.791.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 May 2007 10:01:44 -0500
Message-Id: <1179846105.16032.75.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-22-05 at 14:33 +1000, Benjamin Herrenschmidt wrote:
> Sam's recent changes broke things for us, some stuff sneaked in before
> the entry point. In fact, we don't need that *(.text.*) thing anymore
> and it incorrectly matched .text.init.refok, thus putting it
> before .text. .. ouch !

..  Which manifests itself on some systems as a hang after 
"returning from prom_init".  


> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applying this makes my systems happy again... :-)

Acked-by:  Will Schmidt <will_schmidt@vnet.ibm.com>


> ---
> 
> Index: linux-work/arch/powerpc/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/vmlinux.lds.S	2007-05-22 14:16:39.000000000 +1000
> +++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2007-05-22 14:19:00.000000000 +1000
> @@ -34,7 +34,6 @@ SECTIONS
>  	/* Text and gots */
>  	.text : {
>  		_text = .;
> -		*(.text.*)
>  		TEXT_TEXT
>  		SCHED_TEXT
>  		LOCK_TEXT
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
